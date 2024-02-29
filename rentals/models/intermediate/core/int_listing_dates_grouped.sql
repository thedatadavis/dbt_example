with dates as (

    select
        listing_date_key,
        listing_id,
        coalesce(reservation_id, 'NONE') as reservation_id,
        
        row_number() over (partition by listing_id order by calendar_date) as row_num,
        concat(listing_id,'-', coalesce(reservation_id, 'NONE'), '-', is_available) as test_val,

        calendar_date
    
    from {{ ref('stg_raw__calendar') }}

),

prep_data as (

    select
        listing_date_key,
        listing_id,
        reservation_id,

        -- Prep for labeling durations between reservations
        case
            when row_num = 1 then 1
            when test_val != lag(test_val, 1) over (partition by listing_id order by calendar_date) then 1
            else 0
        end as window_start,

        calendar_date

    from dates

    -- Essential for grouping nulls appropropriately
    order by listing_id, calendar_date
    
),

group_windows as (

    select
        listing_date_key,
        listing_id,
        reservation_id,
        window_start,

        -- Rolling sum of window_start to increment block groups
        sum(window_start) over (
            partition by listing_id 
            order by calendar_date 
            rows between unbounded preceding and current row
        ) as window_num,
        
        calendar_date

    from prep_data
),

join_data as (

    select
        prep_data.listing_date_key,
        prep_data.listing_id,
        prep_data.reservation_id,
        prep_data.window_start,
        group_windows.window_num,
        
        concat(prep_data.listing_id, '-', group_windows.window_num) as listing_window,

        prep_data.calendar_date
    
    from prep_data
        left join group_windows 
            on prep_data.listing_id = group_windows.listing_id
            and prep_data.calendar_date = group_windows.calendar_date
),

final as (

    select
        listing_date_key,
        listing_window
    
    from join_data
    
)

select * from final