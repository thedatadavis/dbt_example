with daily_rate_by_neighborhood as (

    select
        'neighborhood' as category_type,
        neighborhood as category,
        available_date,
        avg(daily_rate) as avg_daily_price,
        avg(case when is_available = false then daily_rate end) as avg_booked_price,
        avg(case when is_available = true then daily_rate end) as avg_vacancy_price
    
    from {{ ref('int_availabilities_joined_to_listings') }}
    
    group by 1, 2, 3
),

daily_rate_by_room_type as (

    select
        'room_type' as category_type,
        room_type as category,
        available_date,
        avg(daily_rate) as avg_daily_price,
        avg(case when is_available = false then daily_rate end) as avg_booked_price,
        avg(case when is_available = true then daily_rate end) as avg_vacancy_price
    
    from {{ ref('int_availabilities_joined_to_listings') }}
    
    group by 1, 2, 3

),

union_all as (

    select * from daily_rate_by_neighborhood

    union all

    select * from daily_rate_by_room_type
)

select * from union_all