select
  cus.CustomerId as "CustomerId",
  initcap(cus.name) as FullName,
  initcap(split_part(cus.name, ' ', 1)) as FirstName,
  initcap(split_part(cus.name, ' ', 2)) as LastName,
  -- cus.Phone as PhoneNumber,
  {{- phone_number_formatter('cus.Phone') -}} as PhoneNumber,
  cus.Email as EmailAddress,
  cus.Address,
  cus.Region,
  cus.PostalZip,
  cus.Country
from {{ ref('raw_customers') }} as cus