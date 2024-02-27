with reservations_and_vacancies_joined as (

    select
        listing_id,
        reservation_id as duration_id,
        'reservation' as duration_type,
        start_date,
        end_date,
        duration,
        allowable_nights,
        revenue

    from {{ ref('int_availabilities_pivoted_to_reservations') }}

    union all

    select 
        listing_id,
        vacancy_id as duration_id,
        'vacancy' as duration_type,
        start_date,
        end_date,
        duration,
        allowable_nights,
        missed_revenue

    from {{ ref('int_availabilities_pivoted_to_vacancies') }}

),

listings as (

    select * from {{ ref('stg_raw__listings') }}

),

base_and_listings_joined as (

    select
        base.listing_id,
        base.duration_id,
        base.duration_type,
        listings.amenities,

        base.duration,
        base.allowable_nights,
        base.revenue,

        base.start_date,
        base.end_date

    from reservations_and_vacancies_joined as base
        left join listings using (listing_id)

)

select * from base_and_listings_joined