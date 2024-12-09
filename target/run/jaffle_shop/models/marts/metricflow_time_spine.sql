
  
    

  create  table "gaussdb"."jaffle_shop"."metricflow_time_spine__dbt_tmp"
  
  
    as
  
  (
    -- metricflow_time_spine.sql
with

days as (

    --for BQ adapters use "DATE('01/01/2000','mm/dd/yyyy')"
    
    with date_spine as
(

    





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
    
    

    )

    select *
    from unioned
    where generated_number <= 3651.0
    order by generated_number



),

all_periods as (

    select (
        

    

    cast(cast(
    cast(now() as timestamp)
        at time zone 'UTC' at time zone 'America/Los_Angeles' as timestamp
) as date) + ((interval '1 day') * (-3650))

 + ((interval '1 day') * ((row_number() over (order by 1) - 1)))


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= cast(

    cast(cast(
    cast(now() as timestamp)
        at time zone 'UTC' at time zone 'America/Los_Angeles' as timestamp
) as date) + ((interval '1 day') * (1))

 as date)

)

select * from filtered



)
select
    cast(d.date_day as timestamp) as date_day
from
    date_spine d



),

cast_to_date as (

    select cast(date_day::text as date) as date_day

    from days

)

select * from cast_to_date
  );
  