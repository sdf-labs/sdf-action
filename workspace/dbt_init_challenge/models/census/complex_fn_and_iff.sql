WITH ranked_data AS (
    SELECT
        am.CENSUS_BLOCK_GROUP,
        IFF(am.total_B16004e1 > 1000, 'High', 'Low') AS total_B16004e1_category,
        ARRAY_AGG(DISTINCT am.rank_by_B16004e10) AS unique_ranks,
        TO_VARIANT(it.max_B16004e10) AS variant_max_B16004e10,
        LISTAGG(am.avg_renter_units, ',') WITHIN GROUP (ORDER BY am.avg_renter_units) AS list_avg_renter_units,
        ROW_NUMBER() OVER (PARTITION BY am.CENSUS_BLOCK_GROUP ORDER BY it.avg_renter_units_in_group DESC) AS rn,
        it.avg_renter_units_in_group,
        it.min_B16004m10
FROM
    {{ ref('aggregated_metrics') }} am
JOIN
    {{ ref('insights') }} it ON am.CENSUS_BLOCK_GROUP = it.CENSUS_BLOCK_GROUP
GROUP BY
    am.CENSUS_BLOCK_GROUP, it.max_B16004e10, it.avg_renter_units_in_group, it.min_B16004m10,2
)

SELECT
    CENSUS_BLOCK_GROUP,
    total_B16004e1_category,
    unique_ranks,
    variant_max_B16004e10,
    list_avg_renter_units
FROM ranked_data