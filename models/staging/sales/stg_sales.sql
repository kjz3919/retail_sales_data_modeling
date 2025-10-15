-- Staging model of raw data
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
        SUBSTRING(transaction_id, 5, LEN(transaction_id)) AS transaction_id,
        SUBSTRING(customer_id, 6, LEN(customer_id)) AS customer_id,
        {{ get_item_by_price('price_per_unit') }} as item_id,
        category,
        CASE
          WHEN price_per_unit IS NULL THEN ROUND(total_spent / quantity, 2)
          ELSE price_per_unit
        END AS price_per_unit,
        quantity,
        total_spent,
        payment_method,
        location,
        transaction_date,
        CASE
            WHEN (quantity IS NOT NULL AND price_per_unit IS NOT NULL) AND quantity * price_per_unit > total_spent THEN 'Yes'
            ELSE 'No'
        END AS discount_applied
    FROM source
    WHERE {{ get_item_by_price('price_per_unit') }} <> 00
)

SELECT * FROM cleaned