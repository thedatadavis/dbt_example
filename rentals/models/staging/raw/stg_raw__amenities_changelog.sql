with source as (
      select * from {{ source('csv_imports', 'amenities_changelog') }}
),

renamed as (
    select
        
        listing_id,
        amenities,
        change_at as change_date

    from source
)

select * from renamed
  