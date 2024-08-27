
    
    

select
    "CustomerId" as unique_field,
    count(*) as n_records

from apress.public_staging.stg_crm_customers
where "CustomerId" is not null
group by "CustomerId"
having count(*) > 1


