
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