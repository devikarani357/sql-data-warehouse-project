/*
=============================================================
Data Quality Test - Missing Keys
=============================================================
Purpose:
    Identify missing or NULL business keys in the Silver layer.

Expected Result:
    The queries should return ZERO rows.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- Check missing customer IDs
-- =============================================================

SELECT
    cst_id,
    cst_key
FROM silver.crm_customer_info
WHERE cst_id IS NULL
   OR cst_key IS NULL
   OR TRIM(cst_key) = '';
GO


-- =============================================================
-- Check missing product IDs / keys
-- =============================================================

SELECT
    prd_id,
    prd_key
FROM silver.crm_product_info
WHERE prd_id IS NULL
   OR prd_key IS NULL
   OR TRIM(prd_key) = '';
GO


-- =============================================================
-- Check missing sales customer IDs
-- =============================================================

SELECT
    sls_ord_num,
    sls_cust_id
FROM silver.crm_sales_details
WHERE sls_cust_id IS NULL;
GO


-- =============================================================
-- Check missing sales product keys
-- =============================================================

SELECT
    sls_ord_num,
    sls_prd_key
FROM silver.crm_sales_details
WHERE sls_prd_key IS NULL
   OR TRIM(sls_prd_key) = '';
GO
