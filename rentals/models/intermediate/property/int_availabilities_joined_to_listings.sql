with availabilities as (
    
    select * from {{ ref('stg_raw__availabilities') }}
    
),

listings as (

    select * from {{ ref('stg_raw__listings') }} 
    
),

joined as (

    select
        availabilities.listing_id,
        listings.neighborhood,
        listings.room_type, -- for larger groups since the list is small
        listings.amenities,
        availabilities.daily_rate,
        availabilities.available_date,
        availabilities.minimum_nights,
        availabilities.maximum_nights,
        availabilities.is_available

    from availabilities
        left join listings using(listing_id)
        
)

select * from joined