[![SDF + Snowflake / Redshift / DBT Tests](https://github.com/sdf-labs/sdf-action/actions/workflows/examples.yml/badge.svg)](https://github.com/sdf-labs/sdf-action/actions/workflows/examples.yml)


# Official SDF GitHub Action

This action is used to run SDF in CI/CD workflows with GitHub Actions. A common use case would be to run an impact analysis with `sdf compile` and `sdf check` on PR creation. 

*Note: This GitHub action is still < v1, as such certain scenarios may result in unexpected behavior. Please follow the [contributing guidelines](./CONTRIBUTING.md) and create an issue in this repo if you find any bugs or issues.*

For an in-depth guide on how to use this GitHub, please see the GitHub CI/CD section of [our official docs](https://docs.sdf.com/integrations/cicd/ci_cd)

## Usage
Check out this [example workflow](./.github/workflows/examples.yml) to see how to use this action.

<!-- start usage -->
```yaml
- uses: sdf-labs/sdf-action@v0
  with:
    # The version of SDF to use in the GitHub action.
    # This should match the version of SDF you use locally in development.
    sdf_version: '0.3.0'

    # The SDF command to run. The exit code of this command is used to determine
    # success or failure of the action.
    command: 'sdf compile'

    # The relative path to the workspace starting from the root of your repository.
    # The workspace directory is where the `workspace.sdf.yml` file is located.
    workspace_dir: './my_sdf_workspace/'

    # Whether or not this SDF project is being used with dbt. If so, 
    # the action runs `sdf dbt refresh` in the container before the 
    # specified SDF command.
    is_dbt: 'false' # Defaults to false

    ### SDF Cloud Authentication
   
    # NOTE: Both the access_key and secret_key parameters are required for accessing the SDF 

    # The access key used for headless authentication to the SDF Cloud
    access_key: ${{ secrets.SDF_ACCESS_KEY }}

    # The secret key used for headless authentication to the SDF Cloud
    secret_key: ${{ secrets.SDF_SECRET_KEY }}

    ### Snowflake Integration

    # All of the following are used to authenticate to Snowflake.
    # All of these are required if using a Snowflake provider.
    snowflake_account_id: ${{ secrets.SNOWFLAKE_ACCOUNT_ID }}
    snowflake_username: ${{ secrets.SNOWFLAKE_USERNAME }}
    snowflake_password: ${{ secrets.SNOWFLAKE_PASSWORD }}
    snowflake_role: ${{ secrets.SNOWFLAKE_ROLE }}
    snowflake_warehouse: ${{ secrets.SNOWFLAKE_WAREHOUSE }}

    ### AWS / Redshift Integration

    # All of the following are required if using an S3, AWS Glue, or AWS Redshift
    # provider.
    aws_region: ${{ secrets.AWS_REGION }}
    aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```
<!-- end usage -->

# Scenarios

** [Run Compile on PR](#run-compile-on-pr-creation-and-update)
** [Run Checks on PR with Snowflake Provider](#run-compile-on-pr-creation-and-update-with-a-snowflake-provider)
** [Push to SDF Cloud on Merge to Main](#push-to-sdf-cloud-on-merge-to-main-with-a-redshift-provider)


## Run Compile on PR Creation and Update

```yaml
on:
  pull_request:
...
    - uses: sdf-labs/sdf-action@v0
      with:
        sdf_version: '0.3.0'
        command: 'sdf compile'
```

## Run Checks on PR Creation and Update with a Snowflake Provider

```yaml
on:
  pull_request:
...
    - uses: sdf-labs/sdf-action@v0
      with:
        sdf_version: '0.3.0'
        command: 'sdf check'
        snowflake_account_id: ${{ secrets.SNOWFLAKE_ACCOUNT_ID }}
        snowflake_username: ${{ secrets.SNOWFLAKE_USERNAME }}
        snowflake_password: ${{ secrets.SNOWFLAKE_PASSWORD }}
        snowflake_role: ${{ secrets.SNOWFLAKE_ROLE }}
        snowflake_warehouse: ${{ secrets.SNOWFLAKE_WAREHOUSE }}
```

## Push to SDF Cloud on Merge to Main with a Redshift Provider

```yaml
on: 
  push:
    branches:
      - main
    paths:
      - 'my_sdf_workspace/**'
...
    - uses: sdf-labs/sdf-action@v0
      with:
        sdf_version: '0.3.0'
        command: 'sdf push -y'
        workspace_dir: './my_sdf_workspace/'
        access_key: ${{ secrets.SDF_ACCESS_KEY }}
        secret_key: ${{ secrets.SDF_SECRET_KEY }}
        aws_region: ${{ secrets.AWS_REGION }}
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## Parameters

* `snowflake_*` parameters are required if the `snowflake` table provider is used
* `aws_*` parameters are required if the `redshift` table provider is used
* `access_key` and `secret_key` are required if the `sdf push` is used in `command`

| Parameter | Description | Required | Default |
| --- | --- | --- | --- |
| `sdf_version` | SDF CLI version | No | `"0.2.10"`
| `command` | The `sdf` CLI command to run. | No | `sdf compile`
| `workspace_dir` | The directory of the workspace  | No | `"."` |
| `access_key` | access key created from the [console](https://console.sdf.com/catalog/settings/general) to be used in `sdf push`  | No | |
| `secret_key` | secret key created from the [console](https://console.sdf.com/catalog/settings/general) to be used in `sdf push` | No | |
| `is_dbt` | Set to a non-empty string if the workspace is dbt based | No | `""` | |
| `snowflake_account_id` | The snowflake account | No | | 
| `snowflake_username` | The snowflake username | No | |
| `snowflake_password` | The snowflake password | No | |
| `snowflake_role` | The snowflake role | No | |
| `snowflake_warehouse` | The snowflake warehouse | No | |
| `aws_region` | The aws region | No | |
| `aws_access_key_id` | The aws access key id created from an IAM user | No | |
| `aws_secret_access_key` | The aws secret created from an IAM user | No | |
