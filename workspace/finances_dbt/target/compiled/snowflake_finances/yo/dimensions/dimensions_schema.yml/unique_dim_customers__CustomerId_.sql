
    
    

select
    "CustomerId" as unique_field,
    count(*) as n_records

from apress.public.dim_customers
where "CustomerId" is not null
group by "CustomerId"
having count(*) > 1


