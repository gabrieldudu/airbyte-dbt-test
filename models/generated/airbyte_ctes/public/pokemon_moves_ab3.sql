
with __dbt__cte__pokemon_moves_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    jsonb_extract_path(_airbyte_nested_data, 'version_group_details') as version_group_details,
    
        jsonb_extract_path(_airbyte_nested_data, 'move')
     as "move",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- moves at pokemon/moves
cross join jsonb_array_elements(
        case jsonb_typeof(moves)
        when 'array' then moves
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and moves is not null
),  __dbt__cte__pokemon_moves_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_moves_ab1
select
    _airbyte_pokemon_hashid,
    version_group_details,
    cast("move" as 
    jsonb
) as "move",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_moves_ab1
-- moves at pokemon/moves
where 1 = 1
)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_moves_ab2
select
    md5(cast(coalesce(cast(_airbyte_pokemon_hashid as text), '') || '-' || coalesce(cast(version_group_details as text), '') || '-' || coalesce(cast("move" as text), '') as text)) as _airbyte_moves_hashid,
    tmp.*
from __dbt__cte__pokemon_moves_ab2 tmp
-- moves at pokemon/moves
where 1 = 1