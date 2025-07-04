

select
  dd.delivery_detail_id,
  dd.source_header_id as header_id,
  dd.inventory_item_id as item_id,
  dd.requested_quantity,
  dd.shipped_quantity,
  dd.date_requested::date as requested_date,
  dd.date_scheduled::date as scheduled_date
from {{ ref('stg_wsh_delivery_details') }} dd
