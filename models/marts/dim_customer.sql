{{ config(materialized='table') }}

with accounts as (
  select
    cust_account_id,
    party_id,
    account_number,
    status as account_status
  from {{ ref('stg_hz_cust_accounts') }}
),

parties as (
  select
    party_id,
    party_name,
    party_type,
    email_address,
    country as party_country,
    city  as party_city,
    state  as party_state
  from {{ ref('stg_hz_parties') }}
),

party_sites as (
  select
    party_site_id,
    party_id,
    location_id
  from {{ ref('stg_hz_party_sites') }}
),

site_uses as (
  select
    party_site_use_id,
    party_site_id,
    site_use_type,
    primary_flag
  from {{ ref('stg_hz_party_site_uses') }}
  where site_use_type = 'BILL_TO'
    and primary_flag = 'Y'
),

locations as (
  select
    location_id,
    address1,
    address2,
    city,
    state,
    postal_code,
    country
  from {{ ref('stg_hz_locations') }}
)

select distinct
  a.cust_account_id     as customer_id,
  a.account_number,
  a.account_status,
  p.party_name          as customer_name,
--   p.party_type          as party_type,
--   p.email_address,
  -- billing address details
--   loc.address1         as billing_address,
--   loc.city             as billing_city,
--   loc.state            as billing_state,
--   loc.postal_code      as billing_postal_code,
--   loc.country          as billing_country

from accounts a
left join parties p
  on a.party_id = p.party_id
-- left join party_sites ps
--   on ps.party_id = a.party_id
-- left join site_uses su
--   on su.party_site_id = ps.party_site_id
-- left join locations loc
--   on loc.location_id = ps.location_id



