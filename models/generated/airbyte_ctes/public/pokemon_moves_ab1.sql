
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