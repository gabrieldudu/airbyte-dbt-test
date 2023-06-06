
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_game_indices"
select
    _airbyte_game_indices_hashid,
    jsonb_extract_path_text("version", 'name') as "name",
    jsonb_extract_path_text("version", 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_game_indices" as table_alias
-- version at pokemon/game_indices/version
where 1 = 1
and "version" is not null