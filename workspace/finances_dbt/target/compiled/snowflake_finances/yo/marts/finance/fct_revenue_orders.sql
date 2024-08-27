with get_orders_revenue as(
  select
    pro.OrderId,
    sum(pro.Price) as Revenue
  from apress.public_staging.int_orders_items_products_joined as pro
  group by 1
)

select
  ord.OrderId,
  ord.OrderPlacedTimestamp,
  ord.UpdatedAt,
  ord.OrderStatus,
  ord.SalesPerson,
  rev.Revenue
from get_orders_revenue as rev
join apress.public_staging.stg_furniture_mart_orders as ord
  on rev.OrderId = ord.OrderId