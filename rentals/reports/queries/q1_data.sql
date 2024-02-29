with revenue as (

    select
        date_trunc('month', calendar_date) as booked_month,
        sum(nightly_price) as total_revenue,
        sum(case when has_air_conditioning = true then nightly_price else 0 end) as segment_revenue
    
    from occupancies

    where is_available = false
    
    group by 1
    
),

chart_data as (

    select 
        date_add(booked_month, interval 1 day) as display_date,
        total_revenue,
        segment_revenue,
        total_revenue - segment_revenue as non_segment_revenue,
        round(segment_revenue/total_revenue, 3) as segment_pct,
        1 - round(segment_revenue/total_revenue, 3) as non_segment_pct

    from revenue

    order by 1

)

select *

from chart_data