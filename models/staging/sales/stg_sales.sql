-- Staging model of fact table
WITH source as (
    SELECT 
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
    FROM {{ source('raw', 'raw_sales') }}
    WHERE
    (
        (CASE WHEN total_spent IS NULL THEN 1 ELSE 0 END) +
        (CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) +
        (CASE WHEN item IS NULL THEN 1 ELSE 0 END)
    ) <= 1
    AND transaction_date IS NOT NULL
),


cleaned AS (
    SELECT
        f.transaction_id_fixed AS transaction_id,
        c.customer_key,
        i.item_key,
        d.date_key,
        f.price_per_unit_fixed AS price_per_unit,
        f.quantity,
        f.total_spent
    FROM source f
    JOIN {{ ref('stg_customer') }} c ON f.customer_id_fixed = c.customer_id
    JOIN {{ ref('stg_item') }} i ON f.item_id_fixed = i.item_id
    JOIN {{ ref('stg_date') }} d ON f.transaction_date = d.transaction_date
    WHERE f.item_id_fixed <> 00 
)

SELECT * FROM cleaned