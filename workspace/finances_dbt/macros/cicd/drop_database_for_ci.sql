{% macro drop_database_for_ci() %}
  {% set sql='drop database ' + target.database + '_' + env_var('DBT_PR_NUMBER') %}
  {% do run_query(sql) %}
{% endmacro %}