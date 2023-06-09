
with __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_moves_version_group_details"
select
    _airbyte_version_group_details_hashid,
    jsonb_extract_path_text(move_learn_method, 'name') as "name",
    jsonb_extract_path_text(move_learn_method, 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_moves_version_group_details" as table_alias
-- move_learn_method at pokemon/moves/version_group_details/move_learn_method
where 1 = 1
and move_learn_method is not null
),  __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab1
select
    _airbyte_version_group_details_hashid,
    cast("name" as text) as "name",
    cast(url as text) as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab1
-- move_learn_method at pokemon/moves/version_group_details/move_learn_method
where 1 = 1
),  __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab2
select
    md5(cast(coalesce(cast(_airbyte_version_group_details_hashid as text), '') || '-' || coalesce(cast("name" as text), '') || '-' || coalesce(cast(url as text), '') as text)) as _airbyte_move_learn_method_hashid,
    tmp.*
from __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab2 tmp
-- move_learn_method at pokemon/moves/version_group_details/move_learn_method
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab3
select
    _airbyte_version_group_details_hashid,
    "name",
    url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_move_learn_method_hashid
from __dbt__cte__pokemon_moves_versio__ils_move_learn_method_ab3
-- move_learn_method at pokemon/moves/version_group_details/move_learn_method from "postgres".public."pokemon_moves_version_group_details"
where 1 = 1