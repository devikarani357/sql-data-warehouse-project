
/*
=============================================================
Bronze Layer - Data Loading
=============================================================
Purpose:
    Load raw source data into Bronze tables.

The Bronze layer should preserve the source data with
minimal transformation.
=============================================================
*/

USE DataWarehouse;
GO

-- Clear existing Bronze data before loading fresh data
TRUNCATE TABLE bronze.crm_customer_info;
TRUNCATE TABLE bronze.crm_product_info;
TRUNCATE TABLE bronze.crm_sales_details;
GO

-- Source data loading will be added here.
-- CSV files will be loaded into the Bronze tables.
