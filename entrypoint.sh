#!/bin/bash -l

set -eo pipefail

echo "workspace dir set as: \"${WORKSPACE_DIR}\""
cd ${WORKSPACE_DIR}

# Check if the variable starts with 'sdf push'
if [[ $variable == "sdf push"* ]]; then
  echo "'sdf push' runs 'sdf auth login' using headless credentials"
  sdf auth login --access-key "${ACCESS_KEY}" --secret-key "${SECRET_KEY}"
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
