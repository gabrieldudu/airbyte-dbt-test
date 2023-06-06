
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public._airbyte_raw_pokemon
select
    jsonb_extract_path_text(_airbyte_data, 'location_area_encounters') as location_area_encounters,
    jsonb_extract_path(_airbyte_data, 'types') as "types",
    jsonb_extract_path_text(_airbyte_data, 'is_default ') as "is_default ",
    jsonb_extract_path_text(_airbyte_data, 'base_experience') as base_experience,
    jsonb_extract_path(_airbyte_data, 'held_items') as held_items,
    jsonb_extract_path_text(_airbyte_data, 'weight') as weight,
    
        jsonb_extract_path(table_alias._airbyte_data, 'sprites')
     as sprites,
    jsonb_extract_path(_airbyte_data, 'abilities') as abilities,
    jsonb_extract_path(_airbyte_data, 'game_indices') as game_indices,
    jsonb_extract_path(_airbyte_data, 'stats') as stats,
    
        jsonb_extract_path(table_alias._airbyte_data, 'species')
     as species,
    jsonb_extract_path(_airbyte_data, 'moves') as moves,
    jsonb_extract_path_text(_airbyte_data, 'name') as "name",
    jsonb_extract_path_text(_airbyte_data, 'id') as "id",
    jsonb_extract_path(_airbyte_data, 'forms') as forms,
    jsonb_extract_path_text(_airbyte_data, 'order') as "order",
    jsonb_extract_path_text(_airbyte_data, 'height') as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public._airbyte_raw_pokemon as table_alias
-- pokemon
where 1 = 1