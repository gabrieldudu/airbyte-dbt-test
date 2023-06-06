
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'name') as "name",
    jsonb_extract_path_text(_airbyte_nested_data, 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- forms at pokemon/forms
cross join jsonb_array_elements(
        case jsonb_typeof(forms)
        when 'array' then forms
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and forms is not null