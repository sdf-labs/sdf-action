select
  cus.CustomerId as "CustomerId",
  initcap(cus.name) as FullName,
  initcap(split_part(cus.name, ' ', 1)) as FirstName,
  initcap(split_part(cus.name, ' ', 2)) as LastName,
  -- cus.Phone as PhoneNumber,
  '(' || substr(cus.Phone, 3, 3) || ')' || ' ' || substr(cus.Phone, 7, 9)
as PhoneNumber,
  cus.Email as EmailAddress,
  cus.Address,
  cus.Region,
  cus.PostalZip,
  cus.Country
from apress.public.raw_customers as cus