{{ config(materialized='view') }}

select 
    {{ dbt_utils.surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid,
    cast(dispatching_base_num as string) as dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    cast(pulocationid as integer) as pulocationid,
    cast(dolocationid as integer) as dolocationid,
    cast(affiliated_base_number as string) as affiliated_base_number
    from {{ source('staging', 'fhv_tripdata')}}
