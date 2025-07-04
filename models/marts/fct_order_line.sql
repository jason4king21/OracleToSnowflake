-- models/marts/fct_order_line.sql

with ord_lines as (
    SELECT
    *  
    FROM {{ ref('stg_oe_order_lines_all') }}
    where header_id in (select header_id from {{ ref('fct_order') }})
)


SELECT
  line.line_id,
  line.header_id,
  h.order_number,
  line.ordered_item,
  line.ordered_quantity,
  line.unit_selling_price,
  line.order_firmed_date      AS ordered_at,
  line.scheduled_ship_at      AS scheduled_ship,
  line.fulfillment_date       AS planned_fulfillment,
  line.actual_fulfillment_at  AS shipped_at,
  line.fulfilled_flag,
  DATEDIFF('day', line.scheduled_ship_at, line.actual_fulfillment_at)
    AS fulfillment_lag_days,
  LAG(fulfillment_lag_days) OVER (PARTITION BY header_id ORDER BY ordered_at) 
    AS prev_fulfillment_lag

FROM ord_lines AS line
LEFT JOIN {{ ref('stg_oe_order_headers_all') }} AS h USING (header_id)



