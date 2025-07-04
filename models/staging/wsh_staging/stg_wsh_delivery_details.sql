with source as (
  select * from {{ source('wsh_raw', 'raw_wsh_delivery_details') }}
),

cleaned as (
  select
    delivery_detail_id,
    source_code,
    source_header_id,
    source_line_id,
    source_header_type_id,
    source_header_type_name,
    cust_po_number,
    customer_id,
    sold_to_contact_id::number           as sold_to_contact_id,
    inventory_item_id,
    item_description,
    ship_set_id::number                   as ship_set_id,
    arrival_set_id,
    top_model_line_id,
    ato_line_id,
    hold_code,
    ship_model_complete_flag,
    hazard_class_id,
    country_of_origin,
    classification,
    ship_from_location_id,
    organization_id,
    ship_to_location_id,
    ship_to_contact_id::number           as ship_to_contact_id,
    deliver_to_location_id,
    deliver_to_contact_id,
    intmed_ship_to_location_id,
    intmed_ship_to_contact_id,
    ship_tolerance_above,
    ship_tolerance_below,
    src_requested_quantity,
    src_requested_quantity_uom,
    cancelled_quantity,
    requested_quantity::number           as requested_quantity,
    requested_quantity_uom,
    shipped_quantity::number             as shipped_quantity,
    delivered_quantity,
    quality_control_quantity,
    cycle_count_quantity,
    move_order_line_id,
    subinventory,
    revision,
    lot_number,
    released_status,
    customer_requested_lot_flag,
    serial_number,
    locator_id::number                    as locator_id,
    date_requested::timestamp_ntz         as date_requested,
    date_scheduled::timestamp_ntz         as date_scheduled,
    master_container_item_id,
    detail_container_item_id,
    load_seq_number,
    ship_method_code,
    carrier_id,
    freight_terms_code,
    shipment_priority_code,
    fob_code,
    customer_item_id,
    dep_plan_required_flag,
    customer_prod_seq,
    customer_dock_code,
    net_weight::number                    as net_weight,
    weight_uom_code,
    volume::number                        as volume,
    volume_uom_code,
    project_id,
    task_id,
    org_id,
    oe_interfaced_flag,
    mvt_stat_status,
    tracking_number,
    transaction_temp_id::number           as transaction_temp_id,
    creation_date::timestamp_ntz          as created_at,
    created_by,
    last_update_date::timestamp_ntz       as last_updated_at,
    last_updated_by,
    last_update_login,
    movement_id,
    split_from_delivery_detail_id::number as split_from_delivery_detail_id,
    inv_interfaced_flag,
    seal_code,
    minimum_fill_percent,
    maximum_volume,
    maximum_load_weight,
    master_serial_number,
    gross_weight::number                  as gross_weight,
    fill_percent,
    container_name,
    container_type_code,
    container_flag,
    preferred_grade,
    src_requested_quantity2::number       as src_requested_quantity2,
    src_requested_quantity_uom2,
    requested_quantity2::number          as requested_quantity2,
    shipped_quantity2::number            as shipped_quantity2,
    delivered_quantity2,
    cancelled_quantity2,
    quality_control_quantity2,
    cycle_count_quantity2,
    requested_quantity_uom2,
    sublot_number,
    unit_price::number                    as unit_price,
    currency_code,
    unit_number,
    freight_class_cat_id,
    commodity_code_cat_id,
    lpn_content_id,
    lpn_id,
    inspection_flag,
    ship_to_site_use_id,
    deliver_to_site_use_id,
    original_subinventory,
    pickable_flag,
    source_header_number,
    source_line_number,
    to_serial_number,
    picked_quantity::number               as picked_quantity,
    picked_quantity2::number              as picked_quantity2,
    customer_production_line,
    customer_job,
    cust_model_serial_number,
    received_quantity,
    received_quantity2,
    source_line_set_id::number            as source_line_set_id,
    batch_id,
    transaction_id::number                as transaction_id,
    service_level,
    mode_of_transport,
    earliest_pickup_date,
    latest_pickup_date,
    earliest_dropoff_date,
    latest_dropoff_date,
    request_date_type_code,
    tp_delivery_detail_id,
    source_document_type_id,
    vendor_id,
    ship_from_site_id,
    ignore_for_planning,
    line_direction,
    party_id,
    routing_req_id,
    shipping_control,
    source_blanket_reference_id,
    source_blanket_reference_num,
    po_shipment_line_id,
    po_shipment_line_number,
    scheduled_quantity,
    returned_quantity,
    scheduled_quantity2,
    returned_quantity2,
    source_line_type_code,
    rcv_shipment_line_id,
    supplier_item_number,
    filled_volume,
    unit_weight,
    unit_volume,
    wv_frozen_flag,
    po_revision_number,
    release_revision_number,
    replenishment_status,
    original_lot_number,
    original_revision,
    original_locator_id,
    reference_number,
    reference_line_number,
    reference_line_quantity,
    reference_line_quantity_uom,
    client_id,
    shipment_batch_id,
    shipment_line_number,
    reference_line_id,
    consignee_flag,
    equipment_id,
    mcc_code,
    tms_sub_batch_id,
    tms_sub_batch_line_num,
    tms_interface_flag,
    tms_sshipunit_id,
    verification_status,
    reason_id,
    rnum::number                         as rnum
  from source
)

select * from cleaned
