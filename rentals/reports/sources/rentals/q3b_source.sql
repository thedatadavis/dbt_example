with durations as (

      select
        listing_id,
        listing_window,
        iff(is_available, 'vacancy', 'occupancy') as listing_window_type,
        min(calendar_date) as start_date,
        max(calendar_date) as end_date,
        max(calendar_date) - min(calendar_date) as duration,
        max(maximum_nights) as allowable_nights,
        sum(nightly_price) as revenue

    from rentals.marts.occupancies

    where listing_window_type = 'vacancy'
        and has_lockbox = true
        and has_first_aid_kit = true

    group by 1, 2, 3

)

select
    listing_id,
    least(duration, allowable_nights) as max_availability

from durations

-- The above is a user-friendly alternative to the following:

-- where duration_type = 'vacancy'
--     and array_contains('Lockbox'::variant, parse_json(amenities))
--     and array_contains('First aid kit'::variant, parse_json(amenities))

-- It also avoids needing to parse the JSON in the 'amenities' 
-- column multiple times for more detailed searches.