
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"
select
    _airbyte_pokemon_hashid,
    jsonb_extract_path_text(species, 'name') as "name",
    jsonb_extract_path_text(species, 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- species at pokemon/species
where 1 = 1
and species is not null