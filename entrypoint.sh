#!/bin/bash -l

input_command=$1
input_is_dbt=$2
sdf_version=$3

is_less_semvar() {
  # split the version strings into arrays
  IFS='.' read -ra version1 <<<"$1"
  IFS='.' read -ra version2 <<<"$2"

  i=0
  while true; do
    v1="${version1[$i]:-0}"
    v2="${version2[$i]:-0}"

    # compare numerically
    if ((v1 < v2)); then
      echo 1
      return
    elif ((v1 > v2)); then
      echo 0
      return
    fi
    ((i++))

    # run out of components to compare
    if [[ -z "${version1[$i]}" && -z "${version2[$i]}" ]]; then
      echo 0
      return
    fi
  done
}

min_version=$(curl https://api.sdf.com/api/v2/public.minVersion | jq -r '.result.data.json')
if [[ $(is_less_semvar $sdf_version $min_version) -eq 1 ]]; then
  echo "The input SDF CLI version is lower than the minimum required version: $min_version"
  exit 1
fi

if [ "$(uname -m)" = "aarch64" ]; then
  curl -LSfs https://cdn.sdf.com/releases/download/install.sh | bash -s -- --version ${sdf_version} --target aarch64-unknown-linux-gnu
else
  curl -LSfs https://cdn.sdf.com/releases/download/install.sh | bash -s -- --version ${sdf_version}
fi

echo "workspace dir set as: \"${WORKSPACE_DIR}\""
cd ${WORKSPACE_DIR}

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
  sdf dbt refresh
  echo "::endgroup::"
  check_exit_status $? ""
fi

if [ -n "${SNOWFLAKE_ACCOUNT_ID}" ]; then
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
