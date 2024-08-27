{% snapshot customers_snapshot_timestamp_strategy %}

{{
    config(
      target_schema='snapshots',
      unique_key='CustomerId',
      strategy='timestamp',
      updated_at='UpdatedAt',
      invalidate_hard_deletes=True
    )
}}

select
  *,
  md5(email) as email
from {{ ref('raw_customers') }}

{% endsnapshot %}