

select
    start_time,
    end_time,
    warehouse_id,
    warehouse_name,
    credits_used,
    credits_used_compute,
    credits_used_cloud_services
from snowflake.account_usage.warehouse_metering_history


    -- account for changing metering data
    where end_time > (select coalesce(dateadd(day, -7, max(end_time)), '1970-01-01') from apress.public.stg_warehouse_metering_history)


order by start_time