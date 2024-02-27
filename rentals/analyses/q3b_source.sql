{{
    config(
        docs={'node_color': 'orange'}
    )
}}

select
    listing_id,
    least(duration, allowable_nights) as max_availability

from {{ ref('durations') }}

where duration_type = 'vacancy'
    and array_contains('Lockbox'::variant, parse_json(amenities))
    and array_contains('First aid kit'::variant, parse_json(amenities))