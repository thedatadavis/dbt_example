with base as (

    select
        listing_id,
        available_date,
        reservation_id,
        daily_rate,
        maximum_nights,
        case when reservation_id = 'NULL' then 1 else 0 end as vacant_flag
        
    from {{ ref('stg_raw__availabilities') }}

),

group_vacancies as (
    -- Use dense_rank to group the sums

    select
        listing_id,
        available_date,
        reservation_id,
        daily_rate,
        maximum_nights,
        vacant_flag,
        dense_rank() over (partition by listing_id order by reset_group_total) as vacant_group,

    from (
        -- Rolling sum of the edges

        select
            listing_id,
            available_date,
            reservation_id,
            daily_rate,
            maximum_nights,
            vacant_flag,
            sum(reset_group) over (partition by listing_id order by available_date) as reset_group_total

        from (
            -- Find the edges of each group

            select
                listing_id,
                available_date,
                reservation_id,
                daily_rate,
                maximum_nights,
                vacant_flag,
                case when lag(vacant_flag, 1, -1) over (partition by listing_id order by available_date) <> vacant_flag then 1 else 0 end as reset_group
            
            from base

        ) as calc_reset_group

    ) as sum_reset_group

)

select
    listing_id,
    concat(vacant_group * 100000 + listing_id) as vacancy_id, -- psuedo key to make union easier
    min(available_date) as start_date,
    max(available_date) as end_date,
    count(*) as duration,
    min(maximum_nights) as allowable_nights,
    sum(daily_rate) * -1 as missed_revenue

from group_vacancies

where vacant_flag = 1

group by 1, 2

order by 1, 3