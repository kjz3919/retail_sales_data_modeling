{% macro numbers_to_months(date) %}
    case
        when substring({{ date }}, 6, 2) = '01' then 'January'
        when substring({{ date }}, 6, 2) = '02' then 'February'
        when substring({{ date }}, 6, 2) = '03' then 'March'
        when substring({{ date }}, 6, 2) = '04' then 'April'
        when substring({{ date }}, 6, 2) = '05' then 'May'
        when substring({{ date }}, 6, 2) = '06' then 'June'
        when substring({{ date }}, 6, 2) = '07' then 'July'
        when substring({{ date }}, 6, 2) = '08' then 'August'
        when substring({{ date }}, 6, 2) = '09' then 'September'
        when substring({{ date }}, 6, 2) = '10' then 'October'
        when substring({{ date }}, 6, 2) = '11' then 'November'
        when substring({{ date }}, 6, 2) = '12' then 'December'
        else 'Unknown'
    end
{% endmacro %}