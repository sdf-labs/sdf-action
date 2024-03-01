SELECT
    am.CENSUS_BLOCK_GROUP,
    am.total_B16004e1,
    am.avg_renter_units,
    cjd.category,
    cjd.adjusted_metric,
    it.max_B16004e10,
    it.min_B16004m10,
    it.avg_renter_units_in_group,
    DENSE_RANK() OVER (ORDER BY am.avg_renter_units DESC) as renter_units_rank,
    SUM(cjd.adjusted_metric) OVER (PARTITION BY cjd.category) as sum_adjusted_metric_by_category,
    AVG(it.max_B16004e10) OVER () as avg_max_B16004e10,
    CASE 
        WHEN am.total_B16004e1 > 1000 THEN 'High'
        WHEN am.total_B16004e1 BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'Low'
    END AS total_B16004e1_category
FROM
    dbt_hol_dev.public.aggregated_metrics am
JOIN
    dbt_hol_dev.public.complex_join cjd ON am.CENSUS_BLOCK_GROUP = cjd.CENSUS_BLOCK_GROUP
JOIN
    dbt_hol_dev.public.insights it ON am.CENSUS_BLOCK_GROUP = it.CENSUS_BLOCK_GROUP