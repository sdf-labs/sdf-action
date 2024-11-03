

select
    service_type,
    start_time,
    end_time,
    entity_id,
    name,
    credits_used_compute,
    credits_used_cloud_services,
    credits_used
from snowflake.account_usage.metering_history
order by start_time asc