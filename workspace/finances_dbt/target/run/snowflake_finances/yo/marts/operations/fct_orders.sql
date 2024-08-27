
  
    

        create or replace transient table apress.public_operations.fct_orders
         as
        (


select
  ord.OrderId,
  ord.CustomerId,
  ord.SalesPerson,  
  ord.OrderStatus,
  ord.OrderPlacedTimestamp,
  1 as Ordr
from apress.public_staging.stg_furniture_mart_orders as ord

-- left join apress.snapshots.customers_snapshot_timestamp_strategy as cus
--   on ord.CustomerId = cus.CustomerId
-- uncomment the join criteria below to implement a time range join. 
--   and ord.OrderPlacedTimestamp between cus.dbt_valid_from and ifnull(cus.dbt_valid_to, '2099-12-31'::timestamp_ntz)

-- filters the snapshot table to only include the active records.
-- where cus.dbt_valid_to is null
        );
      
  