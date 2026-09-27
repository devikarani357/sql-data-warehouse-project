
/*
=============================================================
Gold Layer - Business Views
=============================================================
Purpose:
    Create business-friendly views on top of the Gold layer.

These views provide a simple interface for analysts and
reporting tools to consume customer, product, and sales data.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- Customer Overview
-- =============================================================

CREATE VIEW gold.v_customer_overview
AS
SELECT
    customer_key,
    customer_id,
    customer_number,
    first_name,
    last_name,
    gender,
    marital_status,
    birth_date,
    country,
    create_date
FROM gold.dim_customers;
GO


-- =============================================================
-- Product Overview
-- =============================================================

CREATE VIEW gold.v_product_overview
AS
SELECT
    product_key,
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
FROM gold.dim_products;
GO


-- =============================================================
-- Sales Overview
-- =============================================================

CREATE VIEW gold.v_sales_overview
AS
SELECT
    fs.sales_key,
    fs.order_number,

    dc.customer_number,
    dc.first_name,
    dc.last_name,
    dc.country,

    dp.product_number,
    dp.product_name,
    dp.product_line,
    dp.category,
    dp.subcategory,

    fs.order_date,
    fs.shipping_date,
    fs.due_date,
    fs.sales_amount,
    fs.quantity,
    fs.price

FROM gold.fact_sales fs

LEFT JOIN gold.dim_customers dc
    ON fs.customer_key = dc.customer_key

LEFT JOIN gold.dim_products dp
    ON fs.product_key = dp.product_key;
GO
