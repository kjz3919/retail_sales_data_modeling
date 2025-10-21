WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_sales') }}
    WHERE transaction_date IS NOT NULL
)

SELECT * FROM source