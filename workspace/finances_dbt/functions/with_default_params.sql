create or replace function CYBERSYN_DEV_UTILS.UDFS.clean_phone(
       phone string,
       country string default 'US',
       nullIfInvalid BOOLEAN DEFAULT TRUE
)
returns string
language python
runtime_version = '3.8'
packages =(
    'phonenumbers==8.12.27'
)
handler = 'cleanphone_py'
as
$$
import phonenumbers

def cleanphone_py(phone, country, nullIfInvalid):
  try:
    parsed = phonenumbers.parse(phone, country)
    valid_num = phonenumbers.is_valid_number(parsed)
    if valid_num:
        return phonenumbers.format_number(parsed, phonenumbers.PhoneNumberFormat.NATIONAL)
  except:
    pass
  if nullIfInvalid:
     return None
  return phone
$$;