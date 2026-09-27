
/*
=============================================================
Silver Layer - Table Definitions
=============================================================
Purpose:
    Create cleaned and standardized tables for the Silver layer.

The Silver layer contains transformed data from the Bronze layer.
Data is cleaned, standardized, and prepared for the Gold layer.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- CRM: Customer Information
-- =============================================================

CREATE TABLE silver.crm_customer_info
(
    cst_id              INT,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(100),
    cst_lastname        VARCHAR(100),
    cst_marital_status  VARCHAR(10),
    cst_gndr            VARCHAR(10),
    cst_create_date     DATE
);
GO


-- =============================================================
-- CRM: Product Information
-- =============================================================

CREATE TABLE silver.crm_product_info
(
    prd_id              INT,
    prd_key             VARCHAR(50),
    prd_nm               VARCHAR(100),
    prd_cost             DECIMAL(10,2),
    prd_line             VARCHAR(50),
    prd_start_dt        DATE,
    prd_end_dt          DATE
);
GO


-- =============================================================
-- CRM: Sales Details
-- =============================================================

CREATE TABLE silver.crm_sales_details
(
    sls_ord_num         VARCHAR(50),
    sls_prd_key         VARCHAR(50),
    sls_cust_id         INT,
    sls_order_dt        DATE,
    sls_ship_dt         DATE,
    sls_due_dt          DATE,
    sls_sales           DECIMAL(18,2),
    sls_quantity        INT,
    sls_price            DECIMAL(18,2)
);
GO


-- =============================================================
-- ERP: Customer Information
-- =============================================================

CREATE TABLE silver.erp_customer_info
(
    CID                 VARCHAR(50),
    BDATE               DATE,
    GEN                 VARCHAR(20)
);
GO


-- =============================================================
-- ERP: Location Information
-- =============================================================

CREATE TABLE silver.erp_location_info
(
    CID                 VARCHAR(50),
    CNTRY               VARCHAR(100)
);
GO


-- =============================================================
-- ERP: Product Category
-- =============================================================

CREATE TABLE silver.erp_product_category
(
    ID                  VARCHAR(50),
    CAT                 VARCHAR(100),
    SUBCAT              VARCHAR(100),
    MAINTENANCE         VARCHAR(100)
);
GO
