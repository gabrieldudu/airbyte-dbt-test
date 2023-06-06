
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'slot') as slot,
    
        jsonb_extract_path(_airbyte_nested_data, 'type')
     as "type",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- types at pokemon/types
cross join jsonb_array_elements(
        case jsonb_typeof("types")
        when 'array' then "types"
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and "types" is not null