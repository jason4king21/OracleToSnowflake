with source as (
  select * from {{ source('ont_raw', 'raw_oe_order_holds_all') }}
),

cleaned as (
  select
    order_hold_id,
    creation_date::timestamp_ntz  as created_at,
    created_by,
    last_update_date::timestamp_ntz as last_updated_at,
    last_updated_by,
    last_update_login::number       as last_update_login,
    hold_source_id,
    hold_release_id,
    header_id,
    line_id::number                 as line_id,
    org_id,
    context,
    released_flag,
    inst_id,
    credit_profile_level,
    rnum::number                    as rnum
  from source
)

select * from cleaned
