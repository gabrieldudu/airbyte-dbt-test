
with __dbt__cte__pokemon_ab1 as (

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
)-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_ab1
select
    cast(location_area_encounters as text) as location_area_encounters,
    "types",
    cast("is_default " as boolean) as "is_default ",
    cast(base_experience as 
    bigint
) as base_experience,
    held_items,
    cast(weight as 
    bigint
) as weight,
    cast(sprites as 
    jsonb
) as sprites,
    abilities,
    game_indices,
    stats,
    cast(species as 
    jsonb
) as species,
    moves,
    cast("name" as text) as "name",
    cast("id" as 
    bigint
) as "id",
    forms,
    cast("order" as 
    bigint
) as "order",
    cast(height as 
    bigint
) as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_ab1
-- pokemon
where 1 = 1