with source as (
  select * from {{ source('ar_raw', 'raw_hz_locations') }}
),

cleaned as (
  select
    location_id,
    last_update_date::timestamp_ntz       as last_updated_at,
    last_updated_by,
    creation_date::timestamp_ntz          as created_at,
    created_by,
    last_update_login,
    orig_system_reference,
    country,
    address1,
    address2,
    address3,
    address4,
    city,
    postal_code,
    state,
    province,
    county,
    validated_flag,
    apartment_flag,
    po_box_number,
    street,
    time_zone,
    overseas_address_flag,
    address_effective_date::timestamp_ntz   as address_effective_at,
    address_expiration_date::timestamp_ntz  as address_expiration_at,
    sales_tax_inside_city_limits,
    rnum::number                              as rnum
  from source
)

select * from cleaned
