/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

--Begin with a stored procedure to facilitate the reuse of the script---------------

CREATE OR ALTER PROCEDURE bronze.load_bronze AS

-- declare the variables start_time_whole_qry & end_time_whole_qry for the purpose of load time calculation(Entire Script)
DECLARE @start_time_whole_qry DATETIME, @end_time_whole_qry DATETIME;

SET @start_time_whole_qry = GETDATE();
BEGIN
	
	BEGIN TRY
			PRINT '==========================================================';
			PRINT 'Loading the Bronze Layer';
			PRINT '==========================================================';

			PRINT '-----------------------------------------------------------';
			PRINT '==========================================================';
			PRINT 'Loading CRM Tables';
			PRINT '==========================================================';
			-- declare the variables start_time & end_time for the purpose of load time calculation

			DECLARE @start_time DATETIME, @end_time DATETIME;
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.crm_cust_info ';
			-- To prevent duplicates, we truncate table first before loading
			TRUNCATE TABLE bronze.crm_cust_info

			PRINT '>> Inserting Table: bronze.crm_cust_info ';
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\kojol\Downloads\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '>> ----------------';

			PRINT '>> Insepecting Table: bronze.crm_cust_info ';
			-- Assess data for completeness
			--SELECT COUNT(*) FROM bronze.crm_cust_info;

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.crm_prd_info ';
			TRUNCATE TABLE bronze.crm_prd_info

			PRINT '>> Inserting Table: bronze.crm_prd_info ';
			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\kojol\Downloads\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '>> ----------------';

			PRINT '>> Insepecting Table: bronze.crm_prd_info ';
			-- Assess data for completeness
			--SELECT * FROM bronze.crm_prd_info;

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.crm_sales_details ';
			-----------------crm_sales_details---------------------
			TRUNCATE TABLE bronze.crm_sales_details

			PRINT '>> Inserting Table: bronze.crm_sales_details ';
			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\kojol\Downloads\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '>> ----------------';

			PRINT '>> Insepecting Table: bronze.crm_sales_details ';
			-- Assess data for completeness
			---SELECT * FROM bronze.crm_sales_details;


			PRINT '-------------------------------------------------------------------------------';
			PRINT '==========================================================';
			PRINT 'Loading the ERP Tables';
			PRINT '==========================================================';


			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_cust_az12 ';
			-----------------bronze.erp_cust_az12---------------------
			TRUNCATE TABLE bronze.erp_cust_az12
			PRINT '>> Inserting Table: bronze.erp_cust_az12 ';
			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\kojol\Downloads\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '>> ----------------';

			PRINT '>> Insepecting Table: bronze.erp_cust_az12; ';
			-- Assess data for completeness
			--SELECT * FROM bronze.erp_cust_az12;

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_loc_a101 ';
			-----------------bronze.erp_loc_a101---------------------
			TRUNCATE TABLE bronze.erp_loc_a101
			PRINT '>> Inserting Table: bronze.erp_loc_a101 ';
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\kojol\Downloads\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '>> ----------------';

			PRINT '>> Insepecting Table: bronze.erp_loc_a101 ';
			-- Assess data for completeness
			--SELECT * FROM bronze.erp_loc_a101;


			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
			-----------------bronze.erp_px_cat_g1v2---------------------
			TRUNCATE TABLE bronze.erp_px_cat_g1v2

			PRINT '>> Inserting Table: bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\kojol\Downloads\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '>> ----------------';

			PRINT '>> Insepecting Table: bronze.erp_px_cat_g1v2 ';
			-- Assess data for completeness
			--SELECT * FROM bronze.erp_px_cat_g1v2;
		END TRY
		BEGIN CATCH
			PRINT '=================================================';
			PRINT 'ERROR OCCURED DURING THE LOADING OF BRONZE LAYER';
			PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
			PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);	
			PRINT '=================================================';
		END CATCH
END;
SET @end_time_whole_qry = GETDATE();
			PRINT '>> ----------------';
			PRINT '>> Loading Bronze Layer is Complete: '
			PRINT '>> - Total Load Duration: ' + CAST(DATEDIFF(second, @start_time_whole_qry, @end_time_whole_qry) AS NVARCHAR) + 'seconds';
			PRINT '>> ----------------';
GO -- Add GO to separate the CREATE PROCEDURE and EXECUTE statements
EXEC bronze.load_bronze;
