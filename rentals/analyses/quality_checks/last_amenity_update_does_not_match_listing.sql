-- We need to be verify that the listings table contains the latest amenity changes.
-- Otherwise, we need to create a separate model to join in the updated data.

-- Returns records if additional handling required.

with ranked_changelog as (

    select
        listing_id,
        amenities,
        row_number() over (partition by listing_id order by change_date desc) as row_num
    from {{ ref("stg_raw__amenities_changelog") }}
    
),

joined as (

    select 
        listings.listing_id,
        listings.amenities as listings_amenities,
        changelog.amenities as changelog_amenities,
        parse_json(listings.amenities) = parse_json(changelog.amenities) as values_match
    
    from {{ ref("stg_raw__listings") }} as listings
        left join ranked_changelog as changelog using(listing_id)
    
    where row_num = 1

)

select * from joined where values_match = false