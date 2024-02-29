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

    from occupancies

    group by 1, 2, 3

)

select
    listing_id,

    -- Some vacancy blocks run longer than the maximum nights allowed for that date range
    -- Take the lesser of those two values
    -- Then take the max to get the largest across all vacancy blocks
    max(least(duration, allowable_nights)) as max_availability 

from durations

where listing_window_type = 'vacancy'

group by 1

order by 2 desc