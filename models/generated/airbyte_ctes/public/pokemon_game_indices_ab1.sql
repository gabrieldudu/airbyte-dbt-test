
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'game_index') as game_index,
    
        jsonb_extract_path(_airbyte_nested_data, 'version')
     as "version",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- game_indices at pokemon/game_indices
cross join jsonb_array_elements(
        case jsonb_typeof(game_indices)
        when 'array' then game_indices
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and game_indices is not null