
select 
    CENSUS_BLOCK_GROUP, 
    "Total: Renter-occupied housing units" 
FROM 
    census.public."2019_RENT_PERCENTAGE_HOUSEHOLD_INCOME"
WHERE "Total: Renter-occupied housing units" > 100