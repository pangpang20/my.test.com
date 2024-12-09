with

supplies as (

    select * from  {{ source('ecom', 'stg_supplies') }}

)

select * from supplies
