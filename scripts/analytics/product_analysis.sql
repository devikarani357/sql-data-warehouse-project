/*
=============================================================
Product Analysis
=============================================================
Purpose:
    Analyze product performance, categories, and sales
    using the Gold layer.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- 1. Total Number of Products
-- =============================================================

SELECT
    COUNT(*) AS total_products
FROM gold.dim_products;
GO


-- =============================================================
-- 2. Products by Category
-- =============================================================

SELECT
    category,
    COUNT(*) AS product_count
FROM gold.dim_products
GROUP BY category
ORDER BY product_count DESC;
GO


-- =============================================================
-- 3. Products by Product Line
-- =============================================================

SELECT
    product_line,
    COUNT(*) AS product_count
FROM gold.dim_products
GROUP BY product_line
ORDER BY product_count DESC;
GO


-- =============================================================
-- 4. Top 10 Products by Sales
-- =============================================================

SELECT TOP 10
    dp.product_key,
    dp.product_number,
    dp.product_name,
    dp.category,
    dp.subcategory,
    SUM(fs.sales_amount) AS total_sales
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY
    dp.product_key,
    dp.product_number,
    dp.product_name,
    dp.category,
    dp.subcategory
ORDER BY total_sales DESC;
GO


-- =============================================================
-- 5. Top 10 Products by Quantity Sold
-- =============================================================

SELECT TOP 10
    dp.product_number,
    dp.product_name,
    SUM(fs.quantity) AS total_quantity_sold
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY
    dp.product_number,
    dp.product_name
ORDER BY total_quantity_sold DESC;
GO


-- =============================================================
-- 6. Sales by Category
-- =============================================================

SELECT
    dp.category,
    COUNT(DISTINCT dp.product_key) AS product_count,
    SUM(fs.sales_amount) AS total_sales,
    SUM(fs.quantity) AS total_quantity_sold
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dp.category
ORDER BY total_sales DESC;
GO


-- =============================================================
-- 7. Sales by Subcategory
-- =============================================================

SELECT
    dp.category,
    dp.subcategory,
    SUM(fs.sales_amount) AS total_sales,
    SUM(fs.quantity) AS total_quantity_sold
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY
    dp.category,
    dp.subcategory
ORDER BY total_sales DESC;
GO
