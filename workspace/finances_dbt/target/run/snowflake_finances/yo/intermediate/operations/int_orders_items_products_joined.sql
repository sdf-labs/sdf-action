
  
    

        create or replace transient table apress.public_staging.int_orders_items_products_joined
         as
        (select
  itm.OrderItemsId,
  itm.OrderId,
  pro.Product,
  pro.Department,
  pro.Price
from apress.public_staging.stg_furniture_mart_orderitems as itm
join apress.public_staging.stg_furniture_mart_products as pro
  on itm.ProductId = pro.ProductId
        );
      
  