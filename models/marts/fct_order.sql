with headers as (
  select
    header_id,
    order_number,
    ordered_at,
    sold_to_org_id as customer_id,
    price_list_id
  from {{ ref('stg_oe_order_headers_all') }}
),
lines as (
  select header_id, line_id,
    unit_selling_price,
    unit_selling_price * ordered_quantity as extended_amount
  from {{ ref('stg_oe_order_lines_all') }}
),
holds as (
  select header_id,
    sum(case when lower(released_flag) = 'n' then 1 else 0 end) as open_holds
  from {{ ref('stg_oe_order_holds_all') }}
  group by header_id
),
adjusts as (
  select header_id,
    sum(adjusted_amount) as total_adjustments
  from {{ ref('stg_oe_price_adjustments') }}
  group by header_id
)

select
  h.header_id,
  h.order_number,
  h.ordered_at,
  h.customer_id,
  h.price_list_id,

  count(distinct lines.line_id) as num_lines,
  sum(lines.extended_amount) as gross_amount,

  coalesce(adjusts.total_adjustments, 0) as total_adjustments,
  sum(lines.extended_amount) + coalesce(adjusts.total_adjustments,0) as net_amount,

  coalesce(holds.open_holds, 0) as open_holds

from headers h
left join lines on lines.header_id = h.header_id
left join adjusts on adjusts.header_id = h.header_id
left join holds on holds.header_id = h.header_id
where h.customer_id in (select customer_id from {{ ref('dim_customer') }})
group by 1,2,3,4,5, adjusts.total_adjustments, holds.open_holds
