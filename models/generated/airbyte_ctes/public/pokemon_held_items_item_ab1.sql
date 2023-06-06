
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."pokemon_held_items"
select
    _airbyte_held_items_hashid,
    jsonb_extract_path_text(item, 'name') as "name",
    jsonb_extract_path_text(item, 'url') as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."pokemon_held_items" as table_alias
-- item at pokemon/held_items/item
where 1 = 1
and item is not null