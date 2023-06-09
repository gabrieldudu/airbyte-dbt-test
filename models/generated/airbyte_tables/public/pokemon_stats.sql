
with __dbt__cte__pokemon_stats_ab1 as (

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
),  __dbt__cte__pokemon_stats_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_stats_ab1
select
    _airbyte_pokemon_hashid,
    cast(stat as 
    jsonb
) as stat,
    cast(base_stat as 
    bigint
) as base_stat,
    cast(effort as 
    bigint
) as effort,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_stats_ab1
-- stats at pokemon/stats
where 1 = 1
),  __dbt__cte__pokemon_stats_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_stats_ab2
select
    md5(cast(coalesce(cast(_airbyte_pokemon_hashid as text), '') || '-' || coalesce(cast(stat as text), '') || '-' || coalesce(cast(base_stat as text), '') || '-' || coalesce(cast(effort as text), '') as text)) as _airbyte_stats_hashid,
    tmp.*
from __dbt__cte__pokemon_stats_ab2 tmp
-- stats at pokemon/stats
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__pokemon_stats_ab3
select
    _airbyte_pokemon_hashid,
    stat,
    base_stat,
    effort,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_stats_hashid
from __dbt__cte__pokemon_stats_ab3
-- stats at pokemon/stats from "postgres".public."pokemon"
where 1 = 1