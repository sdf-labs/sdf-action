

select
    usage_date as date,
    average_stage_bytes
from snowflake.account_usage.stage_storage_usage_history