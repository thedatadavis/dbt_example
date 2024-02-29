with amenity_arrays as (

    select
        amenities

    from {{ ref('stg_raw__listings') }}

)

select distinct
    'has_' || regexp_replace(lower(as_char(value)), '[^a-zA-Z0-9]', '_') as amenity_label,
    value as amenity_variant,
    as_char(value) as amenity_text,
    amenity_text || '|' || amenity_label as lookup
    
from amenity_arrays,
    lateral flatten(input => parse_json(amenities)) as flattened_amenities