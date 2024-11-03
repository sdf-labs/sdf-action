select
  itm.OrderItemsId,
  itm.OrderId,
  itm.ProductId
from {{ ref('raw_orderitems') }} as itm