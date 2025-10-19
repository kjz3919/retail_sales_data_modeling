-- Staging model of customer dimension

WITH source as (
    SELECT * 
    FROM {{ source('raw', 'raw_sales') }}
    WHERE
    (
        (CASE WHEN total_spent IS NULL THEN 1 ELSE 0 END) +
        (CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) +
        (CASE WHEN item IS NULL THEN 1 ELSE 0 END)
    ) <= 1
),

cleaned AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
        SUBSTRING(customer_id, 6, LEN(customer_id)) AS customer_id,
        payment_method,
        location,
        CASE
            WHEN (quantity IS NOT NULL AND price_per_unit IS NOT NULL) AND quantity * price_per_unit > total_spent THEN 'Yes'
            ELSE 'No'
        END AS discount_applied
    FROM source
    WHERE {{ get_item_by_price('price_per_unit') }} <> 00

)

SELECT * FROM cleaned