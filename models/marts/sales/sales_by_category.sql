WITH base AS (
    SELECT DISTINCT
        f.transaction_id,
        f.quantity,
        f.total_spent,
        i.category
    FROM {{ ref('fct_sales') }} f
        JOIN {{ ref('dim_item') }} i ON f.item_key = i.item_key 
)

SELECT category,
       SUM(quantity) AS quantity_of_sold_items,
       SUM(total_spent) AS total_sales,
       ROUND((SUM(total_spent) / SUM(quantity)), 2) AS avg_price_per_unit
FROM base
GROUP BY category
ORDER BY total_sales DESC