# Complex DBT Case for `sdf dbt init`

This DBT project contains some complexity around macros, sources, and incremental models. Ideally, `sdf dbt init` will handle these more smoothly. 

In a dream world, `sdf dbt init` does the following to this workspace:

- Since there are no Snapshots in this workspace, `sdf dbt init` should not add snapshots to the includes paths.
- Gracefully handle the `profiles.yml` file including the `env_var` jinja. The first version of this can just ignore the `env_var` jinja and print a nice message to the user telling them they need to fill in the values. Future versions should process the jinja directly with the `.env`
- Provider YML blocks (or external tables) should be automatically added based on the `sources.yml` file.
- Handle the functions declared within the `macros` directory. It seems the `manifest.json` does not contain this code directly, so perhaps we'll have to use `--infer-functions` here.
- After a dbt clean, then a `dbt compile`, `sdf compile` and `sdf dbt refresh` do not work since the workpace includes path is broken.
- Prevent the overwriting of the `includes` block when `sdf dbt refresh` is run. 
For example, the includes block is:

```yaml
  includes:
  - path: target/compiled/sdf/models/dbt_hol_dev/public
    index: table-name
```

After running `sdf dbt refresh`, the includes becomes

```yaml
    includes:
    - path: target/compiled/sdf/models
        index: catalog-schema-table-name
    - path: target/compiled/sdf/snapshots
        index: catalog-schema-table-name
```

Ideal behavior would be to not overwrite an includes path if it is a subset of the new includes path.

## Compilation

To compile this project, first run this to source the environment variables:

```console
set -a; source .env; set +a
```

Next, compile DBT:
```console
dbt compile
```