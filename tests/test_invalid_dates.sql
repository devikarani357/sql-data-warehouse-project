/*
=============================================================
Data Quality Test - Invalid Dates
=============================================================
Purpose:
    Identify invalid or inconsistent dates in the Silver layer.

Expected Result:
    The queries should return ZERO rows.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- Check invalid customer creation dates
-- =============================================================

SELECT
    cst_id,
    cst_create_date
FROM silver.crm_customer_info
WHERE cst_create_date IS NULL
   OR cst_create_date > CAST(GETDATE() AS DATE);
GO


-- =============================================================
-- Check invalid product dates
-- =============================================================

SELECT
    prd_id,
    prd_start_dt,
    prd_end_dt
FROM silver.crm_product_info
WHERE prd_start_dt IS NULL
   OR prd_start_dt > CAST(GETDATE() AS DATE)
   OR (prd_end_dt IS NOT NULL AND prd_end_dt < prd_start_dt);
GO


-- =============================================================
-- Check invalid sales dates
-- =============================================================

SELECT
    sls_ord_num,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt
FROM silver.crm_sales_details
WHERE sls_order_dt IS NULL
   OR sls_ship_dt IS NULL
   OR sls_due_dt IS NULL
   OR sls_ship_dt < sls_order_dt
   OR sls_due_dt < sls_order_dt;
GO


-- =============================================================
-- Check invalid ERP birth dates
-- =============================================================

SELECT
    CID,
    BDATE
FROM silver.erp_customer_info
WHERE BDATE IS NOT NULL
   AND BDATE > CAST(GETDATE() AS DATE);
GO
