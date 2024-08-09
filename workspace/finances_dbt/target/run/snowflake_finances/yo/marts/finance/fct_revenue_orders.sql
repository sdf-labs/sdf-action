-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into apress.public_finance.fct_revenue_orders as DBT_INTERNAL_DEST
        using apress.public_finance.fct_revenue_orders__dbt_tmp as DBT_INTERNAL_SOURCE
        on (DBT_INTERNAL_DEST.UpdatedAt > dateadd(day, -7, current_date())) and (
                DBT_INTERNAL_SOURCE.OrderId = DBT_INTERNAL_DEST.OrderId
            )

    
    when matched then update set
        "ORDERID" = DBT_INTERNAL_SOURCE."ORDERID","ORDERPLACEDTIMESTAMP" = DBT_INTERNAL_SOURCE."ORDERPLACEDTIMESTAMP","UPDATEDAT" = DBT_INTERNAL_SOURCE."UPDATEDAT","ORDERSTATUS" = DBT_INTERNAL_SOURCE."ORDERSTATUS","SALESPERSON" = DBT_INTERNAL_SOURCE."SALESPERSON","REVENUE" = DBT_INTERNAL_SOURCE."REVENUE"
    

    when not matched then insert
        ("ORDERID", "ORDERPLACEDTIMESTAMP", "UPDATEDAT", "ORDERSTATUS", "SALESPERSON", "REVENUE")
    values
        ("ORDERID", "ORDERPLACEDTIMESTAMP", "UPDATEDAT", "ORDERSTATUS", "SALESPERSON", "REVENUE")

;
    commit;