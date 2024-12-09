with

locations as (

    select * from  {{ source('ecom', 'stg_locations') }}

)

select * from locations
