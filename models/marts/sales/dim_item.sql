WITH dim_item AS (
    SELECT 
        {{ utils_db.generate_surrogate_key('item_id') }} AS item_key
        item_id,
        category
    FROM {{ ref('stg_sales') }}
)

SELECT * FROM dim_item;