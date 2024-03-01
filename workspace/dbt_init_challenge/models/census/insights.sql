SELECT
    a.CENSUS_BLOCK_GROUP,
    MAX(b."B16004e10") AS max_B16004e10,
    MIN(b."B16004m10") AS min_B16004m10,
    AVG(sub.total_renter_units) AS avg_renter_units_in_group
FROM
    {{ source('census_sources', '2019_RENT_PERCENTAGE_HOUSEHOLD_INCOME') }} a
INNER JOIN
    {{ source('census_sources', '2020_CBG_B16') }} b ON a.CENSUS_BLOCK_GROUP = b.CENSUS_BLOCK_GROUP
INNER JOIN
    (SELECT
         CENSUS_BLOCK_GROUP,
         SUM("Total: Renter-occupied housing units") AS total_renter_units
     FROM
         {{ source('census_sources', '2019_RENT_PERCENTAGE_HOUSEHOLD_INCOME') }} a
     GROUP BY
         CENSUS_BLOCK_GROUP) sub ON a.CENSUS_BLOCK_GROUP = sub.CENSUS_BLOCK_GROUP
GROUP BY
    a.CENSUS_BLOCK_GROUP