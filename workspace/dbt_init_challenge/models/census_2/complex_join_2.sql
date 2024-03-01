SELECT
    a.CENSUS_BLOCK_GROUP,
    CASE
        WHEN b."B16004e1" > b."B16004e2" THEN 'Category1'
        ELSE 'Category2'
    END AS category,
    COALESCE(a."50.0 percent or more: Renter-occupied housing units", 0) + COALESCE(b."B16004m1", 0) AS adjusted_metric,
    (b."B16004e5" - b."B16004e6") * a."Less than 10.0 percent: Renter-occupied housing units" AS calculated_field
FROM
     {{ source('census_sources', '2019_RENT_PERCENTAGE_HOUSEHOLD_INCOME') }} a
LEFT JOIN
    {{ source('census_sources', '2020_CBG_B16') }} b ON a.CENSUS_BLOCK_GROUP = b.CENSUS_BLOCK_GROUP
WHERE
    a."Total: Renter-occupied housing units" > 100 AND b."B16004e1" IS NOT NULL