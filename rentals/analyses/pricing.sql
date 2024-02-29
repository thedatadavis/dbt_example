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

)

select * from pricing