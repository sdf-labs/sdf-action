
  create or replace   view apress.public_operations.fct_daily_orders
  
   as (
    

/********************************************/


/********************************************/

-- Listing 6.8
select
  cast(OrderPlacedTimestamp as bigint) OrderPlacedDate,
  
  count(case when OrderStatus = 'placed' then OrderId end) as NumberOfOrdersplaced,
  
  count(case when OrderStatus = 'shipped' then OrderId end) as NumberOfOrdersshipped,
  
  count(case when OrderStatus = 'returned' then OrderId end) as NumberOfOrdersreturned
  
from apress.public_operations.fct_orders
group by 1
  );

