{{ config(materialized='view') }}
select 
    CENSUS_BLOCK_GROUP, 
    "Total: Renter-occupied housing units" 
FROM 
    {{ source("census_sources", "2019_RENT_PERCENTAGE_HOUSEHOLD_INCOME") }}
WHERE "Total: Renter-occupied housing units" > 4242
