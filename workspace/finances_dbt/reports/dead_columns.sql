SELECT ic.column_name, ic.table_ref
FROM sdf.information_schema.columns ic
JOIN sdf.information_schema.tables it ON ic.table_ref = it.table_ref
WHERE NOT EXISTS (
    SELECT 1
    FROM sdf.information_schema.columns downstream
    WHERE downstream.lineage_copy ILIKE '%' || ic.column_name || '%'
       OR downstream.lineage_modify ILIKE '%' || ic.column_name || '%'
) 
AND it.dependencies IS NOT NULL;





-- AND ic.lineage_copy IS NOT NULL 
-- AND ic.lineage_modify IS NOT NULL