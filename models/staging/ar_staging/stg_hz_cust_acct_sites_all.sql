with source as (
  select * from {{ source('ar_raw', 'raw_hz_cust_acct_sites_all') }}
),

cleaned as (
  select
    cust_acct_site_id,
    cust_account_id,
    party_site_id,
    last_update_date::timestamp_ntz            as last_updated_at,
    last_updated_by,
    creation_date::timestamp_ntz               as created_at,
    created_by,
    last_update_login,
    orig_system_reference,
    status,
    org_id,
    bill_to_flag,
    market_flag,
    ship_to_flag,
    customer_category_code,
    key_account_flag,
    rnum::number                                as rnum
  from source
)

select * from cleaned
