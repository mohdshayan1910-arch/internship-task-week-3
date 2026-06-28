Use internship

SELECT	
	YEAR(order_date) AS Year,
	MONTH(order_date) AS Month,
	SUM(Sales) AS Total_sales,
	SUM(profit) AS Total_Profit
FROM dbo.orders
GROUP BY 
	YEAR(order_date),
	MONTH(order_date)
ORDER BY
	YEAR(order_date),
	MONTH(order_date)


--Grpwth Rate Calculations
SELECT 
	t1.Month,
	t1.monthly_sales,
	(t1.monthly_sales-t2.monthly_sales)/t1.monthly_sales * 100 AS Growth_Percentage
FROM(
SELECT
	MONTH(order_date) AS Month,
	SUM(sales) AS monthly_sales
FROM dbo.orders
GROUP BY MONTH(order_date))t1
JOIN
(SELECT
	MONTH(order_date) AS Month,
	SUM(sales) AS monthly_sales
FROM dbo.orders
GROUP BY MONTH(order_date))t2
ON t1.Month=t2.Month+1
ORDER BY t2.Month

-- Business Clarification
SELECT 
	order_id,
	sales,
	CASE 
		WHEN Sales>1000 THEN 'High Value'
		WHEN Sales<1000 AND Sales>500 THEN 'Medium Value'
		ELSE 'Low Value'
	END AS Order_Type
FROM dbo.orders

-- Under Performing Region
SELECT
	Region,
	SUM(o.profit) AS Total_Profit
FROM orders o
LEFT JOIN customer c
ON o.id=c.id
GROUP BY c.region
HAVING SUM(o.profit) < 50000
ORDER BY SUM(o.profit)
