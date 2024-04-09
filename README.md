# sdf-action
Github Action to run `sdf` CLI in workflows.

## Usage
Check out this [example workflow](./.github/workflows/examples-test.yml) to see how to use this action.

## Parameters

* `snowflake_`* parameters are required if the `snowflake` table provider is used
* `aws_*` parameters are required if the `redshift` table provider is used
* `access_key` and `secret_key` are required if the `sdf push` is used in `command`

| Parameter | Description | Required | Default |
| --- | --- | --- | --- |
| `command` | The `sdf` CLI command to run. | No | `sdf compile`
| `workspace_dir` | The directory of the workspace"  | No | "." |
| `access_key` | access key created from the [console](https://console.sdf.com/catalog/settings/general) to be used in `sdf push`  | No | |
| `secret_key` | secret key created from the [console](https://console.sdf.com/catalog/settings/general) to be used in `sdf push` | No | |
| `is_dbt` | Set to a non-empty string if the workspace is dbt based | No | false | ""
| `dbt_target` | The dbt target | No | "." |
| `snowflake_account_id` | The snowflake account | No | ""
| `snowflake_username` | The snowflake username | No | ""
| `snowflake_password` | The snowflake password | No | ""
| `snowflake_role` | The snowflake role | No | ""
| `snowflake_warehouse` | The snowflake warehouse | No | ""
| `aws_region` | The aws region | No | ""
| `aws_access_key_id` | The aws access key id created from an IAM user | No | ""
| `aws_secret_access_key` | The aws secret created from an IAM user | No | ""
