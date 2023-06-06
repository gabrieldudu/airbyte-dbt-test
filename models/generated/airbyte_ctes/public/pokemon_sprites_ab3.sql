
with __dbt__cte__pokemon_sprites_ab1 as (

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
),  __dbt__cte__pokemon_sprites_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_sprites_ab1
select
    _airbyte_pokemon_hashid,
    cast(back_shiny_female as text) as back_shiny_female,
    cast(back_female as text) as back_female,
    cast(back_default as text) as back_default,
    cast(front_shiny_female as text) as front_shiny_female,
    cast(front_default as text) as front_default,
    cast(front_female as text) as front_female,
    cast(back_shiny as text) as back_shiny,
    cast(front_shiny as text) as front_shiny,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_sprites_ab1
-- sprites at pokemon/sprites
where 1 = 1
)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_sprites_ab2
select
    md5(cast(coalesce(cast(_airbyte_pokemon_hashid as text), '') || '-' || coalesce(cast(back_shiny_female as text), '') || '-' || coalesce(cast(back_female as text), '') || '-' || coalesce(cast(back_default as text), '') || '-' || coalesce(cast(front_shiny_female as text), '') || '-' || coalesce(cast(front_default as text), '') || '-' || coalesce(cast(front_female as text), '') || '-' || coalesce(cast(back_shiny as text), '') || '-' || coalesce(cast(front_shiny as text), '') as text)) as _airbyte_sprites_hashid,
    tmp.*
from __dbt__cte__pokemon_sprites_ab2 tmp
-- sprites at pokemon/sprites
where 1 = 1