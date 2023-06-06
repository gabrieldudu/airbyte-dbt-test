
with __dbt__cte__pokemon_game_indices_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'game_index') as game_index,
    
        jsonb_extract_path(_airbyte_nested_data, 'version')
     as "version",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- game_indices at pokemon/game_indices
cross join jsonb_array_elements(
        case jsonb_typeof(game_indices)
        when 'array' then game_indices
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and game_indices is not null
),  __dbt__cte__pokemon_game_indices_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_game_indices_ab1
select
    _airbyte_pokemon_hashid,
    cast(game_index as 
    bigint
) as game_index,
    cast("version" as 
    jsonb
) as "version",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_game_indices_ab1
-- game_indices at pokemon/game_indices
where 1 = 1
)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_game_indices_ab2
select
    md5(cast(coalesce(cast(_airbyte_pokemon_hashid as text), '') || '-' || coalesce(cast(game_index as text), '') || '-' || coalesce(cast("version" as text), '') as text)) as _airbyte_game_indices_hashid,
    tmp.*
from __dbt__cte__pokemon_game_indices_ab2 tmp
-- game_indices at pokemon/game_indices
where 1 = 1