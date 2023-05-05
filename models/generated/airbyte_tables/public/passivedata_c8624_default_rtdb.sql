{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='passivedata_c8624_default_rtdb_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('passivedata_c8624_default_rtdb_ab3') }}
select
    {{ adapter.quote('value') }},
    {{ adapter.quote('key') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_passivedata__4_default_rtdb_hashid
from {{ ref('passivedata_c8624_default_rtdb_ab3') }}
-- passivedata_c8624_default_rtdb from {{ source('public', '_airbyte_raw_passivedata_c8624_default_rtdb') }}
where 1 = 1

