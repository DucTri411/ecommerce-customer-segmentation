SELECT COUNT(*)
FROM online_retail t
WHERE t.Invoice NOT LIKE 'C%'
  AND t.[Customer ID] IS NOT NULL
  AND t.Quantity >= 0
  AND t.StockCode != 'POST'