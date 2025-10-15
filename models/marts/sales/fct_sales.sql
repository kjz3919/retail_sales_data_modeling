WITH fact_table AS (
    SELECT
        transaction_id,
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
        {{ dbt_utils.generate_surrogate_key(['item_id']) }} as item_key,
        CAST(TO_VARCHAR(transaction_date, 'YYYYMMDD') AS INT) AS date_key,
        price_per_unit,
        quantity,
        total_spent
    FROM {{ ref('stg_sales') }}
)

SELECT * FROM fact_table