
  create or replace   view apress.public_staging.stg_furniture_mart_orders
  
   as (
    

select
  ord.OrderId,
  ord.CustomerId,
  initcap(ord.SalesPerson) as SalesPerson,
  cast(ord.OrderPlacedTimestamp as timestamp_ntz) as OrderPlacedTimestamp,
  ord.OrderStatus,
  cast(ord.UpdatedAt as timestamp_ntz) as UpdatedAt
from apress.public.raw_orders as ord
  );

