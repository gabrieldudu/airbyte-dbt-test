
with __dbt__cte__pokemon_held_items_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    
        jsonb_extract_path(_airbyte_nested_data, 'item')
     as item,
    jsonb_extract_path(_airbyte_nested_data, 'version_details') as version_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- held_items at pokemon/held_items
cross join jsonb_array_elements(
        case jsonb_typeof(held_items)
        when 'array' then held_items
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and held_items is not null
),  __dbt__cte__pokemon_held_items_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_held_items_ab1
select
    _airbyte_pokemon_hashid,
    cast(item as 
    jsonb
) as item,
    version_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_held_items_ab1
-- held_items at pokemon/held_items
where 1 = 1
)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_held_items_ab2
select
    md5(cast(coalesce(cast(_airbyte_pokemon_hashid as text), '') || '-' || coalesce(cast(item as text), '') || '-' || coalesce(cast(version_details as text), '') as text)) as _airbyte_held_items_hashid,
    tmp.*
from __dbt__cte__pokemon_held_items_ab2 tmp
-- held_items at pokemon/held_items
where 1 = 1