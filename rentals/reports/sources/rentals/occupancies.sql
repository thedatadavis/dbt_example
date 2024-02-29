with schedule as (

    select
        listing_window,
        calendar.*
    
    from staging.staging.stg_raw__calendar as calendar
    left join rentals.intermediate.int_listing_dates_grouped as listing_dates 
        using(listing_date_key)

),

full_listings as (

    select 
        listing_name,
        neighborhood,
        property_type,
        room_type,
        accommodates,
        bathrooms_text,
        bathrooms,
        bedrooms,
        beds,
        original_nightly_price_text,
        original_nightly_price,   

        -- host info
        host_id,
        host_name,
        host_location,
        host_verifications,
        host_start_date,

        -- review info
        number_of_reviews,
        average_rating,
        first_review_date,
        last_review_date,

        -- has_amenities
        listing_amenities.*
    
    from staging.staging.stg_raw__listings as listings
    left join rentals.intermediate.int_listing_has_amenities as listing_amenities
        using(listing_id)

),

joined as (

    select
        schedule.listing_window,
        schedule.listing_date_key,
        schedule.reservation_id,
        schedule.nightly_price,
        schedule.minimum_nights,
        schedule.maximum_nights,
        schedule.is_available,
        schedule.calendar_date,
        full_listings.*

    from schedule
    left join full_listings
        using(listing_id)

)

select * from joined