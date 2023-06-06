
with __dbt__cte__pokemon_abilities_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon"

select
    _airbyte_pokemon_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'is_hidden') as is_hidden,
    jsonb_extract_path_text(_airbyte_nested_data, 'slot') as slot,
    
        jsonb_extract_path(_airbyte_nested_data, 'ability')
     as ability,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon" as table_alias
-- abilities at pokemon/abilities
cross join jsonb_array_elements(
        case jsonb_typeof(abilities)
        when 'array' then abilities
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and abilities is not null
),  __dbt__cte__pokemon_abilities_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_abilities_ab1
select
    _airbyte_pokemon_hashid,
    cast(is_hidden as boolean) as is_hidden,
    cast(slot as 
    bigint
) as slot,
    cast(ability as 
    jsonb
) as ability,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_abilities_ab1
-- abilities at pokemon/abilities
where 1 = 1
)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_abilities_ab2
select
    md5(cast(coalesce(cast(_airbyte_pokemon_hashid as text), '') || '-' || coalesce(cast(is_hidden as text), '') || '-' || coalesce(cast(slot as text), '') || '-' || coalesce(cast(ability as text), '') as text)) as _airbyte_abilities_hashid,
    tmp.*
from __dbt__cte__pokemon_abilities_ab2 tmp
-- abilities at pokemon/abilities
where 1 = 1