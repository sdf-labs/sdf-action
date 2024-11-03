{% snapshot customers_snapshot_check_strategy__hash %}

{{
    config(
      target_schema='snapshots',
      unique_key='customerid',
      strategy='check',
      check_cols=['HashDiff']
    )
}}

select
  *,
  {{ dbt_utils.generate_surrogate_key(adapter.get_columns_in_relation(ref('raw_customers'))|map(attribute='name')|list) }} as HashDiff
from {{ ref('raw_customers') }}

{% endsnapshot %}