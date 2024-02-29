with reviews as (

    select *
    
    from {{ ref('stg_raw__reviews') }}

),

listings as (

    select *
    
    from {{ ref('stg_raw__listings') }}

),

reviews_joined_to_listings as (

    select
        review_id,
        review_score,
        review_date,
        listings.*

    from reviews
        left join listings
            on reviews.listing_id = listings.listing_id

)

select * from reviews_joined_to_listings