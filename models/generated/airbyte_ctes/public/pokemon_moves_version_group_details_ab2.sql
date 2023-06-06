
with __dbt__cte__pokemon_moves_version_group_details_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_moves"

select
    _airbyte_moves_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'level_learned_at') as level_learned_at,
    
        jsonb_extract_path(_airbyte_nested_data, 'version_group')
     as version_group,
    
        jsonb_extract_path(_airbyte_nested_data, 'move_learn_method')
     as move_learn_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_moves" as table_alias
-- version_group_details at pokemon/moves/version_group_details
cross join jsonb_array_elements(
        case jsonb_typeof(version_group_details)
        when 'array' then version_group_details
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and version_group_details is not null
)-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_moves_version_group_details_ab1
select
    _airbyte_moves_hashid,
    cast(level_learned_at as 
    bigint
) as level_learned_at,
    cast(version_group as 
    jsonb
) as version_group,
    cast(move_learn_method as 
    jsonb
) as move_learn_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_moves_version_group_details_ab1
-- version_group_details at pokemon/moves/version_group_details
where 1 = 1