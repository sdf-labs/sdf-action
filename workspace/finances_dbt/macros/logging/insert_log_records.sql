{% macro insert_log_records(table_name) %}
    {# do log(results, info=True) #}
    {% for result in results %}
        {% set query %}
        insert into {{ target.database }}.{{ target.schema }}.{{ table_name }}
        values(
            '{{ invocation_id }}',
            '{{ result.node.unique_id }}',
            '{{ result.node.resource_type }}',
            '{{ result.status }}',
            {% if result.timing %}
            '{{ result.timing[1].started_at }}',
            '{{ result.timing[1].completed_at }}'
            {% else %}
            null,
            null
            {% endif %}

        )
        {% endset %}
        {% do run_query(query) %}
    {% endfor %}
{% endmacro %}