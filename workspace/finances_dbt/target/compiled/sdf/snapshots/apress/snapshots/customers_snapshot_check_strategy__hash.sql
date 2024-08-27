CREATE TABLE customers_snapshot_check_strategy__hash AS
                SELECT *, 
                  '' AS DBT_SCD_ID, 
                  CAST(NULL AS TIMESTAMP) AS DBT_UPDATED_AT,
                  CAST(NULL AS TIMESTAMP) AS DBT_VALID_FROM,
                  CAST(NULL AS TIMESTAMP) AS DBT_VALID_TO
                FROM (



select
  *,
  
    
md5(cast(coalesce(cast(CUSTOMERID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(PHONE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(EMAIL as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(ADDRESS as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(REGION as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(POSTALZIP as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(COUNTRY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(CREATEDAT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(UPDATEDAT as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as HashDiff
from apress.public.raw_customers
)