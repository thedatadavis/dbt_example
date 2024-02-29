with revenue as (

    select
        date_trunc('month', calendar_date) as month_booked,
        sum(nightly_price) as total_revenue,
        sum(case when has_air_conditioning = true then nightly_price else 0 end) as segment_revenue
    
    from {{ ref('occupancies') }}
    
    where is_available = false 
    
    group by 1
    
)

select 
    *,
    round(segment_revenue/total_revenue, 3) as percent_of_revenue_with_no_ac

from revenue