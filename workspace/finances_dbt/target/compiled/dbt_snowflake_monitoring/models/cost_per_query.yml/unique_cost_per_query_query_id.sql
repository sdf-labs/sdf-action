
    
    

select
    query_id as unique_field,
    count(*) as n_records

from apress.public.cost_per_query
where query_id is not null
group by query_id
having count(*) > 1


