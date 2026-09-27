
/*
=============================================================
Gold Layer - Data Warehouse Tables
=============================================================
Purpose:
    Create business-ready dimensional tables for analytics.

The Gold layer follows a Star Schema design consisting of:
    - Customer Dimension
    - Product Dimension
    - Sales Fact

CRM and ERP information are integrated into the Gold layer.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- Dimension: Customers
-- =============================================================

CREATE TABLE gold.dim_customers
(
    customer_key        INT IDENTITY(1,1),
    customer_id         INT,
    customer_number     VARCHAR(50),
    first_name          VARCHAR(100),
    last_name           VARCHAR(100),
    marital_status      VARCHAR(20),
    gender              VARCHAR(20),
    birth_date          DATE,
    country             VARCHAR(100),
    create_date         DATE,

    CONSTRAINT PK_gold_dim_customers
        PRIMARY KEY (customer_key)
);
GO


-- =============================================================
-- Dimension: Products
-- =============================================================

CREATE TABLE gold.dim_products
(
    product_key         INT IDENTITY(1,1),
    product_id          INT,
    product_number      VARCHAR(50),
    product_name        VARCHAR(100),
    product_cost        DECIMAL(10,2),
    product_line        VARCHAR(50),
    category            VARCHAR(100),
    subcategory         VARCHAR(100),
    maintenance         VARCHAR(100),
    start_date          DATE,
    end_date            DATE,

    CONSTRAINT PK_gold_dim_products
        PRIMARY KEY (product_key)
);
GO


-- =============================================================
-- Fact: Sales
-- =============================================================

CREATE TABLE gold.fact_sales
(
    sales_key           INT IDENTITY(1,1),
    order_number        VARCHAR(50),
    customer_key        INT,
    product_key         INT,
    order_date          DATE,
    shipping_date       DATE,
    due_date            DATE,
    sales_amount        DECIMAL(18,2),
    quantity            INT,
    price               DECIMAL(18,2),

    CONSTRAINT PK_gold_fact_sales
        PRIMARY KEY (sales_key),

    CONSTRAINT FK_fact_sales_customer
        FOREIGN KEY (customer_key)
        REFERENCES gold.dim_customers(customer_key),

    CONSTRAINT FK_fact_sales_product
        FOREIGN KEY (product_key)
        REFERENCES gold.dim_products(product_key)
);
GO
