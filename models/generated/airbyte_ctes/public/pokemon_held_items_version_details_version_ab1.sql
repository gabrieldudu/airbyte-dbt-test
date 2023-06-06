
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_held_items_version_details"
select
    _airbyte_version_details_hashid,
    jsonb_extract_path_text("version", 'name') as "name",
    jsonb_extract_path_text("version", 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_held_items_version_details" as table_alias
-- version at pokemon/held_items/version_details/version
where 1 = 1
and "version" is not null