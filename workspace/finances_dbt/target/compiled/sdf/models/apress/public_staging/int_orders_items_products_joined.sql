select
  itm.OrderItemsId,
  itm.OrderId,
  pro.Product,
  pro.Department,
  pro.Price
from apress.public_staging.stg_furniture_mart_orderitems as itm
join apress.public_staging.stg_furniture_mart_products as pro
  on itm.ProductId = pro.ProductId