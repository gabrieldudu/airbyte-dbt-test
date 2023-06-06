
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_types"
select
    _airbyte_types_hashid,
    jsonb_extract_path_text("type", 'name') as "name",
    jsonb_extract_path_text("type", 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_types" as table_alias
-- type at pokemon/types/type
where 1 = 1
and "type" is not null