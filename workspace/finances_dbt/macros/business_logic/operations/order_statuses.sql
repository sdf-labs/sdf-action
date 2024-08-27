{% macro get_order_statuses() %}
  {{ return(['placed', 'shipped', 'returned']) }}
{% endmacro %}