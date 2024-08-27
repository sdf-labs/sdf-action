{% test not_negative(model, column_name) %}
select 
  statement
from {{ model }}
where {{ column_name }} < 0
{% endtest %}
