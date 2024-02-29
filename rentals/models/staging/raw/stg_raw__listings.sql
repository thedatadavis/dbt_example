with source as (
      select * from {{ source('csv_imports', 'listings') }}
),

renamed as (

    select
        -- property info
        id as listing_id,
        name as listing_name,
        neighborhood,
        property_type,
        room_type,
        amenities,

        accommodates,
        bathrooms_text,
        cast(REGEXP_SUBSTR(bathrooms_text, '^[0-9.]+') as decimal(10,2)) as bathrooms,
        bedrooms,
        beds,
        price as original_nightly_price_text,
        cast(replace(price, '$', '') as decimal(10,2)) as original_nightly_price,   

        -- host info
        host_id,
        host_name,
        host_location,
        host_verifications,
        host_since::date as host_start_date,

        -- review info
        number_of_reviews,
        review_scores_rating as average_rating,
        first_review as first_review_date,
        last_review as last_review_date

    from source
)

select * from renamed
  