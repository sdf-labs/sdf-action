SELECT
    a.CENSUS_BLOCK_GROUP,
    SUM(b."B16004e10") AS total_B16004e1,
    AVG(a."Total: Renter-occupied housing units") AS avg_renter_units,
    RANK() OVER (PARTITION BY a.CENSUS_BLOCK_GROUP ORDER BY SUM(b."B16004e10") DESC) AS rank_by_B16004e10,
    ROW_NUMBER() OVER (ORDER BY AVG(a."Total: Renter-occupied housing units")) AS row_num
FROM
    census.public."2019_RENT_PERCENTAGE_HOUSEHOLD_INCOME" a
JOIN
    census.public."2020_CBG_B16" b ON a.CENSUS_BLOCK_GROUP = b.CENSUS_BLOCK_GROUP
GROUP BY
    a.CENSUS_BLOCK_GROUP