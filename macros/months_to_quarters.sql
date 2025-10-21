{% macro map_quarter(date_column) %}
    case
        when substring({{ date_column }}, 6, 2) in ('01', '02', '03') then 'Q1'
        when substring({{ date_column }}, 6, 2) in ('04', '05', '06') then 'Q2'
        when substring({{ date_column }}, 6, 2) in ('07', '08', '09') then 'Q3'
        when substring({{ date_column }}, 6, 2) in ('10', '11', '12') then 'Q4'
        else 'Unknown'
    end
{% endmacro %}