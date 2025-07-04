with source as (
  select * from {{ source('ont_raw', 'raw_oe_order_price_attribs') }}
),

cleaned as (
  select
    header_id,
    line_id::number                     as line_id,
    creation_date::timestamp_ntz        as created_at,
    created_by,
    last_update_date::timestamp_ntz     as last_updated_at,
    last_updated_by,
    last_update_login::number           as last_update_login,
    pricing_context,
    context,
    flex_title,
    order_price_attrib_id,
    override_flag,
    orig_sys_atts_ref,
    inst_id,
    rnum::number                        as rnum
  from source
)

select * from cleaned
