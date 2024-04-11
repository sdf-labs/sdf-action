#!/bin/bash -l

echo "workspace dir set as: \"${WORKSPACE_DIR}\""
cd ${WORKSPACE_DIR}

echo "ls -l ./target"
ls -l ./target

input_command=$1
input_is_dbt=$2

check_exit_status() {
  exit_status=$1
  command_log=$2
  echo "checking exit status: $exit_status"
  if [ $exit_status -ne 0 ]; then
    # Log the error message to GitHub output
    {
      echo 'log<<EOF'
      echo "Command failed with status $exit_status"
      echo "$command_log"
      echo EOF
    } >>$GITHUB_OUTPUT

    echo "result=failed" >>$GITHUB_OUTPUT
    exit $exit_status
  fi
}

# Check if the variable starts with 'sdf push'
if [[ $input_command == "sdf push"* ]]; then
  echo "'sdf push' runs 'sdf auth login' using headless credentials"
  sdf auth login --access-key "${ACCESS_KEY}" --secret-key "${SECRET_KEY}"
  check_exit_status $? ""
fi

if [[ -n $input_is_dbt ]]; then
  echo "::group::Setting up dbt"
  echo "running dbt compile done"
  sdf dbt refresh
  echo "::endgroup::"
  check_exit_status $? ""
fi

# run sdf auth login snwoflake if necessary
snowflake_provider=$(yq .provider.type workspace.sdf.yml | grep snowflake | tail -1)
if [[ -n $snowflake_provider ]]; then
  echo "snowflake provider used: running 'sdf auth login'"
  sdf auth login snowflake \
    --account-id "${SNOWFLAKE_ACCOUNT_ID}" --username "${SNOWFLAKE_USERNAME}" --password "${SNOWFLAKE_PASSWORD}" \
    --role "${SNOWFLAKE_ROLE}" --warehouse "${SNOWFLAKE_WAREHOUSE}"
  check_exit_status $? ""
fi

# run and save outputs
echo "running command: $input_command"
log=$($input_command 2>&1)
exit_status=$?
echo "$log"
check_exit_status $exit_status "$log"

{
  echo 'log<<EOF'
  echo "$log"
  echo EOF
} >>$GITHUB_OUTPUT
echo "result=passed" >>$GITHUB_OUTPUT
