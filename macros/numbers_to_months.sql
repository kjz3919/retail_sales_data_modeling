{% macro numbers_to_months(date) %}
    case
        when substring({{ date }}, 6, 2) = '01' then 'January'
        when substring({{ date }}, 6, 2) = '02' then 'January'
        when substring({{ date }}, 6, 2) = '03' then 'January'
        when substring({{ date }}, 6, 2) = '04' then 'January'
        when substring({{ date }}, 6, 2) = '05' then 'January'
        when substring({{ date }}, 6, 2) = '06' then 'January'
        when substring({{ date }}, 6, 2) = '07' then 'January'
        when substring({{ date }}, 6, 2) = '08' then 'January'
        when substring({{ date }}, 6, 2) = '09' then 'January'
        when substring({{ date }}, 6, 2) = '10' then 'January'
        when substring({{ date }}, 6, 2) = '11' then 'January'
        when substring({{ date }}, 6, 2) = '12' then 'January'
        else 'Unknown'
    end
{% endmacro %}