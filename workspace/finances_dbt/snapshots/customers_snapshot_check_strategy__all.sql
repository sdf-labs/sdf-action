{% snapshot customers_snapshot_check_strategy__all %}

{{
    config(
      target_schema='snapshots',
      unique_key='CustomerId',
      strategy='check',
      check_cols='all'
    )
}}

select
  *
from {{ ref('raw_customers') }}

{% endsnapshot %}