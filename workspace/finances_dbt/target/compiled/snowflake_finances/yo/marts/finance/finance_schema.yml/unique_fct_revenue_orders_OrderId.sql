
    
    

select
    OrderId as unique_field,
    count(*) as n_records

from apress.public_finance.fct_revenue_orders
where OrderId is not null
group by OrderId
having count(*) > 1


