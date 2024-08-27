select
  itm.OrderItemsId,
  itm.OrderId,
  pro.Product,
  pro.Department,
  pro.Price
from {{ ref('stg_furniture_mart_orderitems') }} as itm
join {{ ref('stg_furniture_mart_products') }} as pro
  on itm.ProductId = pro.ProductId