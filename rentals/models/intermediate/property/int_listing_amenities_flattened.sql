with amenity_arrays as (

    select
        amenities

    from {{ ref('stg_raw__listings') }}

)

select distinct
    value as amenity,

from amenity_arrays,
    lateral flatten(input => parse_json(amenities)) as flattened_amenities