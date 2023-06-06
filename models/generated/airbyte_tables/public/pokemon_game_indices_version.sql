
with __dbt__cte__pokemon_game_indices_version_ab1 as (

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
),  __dbt__cte__pokemon_game_indices_version_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_game_indices_version_ab1
select
    _airbyte_game_indices_hashid,
    cast("name" as text) as "name",
    cast(url as text) as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_game_indices_version_ab1
-- version at pokemon/game_indices/version
where 1 = 1
),  __dbt__cte__pokemon_game_indices_version_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_game_indices_version_ab2
select
    md5(cast(coalesce(cast(_airbyte_game_indices_hashid as text), '') || '-' || coalesce(cast("name" as text), '') || '-' || coalesce(cast(url as text), '') as text)) as _airbyte_version_hashid,
    tmp.*
from __dbt__cte__pokemon_game_indices_version_ab2 tmp
-- version at pokemon/game_indices/version
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__pokemon_game_indices_version_ab3
select
    _airbyte_game_indices_hashid,
    "name",
    url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_version_hashid
from __dbt__cte__pokemon_game_indices_version_ab3
-- version at pokemon/game_indices/version from "postgres".public."pokemon_game_indices"
where 1 = 1