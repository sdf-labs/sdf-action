
    
    

select
    "CENSUS_BLOCK_GROUP" as unique_field,
    count(*) as n_records

from census.public."2020_CBG_B16"
where "CENSUS_BLOCK_GROUP" is not null
group by "CENSUS_BLOCK_GROUP"
having count(*) > 1


