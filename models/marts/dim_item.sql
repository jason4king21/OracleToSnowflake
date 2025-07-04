{{ config(materialized='table') }}

select distinct
  ol.inventory_item_id as item_id,
  ol.ordered_item as item_sku
from {{ ref('stg_oe_order_lines_all') }} ol
union
select distinct
  d.inventory_item_id,
  null
from {{ ref('stg_wsh_delivery_details') }} d
