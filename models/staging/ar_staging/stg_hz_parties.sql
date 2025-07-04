with source as (
  select * from {{ source('ar_raw', 'raw_hz_parties') }}
),

cleaned as (
  select
    party_id,
    party_number,
    party_name,
    party_type,
    validated_flag::boolean       as validated_flag,
    creation_date::timestamp_ntz  as created_at,
    last_update_date::timestamp_ntz as last_updated_at,
    sic_code,
    country,
    city,
    state,
    postal_code,
    email_address,
    person_first_name,
    person_last_name,
    rnum::number                  as rnum
  from source
)

select * from cleaned
