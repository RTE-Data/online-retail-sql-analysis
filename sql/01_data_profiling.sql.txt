-- Online Retail SQL Analysis
-- 01 - Data Profiling

-- Basic Exploration
-- 1 How many rows are in the dataset? 
SELECT Count(*)
FROM dbo.OnlineRetail;

-- 2 What is the earliest and latest transaction date?
SELECT 
	MIN(InvoiceDate) AS EarliestTransaction,
	MAX(InvoiceDate) AS LatestTransaction
FROM dbo.OnlineRetail;

-- 3 How many unique customers are there?
SELECT COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM dbo.OnlineRetail;

-- 4 How many unique products are there?
SELECT COUNT(DISTINCT StockCode) AS UniqueProducts
FROM dbo.OnlineRetail;

-- 5 How many countries are represented?
SELECT COUNT(DISTINCT Country) AS UniqueCountries
FROM dbo.OnlineRetail;

-- 6 Are there NULL values? Which columns contain them?
SELECT 
	COUNT(*) - COUNT(InvoiceNo) AS NullInvoiceNo,
	COUNT(*) - COUNT(StockCode) AS NullStockCode,
	COUNT(*) - COUNT(Description) AS NullDescription,
	COUNT(*) - COUNT(Quantity) AS NullQuantity,
	COUNT(*) - COUNT(InvoiceDate) AS NullInvoiceDate,
	COUNT(*) - COUNT(UnitPrice) AS NullUnitPrice,
	COUNT(*) - COUNT(CustomerID) AS NullCustomerID,
	COUNT(*) - COUNT(Country) AS NullCountry
FROM dbo.OnlineRetail;

-- Data Quality
-- 7 Are there transactions with a quantity of zero or less?
SELECT 
	COUNT(*) AS QuantityLessThanEqual0 
FROM dbo.OnlineRetail
WHERE Quantity <= 0;

-- 8 Are there transactions with a unit price of zero or less?
SELECT 
	COUNT(*) AS UnitPriceLessThanEqual0 
FROM dbo.OnlineRetail
WHERE UnitPrice <= 0;

-- 9 Do invoice numbers have unusual patterns?
SELECT
	LEFT(InvoiceNo, 1) AS InvoicePrefix,
	COUNT(*) AS NumberOfRows
FROM dbo.OnlineRetail
GROUP BY LEFT(InvoiceNo, 1)
ORDER BY NumberOfRows DESC;

-- Inspect cancelled invoices
SELECT TOP 20 *
FROM dbo.OnlineRetail
WHERE InvoiceNo LIKE 'C%';

-- Investigate invoices beginning with A
SELECT *
FROM dbo.OnlineRetail
WHERE InvoiceNo LIKE 'A%';

-- 10 Are there duplicate rows?
SELECT
	COUNT(*) AS DuplicateGroups, 
	SUM(dupes.DuplicateCount) AS RowsInDuplicateGroups
FROM (
	SELECT
		*,
		COUNT(*) AS DuplicateCount
	FROM dbo.OnlineRetail
	GROUP BY
		InvoiceNo,
		StockCode,
		Description,
		Quantity,
		InvoiceDate,
		UnitPrice,
		CustomerID,
		Country
	HAVING COUNT(*) > 1
) AS dupes;

