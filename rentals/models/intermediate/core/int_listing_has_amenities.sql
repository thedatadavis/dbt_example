{%- set lookups = dbt_utils.get_column_values(table=ref('int_distinct_amenities'), column='lookup') -%}

with listings as (

    select 
        listing_id,
        amenities,
        {% for lookup in lookups -%}
        {% set item = lookup.split('|') -%}
        case 
            when array_contains('{{ item[0] }}'::variant, parse_json(amenities)) 
                then true 
            else false 
        end as {{ item[1] }},
        {% endfor %}

    from {{ ref('stg_raw__listings') }}        
)

select * from listings