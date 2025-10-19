WITH fact_table AS (
    SELECT
        f.transaction_id,
        c.customer_key AS customer_key,
        i.item_key as item_key,
        CAST(TO_VARCHAR(transaction_date, 'YYYYMMDD') AS INT) AS date_key,
        price_per_unit,
        quantity,
        total_spent
    FROM {{ ref('stg_sales') }} f
    JOIN {{ ref('dim_customer') }} c ON f.customer_id = c.customer_id
    JOIN {{ ref('dim_item') }} i ON f.item_id = i.item_id
)

SELECT * FROM fact_table