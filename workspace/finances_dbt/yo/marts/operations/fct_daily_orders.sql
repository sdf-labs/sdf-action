{#
-- Listing 6.6
-- select
--   cast(OrderPlacedTimestamp as date) OrderPlacedDate,
--   count(case when OrderStatus = 'placed' then OrderId end) as NumberOfOrdersPlaced,
--   count(case when OrderStatus = 'shipped' then OrderId end) as NumberOfOrdersShipped,
--   count(case when OrderStatus = 'returned' then OrderId end) as NumberOfOrdersReturned
-- from {{ ref('fct_orders') }}
-- group by 1
#}

/********************************************/

{#
-- Listing 6.7
-- {% set statuses = ['placed', 'shipped', 'returned'] %}

-- select
--   cast(OrderPlacedTimestamp as date) OrderPlacedDate,
--   {% for i in statuses %}
--   count(case when OrderStatus = '{{ i }}' then OrderId end) as NumberOfOrders{{ i }}{% if not loop.last %},{% endif %}
--   {% endfor %}
-- from {{ ref('fct_orders') }}
-- group by 1
#}
/********************************************/

-- Listing 6.8
select
  cast(OrderPlacedTimestamp as bigint) OrderPlacedDate,
  {% for i in get_order_statuses() %}
  count(case when OrderStatus = '{{ i }}' then OrderId end) as NumberOfOrders{{ i }}{% if not loop.last %},{% endif %}
  {% endfor %}
from {{ ref('fct_orders') }}
group by 1