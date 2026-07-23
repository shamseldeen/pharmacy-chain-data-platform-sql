/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehousePharmacyChain' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehousePharmacyChain' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/
USE master;
GO
-- Drop and recreate the 'DataWarehousePharmacyChain' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehousePharmacyChain')
BEGIN
    ALTER DATABASE DataWarehousePharmacyChain SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehousePharmacyChain;
END;
GO
-- Create the 'DataWarehousePharmacyChain' database
CREATE DATABASE DataWarehousePharmacyChain;
GO
USE DataWarehousePharmacyChain;
GO
-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
