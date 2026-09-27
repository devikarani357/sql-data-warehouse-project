
/*
=============================================================
Silver Layer - Data Loading & Transformation
=============================================================
Purpose:
    Transform and load data from the Bronze layer into
    cleaned and standardized Silver tables.

Transformations include:
    - Removing unnecessary spaces
    - Standardizing text values
    - Handling NULL values
    - Removing duplicate records
    - Validating dates
    - Preparing data for the Gold layer
=============================================================
*/

USE DataWarehouse;
GO


-- =============================================================
-- CRM: Customer Information
-- =============================================================

TRUNCATE TABLE silver.crm_customer_info;

INSERT INTO silver.crm_customer_info
(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)
SELECT
    cst_id,
    TRIM(cst_key),
    TRIM(cst_firstname),
    TRIM(cst_lastname),

    CASE
        WHEN UPPER(TRIM(cst_marital_status)) IN ('M', 'MARRIED')
            THEN 'Married'
        WHEN UPPER(TRIM(cst_marital_status)) IN ('S', 'SINGLE')
            THEN 'Single'
        ELSE 'Unknown'
    END,

    CASE
        WHEN UPPER(TRIM(cst_gndr)) IN ('M', 'MALE')
            THEN 'Male'
        WHEN UPPER(TRIM(cst_gndr)) IN ('F', 'FEMALE')
            THEN 'Female'
        ELSE 'Unknown'
    END,

    cst_create_date

FROM
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY cst_id
               ORDER BY cst_create_date DESC
           ) AS rn
    FROM bronze.crm_customer_info
) AS customer_data
WHERE rn = 1;
GO


-- =============================================================
-- CRM: Product Information
-- =============================================================

TRUNCATE TABLE silver.crm_product_info;

INSERT INTO silver.crm_product_info
(
    prd_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT
    prd_id,
    TRIM(prd_key),
    TRIM(prd_nm),

    CASE
        WHEN prd_cost IS NULL OR prd_cost < 0
            THEN 0
        ELSE prd_cost
    END,

    TRIM(prd_line),
    prd_start_dt,
    prd_end_dt

FROM bronze.crm_product_info;
GO


-- =============================================================
-- CRM: Sales Details
-- =============================================================

TRUNCATE TABLE silver.crm_sales_details;

INSERT INTO silver.crm_sales_details
(
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)
SELECT
    TRIM(sls_ord_num),
    TRIM(sls_prd_key),
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,

    CASE
        WHEN sls_sales IS NULL OR sls_sales < 0
            THEN 0
        ELSE sls_sales
    END,

    CASE
        WHEN sls_quantity IS NULL OR sls_quantity < 0
            THEN 0
        ELSE sls_quantity
    END,

    CASE
        WHEN sls_price IS NULL OR sls_price < 0
            THEN 0
        ELSE sls_price
    END

FROM bronze.crm_sales_details;
GO


-- =============================================================
-- ERP: Customer Information
-- =============================================================

TRUNCATE TABLE silver.erp_customer_info;

INSERT INTO silver.erp_customer_info
(
    CID,
    BDATE,
    GEN
)
SELECT
    TRIM(CID),
    BDATE,

    CASE
        WHEN UPPER(TRIM(GEN)) IN ('M', 'MALE')
            THEN 'Male'
        WHEN UPPER(TRIM(GEN)) IN ('F', 'FEMALE')
            THEN 'Female'
        ELSE 'Unknown'
    END

FROM bronze.erp_customer_info;
GO


-- =============================================================
-- ERP: Location Information
-- =============================================================

TRUNCATE TABLE silver.erp_location_info;

INSERT INTO silver.erp_location_info
(
    CID,
    CNTRY
)
SELECT
    TRIM(CID),

    CASE
        WHEN CNTRY IS NULL OR TRIM(CNTRY) = ''
            THEN 'Unknown'
        ELSE TRIM(CNTRY)
    END

FROM bronze.erp_location_info;
GO


-- =============================================================
-- ERP: Product Category
-- =============================================================

TRUNCATE TABLE silver.erp_product_category;

INSERT INTO silver.erp_product_category
(
    ID,
    CAT,
    SUBCAT,
    MAINTENANCE
)
SELECT
    TRIM(ID),
    TRIM(CAT),
    TRIM(SUBCAT),
    TRIM(MAINTENANCE)

FROM bronze.erp_product_category;
GO
