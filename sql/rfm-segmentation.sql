WITH rfm_cleaning AS (
	SELECT
		t.[Customer ID],
		DATEDIFF(DAY, MAX(t.InvoiceDate), (SELECT MAX(t.InvoiceDate) FROM online_retail t)) AS Recency,
		COUNT(DISTINCT t.Invoice) AS Frequency,
		ROUND(SUM(t.Quantity * t.Price), 2) AS Monetary
	FROM online_retail t
	WHERE t.Invoice NOT LIKE 'C%'
	  AND t.[Customer ID] IS NOT NULL
	  AND t.Quantity > 0
	  AND t.StockCode != 'POST'
	GROUP BY t.[Customer ID]
),

rfm_with_thresholds AS (
	SELECT
		*,
		PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY Recency) OVER() AS r20,
		PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY Recency) OVER() AS r40,
		PERCENTILE_CONT(0.6) WITHIN GROUP (ORDER BY Recency) OVER() AS r60,
		PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY Recency) OVER() AS r80,
		
		PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY Frequency) OVER() AS f20,
		PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY Frequency) OVER() AS f40,
		PERCENTILE_CONT(0.6) WITHIN GROUP (ORDER BY Frequency) OVER() AS f60,
		PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY Frequency) OVER() AS f80,
		
		PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY Monetary) OVER() AS m20,
		PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY Monetary) OVER() AS m40,
		PERCENTILE_CONT(0.6) WITHIN GROUP (ORDER BY Monetary) OVER() AS m60,
		PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY Monetary) OVER() AS m80
	FROM rfm_cleaning
),

rfm_scored AS (
	SELECT 
		[Customer ID],
		Recency,
		Frequency,
		Monetary,
		CASE
			WHEN Recency >= r80 THEN 1
			WHEN Recency >= r60 THEN 2
			WHEN Recency >= r40 THEN 3
			WHEN Recency >= r20 THEN 4
			ELSE 5
		END AS R_Score,
		CASE
			WHEN Frequency >= f80 THEN 5
			WHEN Frequency >= f60 THEN 4
			WHEN Frequency >= f40 THEN 3
			WHEN Frequency >= f20 THEN 2
			ELSE 1
		END AS F_Score,
		CASE
			WHEN Monetary >= m80 THEN 5
			WHEN Monetary >= m60 THEN 4
			WHEN Monetary >= m40 THEN 3
			WHEN Monetary >= m20 THEN 2
			ELSE 1
		END AS M_Score
			
	FROM rfm_with_thresholds
),

total_rfm_scored AS (
	SELECT
		*,
		RFM_Score = R_Score * 100 + F_Score * 10 + M_Score
	FROM rfm_scored
)

SELECT
	*,
	CASE
		WHEN RFM_Score IN (555, 554, 544, 545, 454, 455, 445) THEN 'Champions'
		WHEN RFM_Score IN (543, 444, 435, 355, 354, 345, 344, 335) THEN 'Loyal'
		WHEN RFM_Score IN (553, 551, 552, 541, 542, 533, 532, 531, 452, 451, 442, 441, 431, 453, 433, 432, 423, 353, 352, 351, 342, 341, 333, 323) THEN 'Potential Loyalist'
		WHEN RFM_Score IN (525, 524, 523, 522, 521, 515, 514, 513, 425, 424, 413, 414, 415, 315, 314, 313) THEN 'Promising'
		WHEN RFM_Score IN (512, 511, 422, 421, 412, 411, 311) THEN 'New Customers'
		WHEN RFM_Score IN (535, 534, 443, 434, 343, 334, 325, 324) THEN 'Need Attention'
		WHEN RFM_Score IN (331, 321, 312, 221, 213, 231, 241, 251) THEN 'About To Sleep'
		WHEN RFM_Score IN (255, 254, 245, 244, 253, 252, 243, 242, 235, 234, 225, 224, 153, 152, 145, 143, 142, 135, 134, 133, 125, 124) THEN 'At Risk'
		WHEN RFM_Score IN (155, 154, 144, 214, 215, 115, 114, 113) THEN 'Cannot Lose Them'
		WHEN RFM_Score IN (332, 322, 233, 232, 223, 222, 132, 123, 122, 212, 211) THEN 'Hibernating customers'
		WHEN RFM_Score IN (111, 112, 121, 131, 141, 151) THEN 'Lost customers'
	END AS [RFM Segment]
FROM total_rfm_scored