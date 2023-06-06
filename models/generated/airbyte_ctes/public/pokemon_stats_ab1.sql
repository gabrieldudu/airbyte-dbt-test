
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    
        jsonb_extract_path(_airbyte_nested_data, 'stat')
     as stat,
    jsonb_extract_path_text(_airbyte_nested_data, 'base_stat') as base_stat,
    jsonb_extract_path_text(_airbyte_nested_data, 'effort') as effort,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- stats at pokemon/stats
cross join jsonb_array_elements(
        case jsonb_typeof(stats)
        when 'array' then stats
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and stats is not null