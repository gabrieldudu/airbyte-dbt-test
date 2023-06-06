
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_held_items"

select
    _airbyte_held_items_hashid,
    
        jsonb_extract_path(_airbyte_nested_data, 'version')
     as "version",
    jsonb_extract_path_text(_airbyte_nested_data, 'rarity') as rarity,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_held_items" as table_alias
-- version_details at pokemon/held_items/version_details
cross join jsonb_array_elements(
        case jsonb_typeof(version_details)
        when 'array' then version_details
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and version_details is not null