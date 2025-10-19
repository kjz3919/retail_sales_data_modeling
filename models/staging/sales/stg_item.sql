-- Staging model for Item dimension

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
        {{ get_item_by_price('price_per_unit') }} as item_id,
        {{ dbt_utils.generate_surrogate_key(['item_id']) }} AS item_key,
        category
    FROM source
)

SELECT * FROM cleaned