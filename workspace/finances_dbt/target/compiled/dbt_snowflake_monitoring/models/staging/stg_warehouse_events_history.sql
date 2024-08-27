

select
    timestamp,
    warehouse_id,
    warehouse_name,
    cluster_number,
    event_name,
    event_reason,
    event_state,
    user_name,
    role_name,
    query_id
from snowflake.account_usage.warehouse_events_history


    where timestamp > (select max(timestamp) from apress.public.stg_warehouse_events_history)


order by timestamp asc