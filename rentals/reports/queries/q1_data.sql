select *

from {{ ref('int_availabilities_joined_to_listings') }}

where is_available = false