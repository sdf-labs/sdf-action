{% macro clone_database_for_ci() %}
  {% set sql='create or replace database ' + target.database + '_' + env_var('DBT_PR_NUMBER') + ' clone ' + target.database %}
  {% do run_query(sql) %}
{% endmacro %}

