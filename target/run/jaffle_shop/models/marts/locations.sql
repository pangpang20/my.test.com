
  
    

  create  table "gaussdb"."jaffle_shop"."locations__dbt_tmp"
  
  
    as
  
  (
    with

locations as (

    select * from  "gaussdb"."jaffle_shop"."stg_locations"

)

select * from locations
  );
  