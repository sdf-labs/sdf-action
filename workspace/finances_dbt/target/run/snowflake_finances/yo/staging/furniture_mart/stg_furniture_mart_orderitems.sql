
  create or replace   view apress.public_staging.stg_furniture_mart_orderitems
  
   as (
    select
  itm.OrderItemsId,
  itm.OrderId,
  itm.ProductId
from apress.public.raw_orderitems as itm
  );

