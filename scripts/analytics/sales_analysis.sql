/*
=============================================================
Sales Analysis
=============================================================
Purpose:
    Analyze sales performance, order trends, revenue,
    and customer/product sales using the Gold layer.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- 1. Overall Sales Summary
-- =============================================================

SELECT
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity_sold,
    AVG(sales_amount) AS average_sales_per_transaction
FROM gold.fact_sales;
GO


-- =============================================================
-- 2. Sales by Year
-- =============================================================

SELECT
    YEAR(order_date) AS sales_year,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity_sold,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY sales_year;
GO


-- =============================================================
-- 3. Sales by Month
-- =============================================================

SELECT
    YEAR(order_date) AS sales_year,
    MONTH(order_date) AS sales_month,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity_sold,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    sales_year,
    sales_month;
GO


-- =============================================================
-- 4. Top 10 Orders by Sales
-- =============================================================

SELECT TOP 10
    order_number,
    SUM(sales_amount) AS order_total_sales,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
GROUP BY order_number
ORDER BY order_total_sales DESC;
GO


-- =============================================================
-- 5. Sales by Country
-- =============================================================

SELECT
    dc.country,
    SUM(fs.sales_amount) AS total_sales,
    SUM(fs.quantity) AS total_quantity_sold,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold.fact_sales fs
INNER JOIN gold.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.country
ORDER BY total_sales DESC;
GO


-- =============================================================
-- 6. Sales by Product Category
-- =============================================================

SELECT
    dp.category,
    SUM(fs.sales_amount) AS total_sales,
    SUM(fs.quantity) AS total_quantity_sold,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dp.category
ORDER BY total_sales DESC;
GO


-- =============================================================
-- 7. Average Order Value
-- =============================================================

SELECT
    AVG(order_total) AS average_order_value
FROM
(
    SELECT
        order_number,
        SUM(sales_amount) AS order_total
    FROM gold.fact_sales
    GROUP BY order_number
) AS orders;
GO


-- =============================================================
-- 8. Monthly Sales Trend
-- =============================================================

SELECT
    YEAR(order_date) AS sales_year,
    MONTH(order_date) AS sales_month,
    SUM(sales_amount) AS monthly_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    sales_year,
    sales_month;
GO
