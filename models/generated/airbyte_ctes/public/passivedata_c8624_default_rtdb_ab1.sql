{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_passivedata_c8624_default_rtdb') }}
select
    {{ json_extract_scalar('_airbyte_data', ['value'], ['value']) }} as {{ adapter.quote('value') }},
    {{ json_extract_scalar('_airbyte_data', ['key'], ['key']) }} as {{ adapter.quote('key') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_passivedata_c8624_default_rtdb') }} as table_alias
-- passivedata_c8624_default_rtdb
where 1 = 1

