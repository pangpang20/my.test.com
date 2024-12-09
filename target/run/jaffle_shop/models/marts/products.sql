
  
    

  create  table "gaussdb"."jaffle_shop"."products__dbt_tmp"
  
  
    as
  
  (
    with

products as (

    select * from  "gaussdb"."jaffle_shop"."stg_products"

)

select * from products
  );
  