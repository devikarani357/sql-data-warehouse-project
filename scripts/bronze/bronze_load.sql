/*
=============================================================
Bronze Layer - Data Loading
=============================================================
Purpose:
    Load raw CRM and ERP source data into Bronze tables.

The Bronze layer preserves source data with minimal
transformation.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- CRM: Customer Information
-- =============================================================

TRUNCATE TABLE bronze.crm_customer_info;

BULK INSERT bronze.crm_customer_info
FROM 'C:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO


-- =============================================================
-- CRM: Product Information
-- =============================================================

TRUNCATE TABLE bronze.crm_product_info;

BULK INSERT bronze.crm_product_info
FROM 'C:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO


-- =============================================================
-- CRM: Sales Details
-- =============================================================

TRUNCATE TABLE bronze.crm_sales_details;

BULK INSERT bronze.crm_sales_details
FROM 'C:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO


-- =============================================================
-- ERP: Customer Information
-- =============================================================

TRUNCATE TABLE bronze.erp_customer_info;

BULK INSERT bronze.erp_customer_info
FROM 'C:\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO


-- =============================================================
-- ERP: Location Information
-- =============================================================

TRUNCATE TABLE bronze.erp_location_info;

BULK INSERT bronze.erp_location_info
FROM 'C:\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO


-- =============================================================
-- ERP: Product Category
-- =============================================================

TRUNCATE TABLE bronze.erp_product_category;

BULK INSERT bronze.erp_product_category
FROM 'C:\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO
