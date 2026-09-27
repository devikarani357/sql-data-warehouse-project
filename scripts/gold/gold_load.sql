/*
=============================================================
Gold Layer - Data Loading & Transformation
=============================================================
Purpose:
    Load business-ready data from the Silver layer into
    Gold dimension and fact tables.

Load Order:
    1. Customer Dimension
    2. Product Dimension
    3. Sales Fact

The Gold layer follows a Star Schema design.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- 1. Customer Dimension
-- =============================================================

TRUNCATE TABLE gold.fact_sales;
TRUNCATE TABLE gold.dim_customers;

INSERT INTO gold.dim_customers
(
    customer_id,
    customer_number,
    first_name,
    last_name,
    marital_status,
    gender,
    birth_date,
    country,
    create_date
)
SELECT
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    ci.cst_marital_status AS marital_status,

    CASE
        WHEN ci.cst_gndr <> 'Unknown'
            THEN ci.cst_gndr
        ELSE COALESCE(ec.GEN, 'Unknown')
    END AS gender,

    ec.BDATE AS birth_date,
    el.CNTRY AS country,
    ci.cst_create_date AS create_date

FROM silver.crm_customer_info ci

LEFT JOIN silver.erp_customer_info ec
    ON ci.cst_key = ec.CID

LEFT JOIN silver.erp_location_info el
    ON ci.cst_key = el.CID;
GO


-- =============================================================
-- 2. Product Dimension
-- =============================================================

TRUNCATE TABLE gold.dim_products;

INSERT INTO gold.dim_products
(
    product_id,
    product_number,
    product_name,
    product_cost,
    product_line,
    category,
    subcategory,
    maintenance,
    start_date,
    end_date
)
SELECT
    pi.prd_id AS product_id,
    pi.prd_key AS product_number,
    pi.prd_nm AS product_name,
    pi.prd_cost AS product_cost,
    pi.prd_line AS product_line,
    pc.CAT AS category,
    pc.SUBCAT AS subcategory,
    pc.MAINTENANCE AS maintenance,
    pi.prd_start_dt AS start_date,
    pi.prd_end_dt AS end_date

FROM silver.crm_product_info pi

LEFT JOIN silver.erp_product_category pc
    ON pi.prd_key = pc.ID;
GO


-- =============================================================
-- 3. Sales Fact
-- =============================================================

INSERT INTO gold.fact_sales
(
    order_number,
    customer_key,
    product_key,
    order_date,
    shipping_date,
    due_date,
    sales_amount,
    quantity,
    price
)
SELECT
    sd.sls_ord_num AS order_number,

    dc.customer_key,

    dp.product_key,

    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS shipping_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price AS price

FROM silver.crm_sales_details sd

LEFT JOIN gold.dim_customers dc
    ON sd.sls_cust_id = dc.customer_id

LEFT JOIN gold.dim_products dp
    ON sd.sls_prd_key = dp.product_number;
GO
