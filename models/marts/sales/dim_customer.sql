WITH dim_customer AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
        customer_id,
        payment_method,
        location,
        discount_applied
    FROM {{ ref('stg_sales') }}
)

SELECT * FROM dim_customer