with source as (
  select * from {{ source('ar_raw', 'raw_hz_party_site_uses') }}
),

cleaned as (
  select
    party_site_use_id,
    begin_date::timestamp_ntz          as begin_date,
    end_date::date                     as end_date,
    party_site_id,
    site_use_type,
    primary_per_type                  as primary_flag,
    status,
    comments,
    creation_date::timestamp_ntz      as created_at,
    last_update_date::timestamp_ntz   as last_updated_at,
    rnum::number                      as rnum
  from source
)

select * from cleaned
