
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_moves"

select
    _airbyte_moves_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'level_learned_at') as level_learned_at,
    
        jsonb_extract_path(_airbyte_nested_data, 'version_group')
     as version_group,
    
        jsonb_extract_path(_airbyte_nested_data, 'move_learn_method')
     as move_learn_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_moves" as table_alias
-- version_group_details at pokemon/moves/version_group_details
cross join jsonb_array_elements(
        case jsonb_typeof(version_group_details)
        when 'array' then version_group_details
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and version_group_details is not null