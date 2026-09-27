/*
=============================================================
Bronze Layer - Table Definitions
=============================================================
Purpose:
    Create tables for loading raw source data.

The Bronze layer stores source data with minimal transformation.
=============================================================
*/

USE DataWarehouse;
GO

-- CRM Customer Information
CREATE TABLE bronze.crm_customer_info
(
    customer_id       INT,
    customer_name     VARCHAR(100),
    country           VARCHAR(100),
    marital_status    VARCHAR(50),
    gender            VARCHAR(20),
    birthdate         DATE,
    create_date       DATE
);
GO

-- CRM Product Information
CREATE TABLE bronze.crm_product_info
(
    product_id        INT,
    product_key       VARCHAR(50),
    product_name      VARCHAR(100),
    category_id       VARCHAR(50),
    cost              DECIMAL(10,2),
    product_line      VARCHAR(100),
    start_date        DATE
);
GO

-- CRM Sales Details
CREATE TABLE bronze.crm_sales_details
(
    order_number      VARCHAR(50),
    product_key       VARCHAR(50),
    customer_id       INT,
    order_date        DATE,
    shipping_date     DATE,
    due_date          DATE,
    sales_amount      DECIMAL(18,2),
    quantity          INT,
    price             DECIMAL(18,2)
);
GO

-- ERP Customer Information
CREATE TABLE bronze.erp_customer_info
(
    customer_id       VARCHAR(50),
    birth_date        DATE,
    gender            VARCHAR(20)
);
GO

-- ERP Location Information
CREATE TABLE bronze.erp_location_info
(
    customer_id       VARCHAR(50),
    country           VARCHAR(100)
);
GO

-- ERP Product Category Information
CREATE TABLE bronze.erp_product_category
(
    product_id        VARCHAR(50),
    category_id       VARCHAR(50),
    category_name     VARCHAR(100),
    subcategory_name  VARCHAR(100),
    maintenance       VARCHAR(100)
);
GO
