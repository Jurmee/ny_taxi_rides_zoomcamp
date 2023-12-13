{{ config(materialized='table') }}

with dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
),
fhv_data as (
    select * from {{ ref('stg_fhv_tripdata') }}
)

select 
fhv.tripid,
fhv.dispatching_base_num,
fhv.pickup_datetime,
fhv.dropoff_datetime,
fhv.pulocationid,
fhv.dolocationid,
fhv.affiliated_base_number
from 
fhv_data as fhv 
inner join dim_zones as pickup
on fhv.pulocationid = pickup.locationid
inner join dim_zones as dropoff
on fhv.dolocationid = dropoff.locationid