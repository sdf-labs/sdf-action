{% macro create_logs_table(table_name) %}
    create table if not exists  {{ target.database }}.{{ target.schema }}.{{ table_name }}
    (
        invocation_id string,
        node_unique_id string,
        node_type string,
        result_status string,
        started_at timestamp,
        completed_at timestamp
    )
{% endmacro %}