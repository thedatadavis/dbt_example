with durations as (

    select
        listing_id,
        listing_window,
        case when is_available = 1 then 'vacancy' else 'occupancy' end as listing_window_type,
        min(calendar_date) as start_date,
        max(calendar_date) as end_date,
        date_diff('day', min(calendar_date), max(calendar_date)) as duration,
        max(maximum_nights) as allowable_nights,
        sum(nightly_price) as revenue

    from occupancies

    where has_lockbox = true
        and has_first_aid_kit = true

    group by 1, 2, 3

)

select
    listing_id::int::text as listing_id,
    least(duration, allowable_nights) as max_availability

from durations

where listing_window_type = 'vacancy'