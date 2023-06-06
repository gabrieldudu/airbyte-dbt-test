
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_moves_version_group_details"
select
    _airbyte_version_group_details_hashid,
    jsonb_extract_path_text(version_group, 'name') as "name",
    jsonb_extract_path_text(version_group, 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_moves_version_group_details" as table_alias
-- version_group at pokemon/moves/version_group_details/version_group
where 1 = 1
and version_group is not null