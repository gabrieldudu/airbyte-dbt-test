
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_stats"
select
    _airbyte_stats_hashid,
    jsonb_extract_path_text(stat, 'name') as "name",
    jsonb_extract_path_text(stat, 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_stats" as table_alias
-- stat at pokemon/stats/stat
where 1 = 1
and stat is not null