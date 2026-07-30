/*
==================================================================================================
DDL Script: Create Silver Tables
==================================================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables if they already exist.
    Run this script to re-define the DDL structure of 'silver' Tables.
===================================================================================================
*/

-- 1. crm_customers
IF OBJECT_ID ('silver.crm_customers', 'U') IS NOT NULL
	DROP TABLE silver.crm_customers;

CREATE TABLE silver.crm_customers (
	customer_id NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	gender NVARCHAR(50),
	birth_date DATE,
	join_date DATE,
	preferred_store_id NVARCHAR(50),
	is_loyalty_member NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 2. crm_loyalty_points_transactions
IF OBJECT_ID ('silver.crm_loyalty_points_transactions', 'U') IS NOT NULL
	DROP TABLE silver.crm_loyalty_points_transactions;

CREATE TABLE silver.crm_loyalty_points_transactions (
	loyalty_txn_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	store_id NVARCHAR(50),
	Ldate DATE, 
	txn_type NVARCHAR(50),
	points INT,
	reward_id NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 3. crm_loyalty_rewards_catalog
IF OBJECT_ID ('silver.crm_loyalty_rewards_catalog', 'U') IS NOT NULL
	DROP TABLE silver.crm_loyalty_rewards_catalog;

CREATE TABLE silver.crm_loyalty_rewards_catalog (
	reward_id NVARCHAR(50),
	reward_name NVARCHAR(50),
	points_cost INT,
	reward_category NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 4. erp_regions
IF OBJECT_ID ('silver.erp_regions', 'U') IS NOT NULL
	DROP TABLE silver.erp_regions;

CREATE TABLE silver.erp_regions(
	region_id NVARCHAR(50),
	region_name NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 5. erp_staff
IF OBJECT_ID ('silver.erp_staff', 'U') IS NOT NULL
	DROP TABLE silver.erp_staff;

CREATE TABLE silver.erp_staff (
	staff_id NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	PHrole NVARCHAR(50),
	store_id NVARCHAR(50),
	region_id NVARCHAR(50),
	hire_date DATE,
	monthly_salary_egp INT,
	is_full_time NVARCHAR(50),
	years_experience INT,
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 6. erp_stores
IF OBJECT_ID ('silver.erp_stores', 'U') IS NOT NULL
	DROP TABLE silver.erp_stores;

CREATE TABLE silver.erp_stores (
	store_id NVARCHAR(50),
	store_name NVARCHAR(50),
	region_id NVARCHAR(50),
	city NVARCHAR(50),
	warehouse_id NVARCHAR(50),
	tier NVARCHAR(50),
	sq_footage INT,
	open_date DATE,
	is_24_7 NVARCHAR(50),
	n_pharmacists INT,
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 7. erp_warehouses
IF OBJECT_ID ('silver.erp_warehouses', 'U') IS NOT NULL
	DROP TABLE silver.erp_warehouses;

CREATE TABLE silver.erp_warehouses (
	warehouse_id NVARCHAR(50),
	warehouse_name NVARCHAR(50),
	region_id NVARCHAR(50),
	city NVARCHAR(50),
	capacity_units INT,
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 8. erp_inventory_snapshot
IF OBJECT_ID ('silver.erp_inventory_snapshot', 'U') IS NOT NULL
	DROP TABLE silver.erp_inventory_snapshot;

CREATE TABLE silver.erp_inventory_snapshot (
	store_id NVARCHAR(50),
	warehouse_id NVARCHAR(50),
	product_id NVARCHAR(50),
	current_stock INT,
	reorder_level INT,
	needs_reorder NVARCHAR(50),
	last_restock_date DATE,
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 9. crm_doctors
IF OBJECT_ID ('silver.crm_doctors', 'U') IS NOT NULL
	DROP TABLE silver.crm_doctors;

CREATE TABLE silver.crm_doctors (
	doctor_license_no NVARCHAR(50),
	doctor_name NVARCHAR(50),
	specialty NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 10. crm_insurance_claims
IF OBJECT_ID ('silver.crm_insurance_claims', 'U') IS NOT NULL
	DROP TABLE silver.crm_insurance_claims;

CREATE TABLE silver.crm_insurance_claims (
	claim_id NVARCHAR(50),
	prescription_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	insurance_provider NVARCHAR(50),
	claim_amount_egp FLOAT(53),
	approved_amount_egp FLOAT(53),
	RXstatus NVARCHAR(50),
	claim_date DATE,
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 11. crm_prescriptions
IF OBJECT_ID ('silver.crm_prescriptions', 'U') IS NOT NULL
	DROP TABLE silver.crm_prescriptions;

CREATE TABLE silver.crm_prescriptions (
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
	insurance_covered NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 12. erp_product_batches
IF OBJECT_ID ('silver.erp_product_batches', 'U') IS NOT NULL
	DROP TABLE silver.erp_product_batches;

CREATE TABLE silver.erp_product_batches (
	batch_id NVARCHAR(50),
	product_id NVARCHAR(50),
	store_id NVARCHAR(50),
	warehouse_id NVARCHAR(50),
	manufacture_date DATE,
	Pexpiry_date DATE,
	quantity_received INT,
	quantity_remaining INT,
	is_expired NVARCHAR(50),
	is_near_expiry_90d NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 13. erp_products
IF OBJECT_ID ('silver.erp_products', 'U') IS NOT NULL
	DROP TABLE silver.erp_products;

CREATE TABLE silver.erp_products (
	product_id NVARCHAR(50),
	product_name NVARCHAR(50),
	category NVARCHAR(50),
	manufacturer NVARCHAR(50),
	requires_prescription NVARCHAR(50),
	unit_price_egp FLOAT(53),
	unit_cost_egp FLOAT(53),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 14. erp_purchase_orders
IF OBJECT_ID ('silver.erp_purchase_orders', 'U') IS NOT NULL
	DROP TABLE silver.erp_purchase_orders;

CREATE TABLE silver.erp_purchase_orders (
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
	PO_status NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 15. erp_suppliers
IF OBJECT_ID ('silver.erp_suppliers', 'U') IS NOT NULL
	DROP TABLE silver.erp_suppliers;

CREATE TABLE silver.erp_suppliers (
	supplier_id NVARCHAR(50),
	supplier_name NVARCHAR(50),
	category_specialty NVARCHAR(50),
	country NVARCHAR(50),
	avg_lead_time_days INT,
	reliability_score FLOAT(53),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 16. erp_delivery_orders
IF OBJECT_ID ('silver.erp_delivery_orders', 'U') IS NOT NULL
	DROP TABLE silver.erp_delivery_orders;

CREATE TABLE silver.erp_delivery_orders (
	delivery_id NVARCHAR(50),
	store_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	order_date DATE,
	order_amount_egp FLOAT(53),
	delivery_fee_egp INT,
	delivery_time_hours INT,
	DV_status NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 17. erp_product_sales_by_store
IF OBJECT_ID ('silver.erp_product_sales_by_store', 'U') IS NOT NULL
	DROP TABLE silver.erp_product_sales_by_store;

CREATE TABLE silver.erp_product_sales_by_store (
	store_id NVARCHAR(50),
	product_id NVARCHAR(50),
	category NVARCHAR(50),
	lifetime_qty_sold INT,
	lifetime_revenue_egp FLOAT(53),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 18. erp_product_sales_monthly_chain
IF OBJECT_ID ('silver.erp_product_sales_monthly_chain', 'U') IS NOT NULL
	DROP TABLE silver.erp_product_sales_monthly_chain;

CREATE TABLE silver.erp_product_sales_monthly_chain (
	product_id NVARCHAR(50),
	product_name NVARCHAR(50),
	category NVARCHAR(50),
	year_month NVARCHAR(50),
	qty_sold INT,
	revenue_egp FLOAT(53),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 19. erp_promotions_campaigns
IF OBJECT_ID ('silver.erp_promotions_campaigns', 'U') IS NOT NULL
	DROP TABLE silver.erp_promotions_campaigns;

CREATE TABLE silver.erp_promotions_campaigns (
	campaign_id NVARCHAR(50),
	campaign_name NVARCHAR(50),
	CP_start_date DATE,
	end_date DATE,
	discount_pct INT,
	category_target NVARCHAR(50),
	region_target NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 20. erp_returns_refunds
IF OBJECT_ID ('silver.erp_returns_refunds', 'U') IS NOT NULL
	DROP TABLE silver.erp_returns_refunds;

CREATE TABLE silver.erp_returns_refunds (
	return_id NVARCHAR(50),
	original_transaction_id NVARCHAR(50),
	store_id NVARCHAR(50),
	product_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	return_date DATE,
	quantity_returned INT,
	reason NVARCHAR(50),
	refund_amount_egp FLOAT(53),
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 21. erp_sales_daily_store
IF OBJECT_ID ('silver.erp_sales_daily_store', 'U') IS NOT NULL
	DROP TABLE silver.erp_sales_daily_store;

CREATE TABLE silver.erp_sales_daily_store (
	store_id NVARCHAR(50),
	S_date DATE,
	total_transactions INT,
	total_items_sold INT,
	total_revenue_egp FLOAT(53),
	total_discount_egp FLOAT(53),
	loyalty_points_issued INT,
	dwh_create_date DATETIME DEFAULT GETDATE()
);

-- 22. erp_sales_transactions_sample
IF OBJECT_ID ('silver.erp_sales_transactions_sample', 'U') IS NOT NULL
	DROP TABLE silver.erp_sales_transactions_sample;

CREATE TABLE silver.erp_sales_transactions_sample (
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
	payment_method NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);
