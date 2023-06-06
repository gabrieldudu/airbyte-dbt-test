
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"
select
    _airbyte_pokemon_hashid,
    jsonb_extract_path_text(sprites, 'back_shiny_female') as back_shiny_female,
    jsonb_extract_path_text(sprites, 'back_female') as back_female,
    jsonb_extract_path_text(sprites, 'back_default') as back_default,
    jsonb_extract_path_text(sprites, 'front_shiny_female') as front_shiny_female,
    jsonb_extract_path_text(sprites, 'front_default') as front_default,
    jsonb_extract_path_text(sprites, 'front_female') as front_female,
    jsonb_extract_path_text(sprites, 'back_shiny') as back_shiny,
    jsonb_extract_path_text(sprites, 'front_shiny') as front_shiny,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- sprites at pokemon/sprites
where 1 = 1
and sprites is not null