WITH data_cleaning AS (
	SELECT *
	FROM online_retail t
	WHERE t.Invoice NOT LIKE 'C%'
  		AND t.[Customer ID] IS NOT NULL
  		AND t.Quantity >= 0
  		AND t.StockCode != 'POST'
)

SELECT
	ROUND(SUM(Quantity * Price), 0) AS [Total Revenue],
	COUNT(DISTINCT [Customer ID]) AS [Total Customers],
	COUNT(DISTINCT Invoice) AS [Total Invoice],
	ROUND(SUM(Quantity * Price) / COUNT(DISTINCT Invoice), 2) AS [AOV],
	ROUND(COUNT(DISTINCT Invoice) / COUNT(DISTINCT [Customer ID]) , 2) AS [Purchase Frequency]
FROM data_cleaning