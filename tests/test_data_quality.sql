/*
=============================================================
Data Quality Test - General Validation
=============================================================
Purpose:
    Perform general quality checks on Silver layer data.

Checks include:
    - Invalid customer values
    - Invalid product values
    - Invalid sales values
    - Missing ERP information

Expected Result:
    The queries should return ZERO rows.
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- Customer Data Quality
-- =============================================================

SELECT
    cst_id,
    cst_firstname,
    cst_lastname,
    cst_gndr,
    cst_marital_status
FROM silver.crm_customer_info
WHERE cst_firstname IS NULL
   OR TRIM(cst_firstname) = ''
   OR cst_lastname IS NULL
   OR TRIM(cst_lastname) = ''
   OR cst_gndr = 'Unknown'
   OR cst_marital_status = 'Unknown';
GO


-- =============================================================
-- Product Data Quality
-- =============================================================

SELECT
    prd_id,
    prd_key,
    prd_nm,
    prd_cost
FROM silver.crm_product_info
WHERE prd_id IS NULL
   OR prd_key IS NULL
   OR TRIM(prd_key) = ''
   OR prd_nm IS NULL
   OR TRIM(prd_nm) = ''
   OR prd_cost < 0;
GO


-- =============================================================
-- Sales Data Quality
-- =============================================================

SELECT
    sls_ord_num,
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_ord_num IS NULL
   OR TRIM(sls_ord_num) = ''
   OR sls_sales < 0
   OR sls_quantity < 0
   OR sls_price < 0;
GO


-- =============================================================
-- ERP Customer Data Quality
-- =============================================================

SELECT
    CID,
    BDATE,
    GEN
FROM silver.erp_customer_info
WHERE CID IS NULL
   OR TRIM(CID) = ''
   OR GEN = 'Unknown';
GO


-- =============================================================
-- ERP Location Data Quality
-- =============================================================

SELECT
    CID,
    CNTRY
FROM silver.erp_location_info
WHERE CID IS NULL
   OR TRIM(CID) = ''
   OR CNTRY IS NULL
   OR TRIM(CNTRY) = ''
   OR CNTRY = 'Unknown';
GO
