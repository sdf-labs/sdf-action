{% macro clone_prod_to_dev(from_database) %}
    {% set clone_queries %}
        select
            'create or replace table ' ||
            '{{ target.database }}' || '.' || '{{ target.schema }}' || '.' || table_name
            clone || table_catalog || '.' || table_schema || '.' || table_name || ';' as query
        from {{ from_database }}.information_schema.tables
        where table_type = 'BASE TABLE'
    {% endset %}

    {% set clone_queries = run_query(clone_queries) %}

    {% for index in range(clone_queries|len) %}
        {% do run_query(clone_queries[index][0]) %}
        {% set current_position = index + 1 %}
        {{ log(current_position ~ ' of ' ~ clone_queries|len ~ ' tables cloned to dev.', info=True) }}
    {% endfor %}
{% endmacro %}