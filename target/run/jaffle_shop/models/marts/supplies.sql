
  
    

  create  table "gaussdb"."jaffle_shop"."supplies__dbt_tmp"
  
  
    as
  
  (
    with

supplies as (

    select * from  "gaussdb"."jaffle_shop"."stg_supplies"

)

select * from supplies
  );
  