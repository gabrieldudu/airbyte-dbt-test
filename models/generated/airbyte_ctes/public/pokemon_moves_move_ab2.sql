
with __dbt__cte__pokemon_moves_move_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_moves"
select
    _airbyte_moves_hashid,
    jsonb_extract_path_text("move", 'name') as "name",
    jsonb_extract_path_text("move", 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_moves" as table_alias
-- move at pokemon/moves/move
where 1 = 1
and "move" is not null
)-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_moves_move_ab1
select
    _airbyte_moves_hashid,
    cast("name" as text) as "name",
    cast(url as text) as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_moves_move_ab1
-- move at pokemon/moves/move
where 1 = 1