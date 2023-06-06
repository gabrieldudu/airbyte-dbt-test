
with __dbt__cte__pokemon_types_type_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_types"
select
    _airbyte_types_hashid,
    jsonb_extract_path_text("type", 'name') as "name",
    jsonb_extract_path_text("type", 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_types" as table_alias
-- type at pokemon/types/type
where 1 = 1
and "type" is not null
)-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_types_type_ab1
select
    _airbyte_types_hashid,
    cast("name" as text) as "name",
    cast(url as text) as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_types_type_ab1
-- type at pokemon/types/type
where 1 = 1