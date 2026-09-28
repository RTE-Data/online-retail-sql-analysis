-- Online Retail SQL Analysis
-- 00 - Data Ingestion

-- =============================================
-- 1. Create initial table
-- =============================================
CREATE TABLE dbo.OnlineRetail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description NVARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME2,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country NVARCHAR(100)
);

-- =============================================
-- 2. Initial import attempt
-- =============================================
-- Initial import attempt.
-- This failed because SQL Server could not convert some InvoiceDate values.
BULK INSERT dbo.OnlineRetail
FROM 'D:\DataProject1\online_retail.csv'
WITH (
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- =============================================
-- 3. Revised import approach
-- =============================================
-- Clear Initial attempt
-- then load InvoiceDate as VARCHAR,
-- then validate and convert it to DATETIME2.
TRUNCATE TABLE dbo.OnlineRetail;

ALTER TABLE dbo.OnlineRetail
ALTER COLUMN InvoiceDate VARCHAR(50);

BULK INSERT dbo.OnlineRetail
FROM 'D:\DataProject1\online_retail.csv'
WITH (
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

SELECT TOP 20 
	InvoiceDate AS OriginalVarchar,
	TRY_CONVERT(datetime2, InvoiceDate, 103) AS ConvertedDate
FROM dbo.OnlineRetail;

SELECT
	COUNT(*) AS InvalidDates
FROM dbo.OnlineRetail
WHERE InvoiceDate IS NOT NULL
	AND TRY_CONVERT(datetime2, InvoiceDate, 103) IS NULL;

ALTER TABLE dbo.OnlineRetail
ADD InvoiceDateConverted DATETIME2;

UPDATE dbo.OnlineRetail
SET InvoiceDateConverted = TRY_CONVERT(DATETIME2, InvoiceDate, 103);

SELECT DISTINCT TOP 10 
    InvoiceDate,
    InvoiceDateConverted
FROM dbo.OnlineRetail;

ALTER TABLE dbo.OnlineRetail
DROP COLUMN InvoiceDate;

EXEC sp_rename
   	'dbo.OnlineRetail.InvoiceDateConverted',
   	'InvoiceDate',
  	'COLUMN';
-- InvoiceDate has been validated and converted to DATETIME2.