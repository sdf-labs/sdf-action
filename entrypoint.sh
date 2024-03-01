#!/bin/bash -l

source /.venv/bin/activate

echo "workspace dir set as: \"${WORKSPACE_DIR}\""
cd ${WORKSPACE_DIR}

input_command=$1
input_is_dbt=$2

# Check if the variable starts with 'sdf push'
if [[ $input_command == "sdf push"* ]]; then
  echo "'sdf push' runs 'sdf auth login' using headless credentials"
  sdf auth login --access-key "${ACCESS_KEY}" --secret-key "${SECRET_KEY}"
fi

if [[ -n $input_is_dbt ]]; then
  echo "::group::Setting up dbt"
  echo "running dbt deps"
  dbt deps

  echo "running dbt compile"
  dbt compile

  echo "running dbt compile done"
  sdf dbt refresh
  echo "::endgroup::"
fi

# run sdf auth login snwoflake if necessary
snowflake_provider=$(yq .provider.type workspace.sdf.yml | grep snowflake | tail -1)
if [[ -n $snowflake_provider ]]; then
  echo "snowflake provider used: running 'sdf auth login'"
  sdf auth login snowflake \
    --account-id "${SNOWFLAKE_ACCOUNT_ID}" --username "${SNOWFLAKE_USERNAME}" --password "${SNOWFLAKE_PASSWORD}" \
    --role "${SNOWFLAKE_ROLE}" --warehouse "${SNOWFLAKE_WAREHOUSE}"
fi

# run and save outputs
echo "running command: $input_command"
{
  echo 'log<<EOF'
  echo "$log"
  echo EOF
} >>$GITHUB_OUTPUT
log=$($input_command 2>&1)
if [ $? -eq 0 ]; then
  echo "result=passed" >>$GITHUB_OUTPUT
else
  echo "result=failed" >>$GITHUB_OUTPUT
  exit 1
fi
