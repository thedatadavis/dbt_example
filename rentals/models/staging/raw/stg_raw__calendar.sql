with source as (

      select * from {{ source('csv_imports', 'calendar') }}
),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['listing_id', 'date']) }} as listing_date_key,
        listing_id,
        
        -- Standardize as null value to match expectations
        iff(reservation_id = 'NULL', null, reservation_id) as reservation_id,
        
        price::decimal(10,2) as nightly_price,
        minimum_nights,
        maximum_nights,

        available as is_available,

        date as calendar_date

    from source

)

select * from renamed