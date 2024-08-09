

select
    query_id,
    query_start_time,
    user_name,
    direct_objects_accessed,
    base_objects_accessed,
    objects_modified
from snowflake.account_usage.access_history


    where query_start_time > (select coalesce(max(query_start_time), date '1970-01-01') from apress.public.stg_access_history)


order by query_start_time asc