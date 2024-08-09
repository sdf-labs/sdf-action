

select
    start_time,
    end_time,
    task_id,
    task_name,
    database_name,
    credits_used
from snowflake.account_usage.serverless_task_history


    where end_time > (select max(end_time) from apress.public.stg_serverless_task_history)


order by start_time