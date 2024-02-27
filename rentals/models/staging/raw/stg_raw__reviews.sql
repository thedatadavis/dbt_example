with source as (
      select * from {{ source('csv_imports', 'generated_reviews') }}
),

renamed as (
    select
        
        id as review_id,
        listing_id,

        review_score,

        review_date

    from source
)

select * from renamed
  