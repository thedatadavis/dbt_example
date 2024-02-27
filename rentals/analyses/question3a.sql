select
    listing_id,

    -- Some vacancy blocks run longer than the maximum nights allowed for that date range
    -- Take the lesser of those two values
    -- Then take the max to get the largest across all vacancy blocks
    max(least(duration, allowable_nights)) as max_availability 

from {{ ref('durations') }}

where duration_type = 'vacancy'

group by 1

order by 2 desc