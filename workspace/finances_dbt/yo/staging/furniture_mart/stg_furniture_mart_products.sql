select
  pro.*
from {{ ref('raw_products') }} as pro