/*
===================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===================================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  -Truncates the bronze tables before loading data.
  -uses the 'BULK INSERT' command to load data from csv files to brobze tables.

Parameters:
  None.
 This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
===================================================================================================

*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '=============================================';
        PRINT 'Loading Bronze Layer';
        PRINT '=============================================';

        PRINT '---------------------------------------------';
        PRINT 'Loading customers_and_loyalty Tables';
        PRINT '---------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_customers';
        TRUNCATE TABLE bronze.crm_customers;

        PRINT '>> Inserting Data Into : bronze.crm_customers';
        BULK INSERT bronze.crm_customers
        FROM 'C:\pharmacy_chain_data\customers.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_loyalty_points_transactions';
        TRUNCATE TABLE bronze.crm_loyalty_points_transactions;

        PRINT '>> Inserting Data Into : bronze.crm_loyalty_points_transactions';
        BULK INSERT bronze.crm_loyalty_points_transactions
        FROM 'C:\pharmacy_chain_data\loyalty_points_transactions.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_loyalty_rewards_catalog';
        TRUNCATE TABLE bronze.crm_loyalty_rewards_catalog;
    
        PRINT '>> Inserting Data Into : bronze.crm_loyalty_rewards_catalog';
        BULK INSERT bronze.crm_loyalty_rewards_catalog
        FROM 'C:\pharmacy_chain_data\loyalty_rewards_catalog.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'


        PRINT '---------------------------------------------';
        PRINT 'Loading geography_and_stores Tables';
        PRINT '---------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_regions';
        TRUNCATE TABLE bronze.erp_regions;

        PRINT '>> Inserting Data Into : bronze.erp_regions';
        BULK INSERT bronze.erp_regions
        FROM 'C:\pharmacy_chain_data\regions.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_staff';
        TRUNCATE TABLE bronze.erp_staff;
    
        PRINT '>> Inserting Data Into : bronze.erp_staff';
        BULK INSERT bronze.erp_staff
        FROM 'C:\pharmacy_chain_data\staff.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_stores';
        TRUNCATE TABLE bronze.erp_stores;

        PRINT '>> Inserting Data Into : bronze.erp_stores';
        BULK INSERT bronze.erp_stores
        FROM 'C:\pharmacy_chain_data\stores.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_warehouses';
        TRUNCATE TABLE bronze.erp_warehouses;

        PRINT '>> Inserting Data Into : bronze.erp_warehouses';
        BULK INSERT bronze.erp_warehouses
        FROM 'C:\pharmacy_chain_data\warehouses.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'


        PRINT '---------------------------------------------';
        PRINT 'Loading inventory Tables';
        PRINT '---------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_inventory_snapshot';
        TRUNCATE TABLE bronze.erp_inventory_snapshot;

        PRINT '>> Inserting Data Into : bronze.erp_inventory_snapshot';
        BULK INSERT bronze.erp_inventory_snapshot
        FROM 'C:\pharmacy_chain_data\inventory_snapshot.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'


        PRINT '---------------------------------------------';
        PRINT 'Loading medical_and_insurance Tables';
        PRINT '---------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_doctors';
        TRUNCATE TABLE bronze.crm_doctors;

        PRINT '>> Inserting Data Into : bronze.crm_doctors';
        BULK INSERT bronze.crm_doctors
        FROM 'C:\pharmacy_chain_data\doctors.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_insurance_claims';
        TRUNCATE TABLE bronze.crm_insurance_claims;

        PRINT '>> Inserting Data Into : bronze.crm_insurance_claims';
        BULK INSERT bronze.crm_insurance_claims
        FROM 'C:\pharmacy_chain_data\insurance_claims.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_prescriptions';
        TRUNCATE TABLE bronze.crm_prescriptions;

        PRINT '>> Inserting Data Into : bronze.crm_prescriptions';
        BULK INSERT bronze.crm_prescriptions
        FROM 'C:\pharmacy_chain_data\prescriptions.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'


        PRINT '---------------------------------------------';
        PRINT 'Loading products_and_supply_chain Tables';
        PRINT '---------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_product_batches';
        TRUNCATE TABLE bronze.erp_product_batches;

        PRINT '>> Inserting Data Into : bronze.erp_product_batches';
        BULK INSERT bronze.erp_product_batches
        FROM 'C:\pharmacy_chain_data\product_batches.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_products';
        TRUNCATE TABLE bronze.erp_products;

        PRINT '>> Inserting Data Into : bronze.erp_products';
        BULK INSERT bronze.erp_products
        FROM 'C:\pharmacy_chain_data\products.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_purchase_orders';
        TRUNCATE TABLE bronze.erp_purchase_orders;

        PRINT '>> Inserting Data Into : bronze.erp_purchase_orders';
        BULK INSERT bronze.erp_purchase_orders
        FROM 'C:\pharmacy_chain_data\purchase_orders.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_suppliers';
        TRUNCATE TABLE bronze.erp_suppliers;

        PRINT '>> Inserting Data Into : bronze.erp_suppliers';
        BULK INSERT bronze.erp_suppliers
        FROM 'C:\pharmacy_chain_data\suppliers.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

    
        PRINT '---------------------------------------------';
        PRINT 'Loading sales Tables';
        PRINT '---------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_delivery_orders';
        TRUNCATE TABLE bronze.erp_delivery_orders;

        PRINT '>> Inserting Data Into : bronze.erp_delivery_orders';
        BULK INSERT bronze.erp_delivery_orders
        FROM 'C:\pharmacy_chain_data\delivery_orders.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_product_sales_by_store';
        TRUNCATE TABLE bronze.erp_product_sales_by_store;

        PRINT '>> Inserting Data Into : bronze.erp_product_sales_by_store';
        BULK INSERT bronze.erp_product_sales_by_store
        FROM 'C:\pharmacy_chain_data\product_sales_by_store.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_product_sales_monthly_chain';
        TRUNCATE TABLE bronze.erp_product_sales_monthly_chain;

        PRINT '>> Inserting Data Into : bronze.erp_product_sales_monthly_chain';
        BULK INSERT bronze.erp_product_sales_monthly_chain
        FROM 'C:\pharmacy_chain_data\product_sales_monthly_chain.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_promotions_campaigns';
        TRUNCATE TABLE bronze.erp_promotions_campaigns;

        PRINT '>> Inserting Data Into : bronze.erp_promotions_campaigns';
        BULK INSERT bronze.erp_promotions_campaigns
        FROM 'C:\pharmacy_chain_data\promotions_campaigns.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_returns_refunds';
        TRUNCATE TABLE bronze.erp_returns_refunds;

        PRINT '>> Inserting Data Into : bronze.erp_returns_refunds';
        BULK INSERT bronze.erp_returns_refunds
        FROM 'C:\pharmacy_chain_data\returns_refunds.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_sales_daily_store';
        TRUNCATE TABLE bronze.erp_sales_daily_store;

        PRINT '>> Inserting Data Into : bronze.erp_sales_daily_store';
        BULK INSERT bronze.erp_sales_daily_store
        FROM 'C:\pharmacy_chain_data\sales_daily_store.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_sales_transactions_sample';
        TRUNCATE TABLE bronze.erp_sales_transactions_sample;

        PRINT '>> Inserting Data Into : bronze.erp_sales_transactions_sample';
        BULK INSERT bronze.erp_sales_transactions_sample
        FROM 'C:\pharmacy_chain_data\sales_transactions_sample.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            CODEPAGE = '65001',
            FIELDQUOTE = '"',
            ROWTERMINATOR = '0x0A'
        );

        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '>> --------------------------------------------------'

        SET @batch_end_time = GETDATE();
        PRINT '===========================================';
        PRINT 'lOADING Bronze layer is completed ';
        PRINT '>> Total Load Duration : ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' Seconds';
        PRINT '===========================================';
    END TRY
    BEGIN CATCH
        PRINT '===========================================';
        PRINT 'ERROR Occured during loading Bronze layer';
        PRINT 'Error message' + ERROR_MESSAGE();
        PRINT 'Error number' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error state' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '===========================================';
    END CATCH
END
