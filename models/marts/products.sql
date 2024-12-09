with

products as (

    select * from  {{ source('ecom', 'stg_products') }}

)

select * from products
