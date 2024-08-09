CREATE TABLE customers_snapshot_timestamp_strategy AS
                SELECT *, 
                  '' AS DBT_SCD_ID, 
                  CAST(NULL AS TIMESTAMP) AS DBT_UPDATED_AT,
                  CAST(NULL AS TIMESTAMP) AS DBT_VALID_FROM,
                  CAST(NULL AS TIMESTAMP) AS DBT_VALID_TO
                FROM (



select
  *,
  md5(email) as email
from apress.public.raw_customers
)