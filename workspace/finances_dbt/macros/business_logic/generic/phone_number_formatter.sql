{% macro phone_number_formatter(initial_phone_number) %}
  '(' || substr({{ initial_phone_number }}, 3, 3) || ')' || ' ' || substr({{ initial_phone_number }}, 7, 9)
{% endmacro %}