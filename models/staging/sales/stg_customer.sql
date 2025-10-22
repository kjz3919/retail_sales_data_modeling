-- Staging model of customer dimension

WITH source as (
    SELECT DISTINCT
        SUBSTRING(transaction_id, 5, 100) as transaction_id_fixed,
        SUBSTRING(customer_id, 6, 100) as customer_id_fixed,
        CASE
          WHEN price_per_unit IS NULL THEN ROUND(total_spent / quantity, 2)
          ELSE price_per_unit
        END AS price_per_unit_fixed,
        {{ get_item_by_price('price_per_unit_fixed') }} as item_id_fixed,
        quantity,
        total_spent,
        payment_method,
        location,
        transaction_date,
        CASE
            WHEN (quantity IS NOT NULL AND price_per_unit IS NOT NULL) AND quantity * price_per_unit > total_spent THEN 'Yes'
            ELSE 'No'
        END AS discount_applied
    FROM {{ ref('stg_raw_sales') }}
    WHERE
    (
        (CASE WHEN total_spent IS NULL THEN 1 ELSE 0 END) +
        (CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) +
        (CASE WHEN item IS NULL THEN 1 ELSE 0 END)
    ) <= 1
    AND transaction_date IS NOT NULL
    
),

unique_customers AS (
    SELECT DISTINCT customer_id_fixed as customer_id
    FROM source
    WHERE customer_id_fixed IS NOT NULL
),   

cleaned AS (
    SELECT
        md5(customer_id) as customer_key,
        customer_id as customer_id,
    FROM unique_customers
    
)

SELECT * FROM cleaned