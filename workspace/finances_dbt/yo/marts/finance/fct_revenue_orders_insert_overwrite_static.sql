with get_orders_revenue as(
  select
    pro.OrderId,
    sum(pro.Price) as Revenue
  from {{ ref('int_orders_items_products_joined') }} as pro
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
join {{ ref('stg_furniture_mart_orders') }} as ord
  on rev.OrderId = ord.OrderId
{% if is_incremental() %}
where timestamp_trunc(ord.UpdatedAt, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}