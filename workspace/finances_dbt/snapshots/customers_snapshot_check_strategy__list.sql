{% snapshot customers_snapshot_check_strategy__list %}

{{
    config(
      target_schema='snapshots',
      unique_key='CustomerId',
      strategy='check',
      check_cols=['Name', 'Phone']
    )
}}

select
  *
from {{ ref('raw_customers') }}

{% endsnapshot %}