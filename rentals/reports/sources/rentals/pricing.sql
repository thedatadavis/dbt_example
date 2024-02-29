with pricing as (
    select 

        'neighborhood' as category_type,

        NEIGHBORHOOD as category,

        calendar_date,

        avg(nightly_price) as avg_daily_price,
        avg(case when is_available = false then nightly_price end) as avg_booked_price,
        avg(case when is_available = true then nightly_price end) as avg_vacancy_price

    from rentals.marts.occupancies

    group by 1, 2, 3

    union all

    
    select 

        'property_type' as category_type,

        PROPERTY_TYPE as category,

        calendar_date,

        avg(nightly_price) as avg_daily_price,
        avg(case when is_available = false then nightly_price end) as avg_booked_price,
        avg(case when is_available = true then nightly_price end) as avg_vacancy_price

    from rentals.marts.occupancies

    group by 1, 2, 3

    union all

    
    select 

        'room_type' as category_type,

        ROOM_TYPE as category,

        calendar_date,

        avg(nightly_price) as avg_daily_price,
        avg(case when is_available = false then nightly_price end) as avg_booked_price,
        avg(case when is_available = true then nightly_price end) as avg_vacancy_price

    from rentals.marts.occupancies

    group by 1, 2, 3

    

    

    order by 1, 2, 3

)

select * from pricing