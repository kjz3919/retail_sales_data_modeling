{% macro slice_ids(value) %}
    substring({{ value }}, 5)
{% endmacro %}