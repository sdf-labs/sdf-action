CREATE TABLE customers_snapshot_check_strategy__all AS
                SELECT *, 
                  '' AS DBT_SCD_ID, 
                  CAST(NULL AS TIMESTAMP) AS DBT_UPDATED_AT,
                  CAST(NULL AS TIMESTAMP) AS DBT_VALID_FROM,
                  CAST(NULL AS TIMESTAMP) AS DBT_VALID_TO
                FROM (



select
  *
from apress.public.raw_customers
)