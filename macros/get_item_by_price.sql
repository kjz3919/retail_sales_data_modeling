{%macro get_item_by_price(price) %}
    case
        when {{ price }} = 5.00 then 1
        when {{ price }} = 7.00 then 2
        when {{ price }} = 8.00 then 3
        when {{ price }} = 10.00 then 4
        when {{ price }} = 11.00 then 5
        when {{ price }} = 13.00 then 6
        when {{ price }} = 14.00 then 7
        when {{ price }} = 16.00 then 8
        when {{ price }} = 17.00 then 9
        when {{ price }} = 19.00 then 10
        when {{ price }} = 20.00 then 11
        when {{ price }} = 22.00 then 12
        when {{ price }} = 23.00 then 13
        when {{ price }} = 25.00 then 14
        when {{ price }} = 26.00 then 15
        when {{ price }} = 28.00 then 16
        when {{ price }} = 29.00 then 17
        when {{ price }} = 31.00 then 18
        when {{ price }} = 32.00 then 19
        when {{ price }} = 34.00 then 20
        when {{ price }} = 35.00 then 21
        when {{ price }} = 37.00 then 22
        when {{ price }} = 38.00 then 23
        when {{ price }} = 40.00 then 24
        when {{ price }} = 41.00 then 25
        else 'Unknown'
    end
{%endmacro}