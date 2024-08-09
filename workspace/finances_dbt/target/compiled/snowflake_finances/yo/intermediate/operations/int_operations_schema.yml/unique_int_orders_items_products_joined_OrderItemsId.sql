
    
    

select
    OrderItemsId as unique_field,
    count(*) as n_records

from apress.public_staging.int_orders_items_products_joined
where OrderItemsId is not null
group by OrderItemsId
having count(*) > 1


