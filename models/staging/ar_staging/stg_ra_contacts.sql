with source as (
  select * from {{ source('ar_raw', 'raw_ra_contacts') }}
),

cleaned as (
  select
    contact_id,
    last_update_date::timestamp_ntz      as last_updated_at,
    last_updated_by,
    creation_date::timestamp_ntz         as created_at,
    created_by,
    customer_id,
    status,
    orig_system_reference,
    last_name,
    last_update_login::number            as last_update_login,
    title,
    first_name,
    job_title,
    mail_stop,
    address_id::number                   as address_id,
    contact_key,
    contact_personal_information,
    decision_maker_flag,
    job_title_code,
    managed_by::number                   as managed_by,
    native_language,
    reference_use_flag,
    contact_number,
    other_language_1,
    other_language_2,
    rank,
    primary_role,
    do_not_mail_flag,
    suffix,
    email_address,
    mailing_address_id::number           as mailing_address_id,
    match_group_id,
    sex_code,
    salutation,
    department_code,
    department,
    last_name_alt,
    first_name_alt,
    do_not_email_flag,
    rnum::number                         as rnum
  from source
)

select * from cleaned
