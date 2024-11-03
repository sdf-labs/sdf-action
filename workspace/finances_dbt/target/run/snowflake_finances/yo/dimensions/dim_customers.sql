
  create or replace   view apress.public.dim_customers
  
   as (
    select
  "CustomerId",
  FullName
from apress.public_staging.stg_crm_customers as cus
  );

