SELECT  
    t.table_ref,
    c.classifiers
FROM 
    sdf.information_schema.tables t
JOIN 
    sdf.information_schema.columns c ON t.table_ref = c.table_ref
WHERE
    t.dependencies IS NOT NULL
    AND c.classifiers LIKE '%PII.email%'
GROUP BY 1, 2