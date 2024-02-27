with reservations as (

    select * 
    
    from {{ ref('stg_raw__availabilities') }}

    where is_available = false
)

select
    listing_id,
    reservation_id,
    min(available_date) as start_date,
    max(available_date) as end_date,
    count(reservation_id) as duration,
    min(maximum_nights) as allowable_nights,
    sum(daily_rate) as revenue 

from reservations

group by 1, 2