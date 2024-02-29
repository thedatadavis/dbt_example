with pricing as (

    {%- set categories = ['neighborhood', 'property_type', 'room_type'] -%}
    {%- set column_names = dbt_utils.get_filtered_columns_in_relation(ref('occupancies')) -%}

    {% for category in categories %}
    select 

        '{{ category }}' as category_type,

        {% for column_name in column_names -%}
        {% if column_name.lower() == category %}{{ column_name }} as category,{%- endif %}
        {%- endfor %}

        calendar_date,

        avg(nightly_price) as avg_daily_price,
        avg(case when is_available = false then nightly_price end) as avg_booked_price,
        avg(case when is_available = true then nightly_price end) as avg_vacancy_price

    from {{ ref('occupancies') }}

    group by 1, 2, 3

    {% if not loop.last -%} union all {%- endif %}

    {% endfor %}

    order by 1, 2, 3

),

neighborhoods as (

    select distinct category
    from pricing
    where category_type = 'neighborhood'
),

start_price as (

    select category, avg_daily_price 
    from pricing
    where calendar_date = '2021-07-12'
    
),

end_price as (
    select category, avg_daily_price 
    from pricing
    where calendar_date = '2022-07-11'
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