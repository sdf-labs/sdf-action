
  create or replace   view apress.public_staging.stg_furniture_mart_products
  
   as (
    select
  pro.*
from apress.public.raw_products as pro
  );

