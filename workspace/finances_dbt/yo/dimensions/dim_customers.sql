select
  "CustomerId",
  FullName
from {{ ref('stg_crm_customers') }} as cus