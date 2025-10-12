-- Declaring the source of raw data

WITH source as (
    SELECT * 
    FROM {{ source ('raw', 'raw_sales') }}
    WHERE NOT (
        total_spent IS NULL
        AND quantity IS NULL
        AND item IS NULL
    )
);

cleaned AS (
    SELECT
        SUBSTRING(transaction_id, 5, LEN(transaction_id)) AS transaction_id,
        SUBSTRING(customer_id, 6, LEN(customer_id)) AS customer_id,
        category,
        item, -- do wyczyszczenia
        price_per_unit -- do wyczyszczenia
        quantity,
        total_spent, -- do wyczyszczenia
        payment_method,
        location,
        transaction_date,
        CASE
            WHEN (quantity IS NOT NULL AND price_per_unit IS NOT NULL) AND quantity * price_per_unit > total_spent THEN 'True'
            ELSE 'False'
        END AS discount_applied_cleaned
    FROM source;
)

SELECT * FROM cleaned;