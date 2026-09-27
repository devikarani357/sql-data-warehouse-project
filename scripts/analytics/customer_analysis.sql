/*
=============================================================
Customer Analysis
=============================================================
Purpose:
    Analyze customer demographics and sales contribution
    using the Gold layer.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- 1. Total Number of Customers
-- =============================================================

SELECT
    COUNT(*) AS total_customers
FROM gold.dim_customers;
GO


-- =============================================================
-- 2. Customers by Country
-- =============================================================

SELECT
    country,
    COUNT(*) AS customer_count
FROM gold.dim_customers
GROUP BY country
ORDER BY customer_count DESC;
GO


-- =============================================================
-- 3. Customers by Gender
-- =============================================================

SELECT
    gender,
    COUNT(*) AS customer_count
FROM gold.dim_customers
GROUP BY gender
ORDER BY customer_count DESC;
GO


-- =============================================================
-- 4. Customers by Marital Status
-- =============================================================

SELECT
    marital_status,
    COUNT(*) AS customer_count
FROM gold.dim_customers
GROUP BY marital_status
ORDER BY customer_count DESC;
GO


-- =============================================================
-- 5. Top Customers by Total Sales
-- =============================================================

SELECT TOP 10
    dc.customer_key,
    dc.customer_number,
    dc.first_name,
    dc.last_name,
    dc.country,
    SUM(fs.sales_amount) AS total_sales
FROM gold.fact_sales fs
INNER JOIN gold.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY
    dc.customer_key,
    dc.customer_number,
    dc.first_name,
    dc.last_name,
    dc.country
ORDER BY total_sales DESC;
GO


-- =============================================================
-- 6. Customer Purchase Quantity
-- =============================================================

SELECT TOP 10
    dc.customer_number,
    dc.first_name,
    dc.last_name,
    SUM(fs.quantity) AS total_quantity_purchased
FROM gold.fact_sales fs
INNER JOIN gold.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY
    dc.customer_number,
    dc.first_name,
    dc.last_name
ORDER BY total_quantity_purchased DESC;
GO


-- =============================================================
-- 7. Customer Sales by Country
-- =============================================================

SELECT
    dc.country,
    COUNT(DISTINCT dc.customer_key) AS customer_count,
    SUM(fs.sales_amount) AS total_sales
FROM gold.fact_sales fs
INNER JOIN gold.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.country
ORDER BY total_sales DESC;
GO
