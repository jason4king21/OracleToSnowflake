with source as (
  select * from {{ source('ar_raw', 'raw_hz_party_sites') }}
),

cleaned as (
  select
    party_site_id,
    party_id,
    location_id,
    last_update_date::timestamp_ntz    as last_updated_at,
    party_site_number,
    creation_date::timestamp_ntz       as created_at,
    orig_system_reference,
    start_date_active::date            as start_date_active,
    end_date_active::date              as end_date_active,
    region,
    mailstop,
    identifying_address_flag,
    status,
    party_site_name,
    addressee,
    global_location_number,
    rnum::number                       as rnum
  from source
)

select * from cleaned
