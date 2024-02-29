-- Calculating revenue based on available amenities 
-- should account for when amenities are added to a particular listing.

-- Return records if additional handling required.

with calendar_start as (

    select
        min(calendar_date) as min_date

    from staging.staging.stg_raw__calendar

),

changes_after_calendar_start as (

    select
        *
    
    from staging.staging.stg_raw__amenities_changelog

    where change_date > (select min_date from calendar_start)

)

select * from changes_after_calendar_start