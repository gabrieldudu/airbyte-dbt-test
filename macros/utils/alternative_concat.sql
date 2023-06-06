{% macro alternative_concat(fields) %}
    {{ fields|join(' || ') }}
{% endmacro %}