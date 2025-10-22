WITH source as (
    SELECT DISTINCT
        SUBSTRING(transaction_id, 5, 100) as transaction_id_fixed,
        SUBSTRING(customer_id, 6, 100) as customer_id_fixed,
        category,
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
),

unique_categories_items AS (
    SELECT DISTINCT
        category,
        item_id_fixed AS item_id
    FROM source
    WHERE item_id_fixed <> 00
)



SELECT
    i.item_key,
    c.category_key
FROM unique_categories_items s 
JOIN {{ ref('stg_item') }} i ON s.item_id = i.item_id
JOIN {{ ref('stg_category') }} c ON s.category = c.category
ORDER BY c.category_key