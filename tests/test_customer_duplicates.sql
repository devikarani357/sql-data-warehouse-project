/*
=============================================================
Data Quality Test - Customer Duplicates
=============================================================
Purpose:
    Identify duplicate customer records in the Silver layer.

Expected Result:
    The query should return ZERO rows.
=============================================================
*/

USE DataWarehouse;
GO


-- Check duplicate customer IDs

SELECT
    cst_id,
    COUNT(*) AS duplicate_count
FROM silver.crm_customer_info
GROUP BY cst_id
HAVING COUNT(*) > 1;
GO
