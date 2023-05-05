{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('passivedata_c8624_default_rtdb_ab1') }}
select
    cast({{ adapter.quote('value') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('value') }},
    cast({{ adapter.quote('key') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('key') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('passivedata_c8624_default_rtdb_ab1') }}
-- passivedata_c8624_default_rtdb
where 1 = 1

