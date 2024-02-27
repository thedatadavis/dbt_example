with source as (
      select * from {{ source('csv_imports', 'calendar') }}
),

renamed as (
    select
        
        {{ dbt_utils.generate_surrogate_key(['date', 'listing_id']) }} as availability_id,
        listing_id,
        reservation_id,

        price::decimal(10,2) as daily_rate,        
        minimum_nights,
        maximum_nights,

        available as is_available,

        date as available_date

    from source
)

select * from renamed
  