{% macro slice_ids(value, start_pos) %}
    substring({{ value }}, {{ start_pos }})
{% endmacro %}