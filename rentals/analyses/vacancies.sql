select
    *

from {{ ref('occupancies') }}

where is_available = true 
