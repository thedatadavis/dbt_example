{{
    config(
        docs={'node_color': 'orange'}
    )
}}

with neighborhoods as (

    select distinct category
    from {{ ref('daily_pricing_by_category')}} 
    where category_type = 'neighborhood'
),

start_price as (

    select category, avg_daily_price 
    from {{ ref('daily_pricing_by_category')}} 
    where available_date = '2021-07-12'
    
),

end_price as (
    select category, avg_daily_price 
    from {{ ref('daily_pricing_by_category')}} 
    where available_date = '2022-07-11'
)

select
    neighborhoods.category,
    start_price.avg_daily_price as start_price,
    end_price.avg_daily_price as end_price,
    end_price.avg_daily_price - start_price.avg_daily_price as price_change

from neighborhoods
    inner join start_price on neighborhoods.category = start_price.category
    inner join end_price on neighborhoods.category = end_price.category

order by 1