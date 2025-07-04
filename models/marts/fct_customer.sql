with trx_head as (
  select
    tr.customer_trx_id,
    tr.sold_to_customer_id as customer_id,
    tr.trx_date
  from {{ ref('stg_ra_customer_trx_all') }} tr
),

line_item as (
  select
    customer_trx_id,
    sum(unit_selling_price * quantity_invoiced) as invoice_amount
  from {{ ref('stg_ra_customer_trx_lines_all') }}
  where line_type = 'LINE'
  group by customer_trx_id
),

payment_sched AS (
  SELECT
    customer_trx_id,
    SUM(amount_due_original) AS total_amount_due,
    MAX(actual_date_closed) AS last_trx_date
  FROM {{ ref('stg_ar_payment_schedules_all') }}
  GROUP BY customer_trx_id
),

orders as (
  select
    header_id,
    sold_to_org_id as customer_id,
    ordered_at,
    order_number
  from {{ ref('stg_oe_order_headers_all') }}
),

cust as (
  select
    cust_account_id as customer_id,
    account_number,
    status
  from {{ ref('stg_hz_cust_accounts') }}
),

custname as (
  select
    party_id as customer_id,
    party_name as customer_name    
  from {{ ref('stg_hz_parties') }}
)


select
  c.customer_id,
  c.account_number,
  custname.customer_name,
  c.status,
  count(distinct trx_head.customer_trx_id) as num_trx,
  sum(payment_sched.total_amount_due)      as total_amount_due,
  max(payment_sched.last_trx_date)         as last_trx_date,
  count(distinct orders.header_id)         as num_orders,
  max(orders.ordered_at)                   as last_order_date
from cust c
left join trx_head
  on trx_head.customer_id = c.customer_id
left join line_item
  on line_item.customer_trx_id = trx_head.customer_trx_id
left join payment_sched
  on payment_sched.customer_trx_id = trx_head.customer_trx_id
left join orders
  on orders.customer_id = c.customer_id
left join custname  
  on custname.customer_id = c.customer_id
group by 1,2,3,4
