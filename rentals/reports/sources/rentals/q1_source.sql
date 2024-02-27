

with overall_revenue as (

    select
        date_trunc('month', available_date) as month_booked,
        sum(daily_rate) as revenue
    
    from rentals.intermediate.int_availabilities_joined_to_listings
    
    where is_available = false 
    
    group by 1

),

segment_revenue as (

    select
        date_trunc('month', available_date) as month_booked,
        sum(daily_rate) as revenue
    
    from rentals.intermediate.int_availabilities_joined_to_listings
    
    where is_available = false 
        and array_contains('Air conditioning'::variant, parse_json(amenities))
    
    group by 1
    
),

join_totals as (

    select
        overall_revenue.month_booked,
        overall_revenue.revenue as total_revenue,
        coalesce(segment_revenue.revenue, 0) as segment_with_ac_revenue,
        round(coalesce(segment_revenue.revenue, 0)/overall_revenue.revenue, 3) as segment_as_percent_of_total

    from overall_revenue
        left join segment_revenue using(month_booked)
        
)

select * from join_totals