{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('passivedata_c8624_default_rtdb_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('value'),
        adapter.quote('key'),
    ]) }} as _airbyte_passivedata__4_default_rtdb_hashid,
    tmp.*
from {{ ref('passivedata_c8624_default_rtdb_ab2') }} tmp
-- passivedata_c8624_default_rtdb
where 1 = 1

