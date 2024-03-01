#!/bin/bash -l

set -eo pipefail

source /.venv/bin/activate

echo "workspace dir set as: \"${WORKSPACE_DIR}\""
cd ${WORKSPACE_DIR}

# Check if the variable starts with 'sdf push'
if [[ $1 == "sdf push"* ]]; then
  echo "'sdf push' runs 'sdf auth login' using headless credentials"
  sdf auth login --access-key "${ACCESS_KEY}" --secret-key "${SECRET_KEY}"
fi

echo "running dbt compile and sdf dbt refresh"
echo "DBT_TARGET=${DBT_TARGET}"
echo "SNOWFLAKE_ACCOUNT_ID=${SNOWFLAKE_ACCOUNT_ID}"
echo "SNOWFLAKE_USERNAME=${SNOWFLAKE_USERNAME}"
dbt deps
dbt compile
sdf dbt refresh

# run sdf auth login snwoflake if necessary
provider_type=$(yq .provider.type workspace.sdf.yml | grep snowflake)
echo "provider_type=${provider_type}"
# Check if provider type is empty (indicating end of documents)
if [[ $provider_type == "\"snowflake\"" ]]; then
  echo "snowflake provider used: running 'sdf auth login'"
  sdf auth login snowflake \
    --account-id "${SNOWFLAKE_ACCOUNT_ID}" --username "${SNOWFLAKE_USERNAME}" --password "${SNOWFLAKE_PASSWORD}" \
    --role "${SNOWFLAKE_ROLE}" --warehouse "${SNOWFLAKE_WAREHOUSE}"
fi

LOG_FILE="output.${GITHUB_RUN_ID}.txt"
LOG_PATH="${WORKSPACE_DIR}/${LOG_FILE}"
echo "LOG_PATH=${LOG_PATH}" >>$GITHUB_ENV
echo "saving output in \"${LOG_PATH}\""
$1 2>&1 | tee "${LOG_FILE}"
if [ $? -eq 0 ]; then
  echo "RUN_STATE=passed" >>$GITHUB_ENV
  echo "result=passed" >>$GITHUB_OUTPUT
  echo "SDF run OK" >>"${LOG_FILE}"
else
  echo "RUN_STATE=failed" >>$GITHUB_ENV
  echo "result=failed" >>$GITHUB_OUTPUT
  echo "SDF run failed" >>"${LOG_FILE}"
  exit 1
fi
