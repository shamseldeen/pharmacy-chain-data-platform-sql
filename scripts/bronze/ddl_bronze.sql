/*
==================================================================================================
DDL Script: Create Bronze Tables
==================================================================================================
Script Purpose:
    This script creats tables in the 'bronze' schema, dropping existing tables if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables.
===================================================================================================
*/
IF OBJECT_ID ('bronze.crm_customers', 'U') IS NOT NULL
	DROP TABLE bronze.crm_customers;

CREATE TABLE bronze.crm_customers (
	customer_id NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	gender NVARCHAR(50),
	birth_date DATE,
	join_date DATE,
	preferred_store_id NVARCHAR(50),
	is_loyalty_member NVARCHAR(50)
);


IF OBJECT_ID ('bronze.crm_loyalty_points_transactions', 'U') IS NOT NULL
	DROP TABLE bronze.crm_loyalty_points_transactions;

CREATE TABLE bronze.crm_loyalty_points_transactions (
	loyalty_txn_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	store_id NVARCHAR(50),
	Ldate DATE, 
	txn_type NVARCHAR(50),
	points INT,
	reward_id NVARCHAR(50)
);

IF OBJECT_ID ('bronze.crm_loyalty_rewards_catalog', 'U') IS NOT NULL
	DROP TABLE bronze.crm_loyalty_rewards_catalog;

CREATE TABLE bronze.crm_loyalty_rewards_catalog (
	reward_id NVARCHAR(50),
	reward_name NVARCHAR(50),
	points_cost INT,
	reward_category NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_regions', 'U') IS NOT NULL
	DROP TABLE bronze.erp_regions;

CREATE TABLE bronze.erp_regions(
	region_id NVARCHAR(50),
	region_name NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_staff', 'U') IS NOT NULL
	DROP TABLE bronze.erp_staff;

CREATE TABLE bronze.erp_staff (
	staff_id NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	PHrole NVARCHAR(50),
	store_id NVARCHAR(50),
	region_id NVARCHAR(50),
	hire_date DATE,
	monthly_salary_egp INT,
	is_full_time NVARCHAR(50),
	years_experience INT
);

IF OBJECT_ID ('bronze.erp_stores', 'U') IS NOT NULL
	DROP TABLE bronze.erp_stores;

CREATE TABLE bronze.erp_stores (
	store_id NVARCHAR(50),
	store_name NVARCHAR(50),
	region_id NVARCHAR(50),
	city NVARCHAR(50),
	warehouse_id NVARCHAR(50),
	tier NVARCHAR(50),
	sq_footage INT,
	open_date DATE,
	is_24_7 NVARCHAR(50),
	n_pharmacists INT
);

IF OBJECT_ID ('bronze.erp_warehouses', 'U') IS NOT NULL
	DROP TABLE bronze.erp_warehouses;

CREATE TABLE bronze.erp_warehouses (
	warehouse_id NVARCHAR(50),
	warehouse_name NVARCHAR(50),
	region_id NVARCHAR(50),
	city NVARCHAR(50),
	capacity_units INT
);

IF OBJECT_ID ('bronze.erp_inventory_snapshot', 'U') IS NOT NULL
	DROP TABLE bronze.erp_inventory_snapshot;

CREATE TABLE bronze.erp_inventory_snapshot (
	store_id NVARCHAR(50),
	warehouse_id NVARCHAR(50),
	product_id NVARCHAR(50),
	current_stock INT,
	reorder_level INT,
	needs_reorder NVARCHAR(50),
	last_restock_date DATE
);

IF OBJECT_ID ('bronze.crm_doctors', 'U') IS NOT NULL
	DROP TABLE bronze.crm_doctors;

CREATE TABLE bronze.crm_doctors (
	doctor_license_no NVARCHAR(50),
	doctor_name NVARCHAR(50),
	specialty NVARCHAR(50)
);

IF OBJECT_ID ('bronze.crm_insurance_claims', 'U') IS NOT NULL
	DROP TABLE bronze.crm_insurance_claims;

CREATE TABLE bronze.crm_insurance_claims (
	claim_id NVARCHAR(50),
	prescription_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	insurance_provider NVARCHAR(50),
	claim_amount_egp FLOAT(53),
	approved_amount_egp FLOAT(53),
	RXstatus NVARCHAR(50),
	claim_date DATE
);

IF OBJECT_ID ('bronze.crm_prescriptions', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prescriptions;

CREATE TABLE bronze.crm_prescriptions (
	prescription_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	store_id NVARCHAR(50),
	product_id NVARCHAR(50),
	doctor_license_no NVARCHAR(50),
	doctor_name NVARCHAR(50),
	specialty NVARCHAR(50),
	date_issued DATE,
	date_filled DATE,
	refills_allowed INT,
	refills_used INT,
	insurance_covered NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_product_batches', 'U') IS NOT NULL
	DROP TABLE bronze.erp_product_batches;

CREATE TABLE bronze.erp_product_batches (
	batch_id NVARCHAR(50),
	product_id NVARCHAR(50),
	store_id NVARCHAR(50),
	warehouse_id NVARCHAR(50),
	manufacture_date DATE,
	Pexpiry_date DATE,
	quantity_received INT,
	quantity_remaining INT,
	is_expired NVARCHAR(50),
	is_near_expiry_90d NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_products', 'U') IS NOT NULL
	DROP TABLE bronze.erp_products;

CREATE TABLE bronze.erp_products (
	product_id NVARCHAR(50),
	product_name NVARCHAR(50),
	category NVARCHAR(50),
	manufacturer NVARCHAR(50),
	requires_prescription NVARCHAR(50),
	unit_price_egp FLOAT(53),
	unit_cost_egp FLOAT(53)
);

IF OBJECT_ID ('bronze.erp_purchase_orders', 'U') IS NOT NULL
	DROP TABLE bronze.erp_purchase_orders;

CREATE TABLE bronze.erp_purchase_orders (
	po_id NVARCHAR(50),
	supplier_id NVARCHAR(50),
	warehouse_id NVARCHAR(50),
	product_id NVARCHAR(50),
	order_date DATE,
	expected_delivery_date DATE,
	actual_delivery_date DATE,
	quantity_ordered INT,
	unit_cost_egp FLOAT(53),
	total_cost_egp FLOAT(53),
	PO_status NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_suppliers', 'U') IS NOT NULL
	DROP TABLE bronze.erp_suppliers;

CREATE TABLE bronze.erp_suppliers (
	supplier_id NVARCHAR(50),
	supplier_name NVARCHAR(50),
	category_specialty NVARCHAR(50),
	country NVARCHAR(50),
	avg_lead_time_days INT,
	reliability_score FLOAT(53)
);

IF OBJECT_ID ('bronze.erp_delivery_orders', 'U') IS NOT NULL
	DROP TABLE bronze.erp_delivery_orders;

CREATE TABLE bronze.erp_delivery_orders (
	delivery_id NVARCHAR(50),
	store_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	order_date DATE,
	order_amount_egp FLOAT(53),
	delivery_fee_egp INT,
	delivery_time_hours INT,
	DV_status NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_product_sales_by_store', 'U') IS NOT NULL
	DROP TABLE bronze.erp_product_sales_by_store;

CREATE TABLE bronze.erp_product_sales_by_store (
	store_id NVARCHAR(50),
	product_id NVARCHAR(50),
	category NVARCHAR(50),
	lifetime_qty_sold INT,
	lifetime_revenue_egp FLOAT(53)
);

IF OBJECT_ID ('bronze.erp_product_sales_monthly_chain', 'U') IS NOT NULL
	DROP TABLE bronze.erp_product_sales_monthly_chain;

CREATE TABLE bronze.erp_product_sales_monthly_chain (
	product_id NVARCHAR(50),
	product_name NVARCHAR(50),
	category NVARCHAR(50),
	year_month NVARCHAR(50),
	qty_sold INT,
	revenue_egp FLOAT(53)
);

IF OBJECT_ID ('bronze.erp_promotions_campaigns', 'U') IS NOT NULL
	DROP TABLE bronze.erp_promotions_campaigns;

CREATE TABLE bronze.erp_promotions_campaigns (
	campaign_id NVARCHAR(50),
	campaign_name NVARCHAR(50),
	CP_start_date DATE,
	end_date DATE,
	discount_pct INT,
	category_target NVARCHAR(50),
	region_target NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_returns_refunds', 'U') IS NOT NULL
	DROP TABLE bronze.erp_returns_refunds;

CREATE TABLE bronze.erp_returns_refunds (
	return_id NVARCHAR(50),
	original_transaction_id NVARCHAR(50),
	store_id NVARCHAR(50),
	product_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	return_date DATE,
	quantity_returned INT,
	reason NVARCHAR(50),
	refund_amount_egp FLOAT(53)
);

IF OBJECT_ID ('bronze.erp_sales_daily_store', 'U') IS NOT NULL
	DROP TABLE bronze.erp_sales_daily_store;

CREATE TABLE bronze.erp_sales_daily_store (
	store_id NVARCHAR(50),
	S_date DATE,
	total_transactions INT,
	total_items_sold INT,
	total_revenue_egp FLOAT(53),
	total_discount_egp FLOAT(53),
	loyalty_points_issued INT
);

IF OBJECT_ID ('bronze.erp_sales_transactions_sample', 'U') IS NOT NULL
	DROP TABLE bronze.erp_sales_transactions_sample;

CREATE TABLE bronze.erp_sales_transactions_sample (
	transaction_id NVARCHAR(50),
	store_id NVARCHAR(50),
	S_date DATE,
	customer_id NVARCHAR(50),
	product_id NVARCHAR(50),
	quantity INT,
	unit_price_egp FLOAT(53),
	discount_pct FLOAT(53),
	line_total_egp FLOAT(53),
	requires_prescription NVARCHAR(50),
	payment_method NVARCHAR(50)
);
