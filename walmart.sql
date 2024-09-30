SELECT * FROM INFORMATION_SCHEMA.TABLES



SELECT TOP 10 *
FROM walmart

--Weekly sales across the store--

SELECT store, SUM(weekly_sales) as sum_weekly_sales
FROM walmart
GROUP BY store
ORDER BY sum_weekly_sales DESC;

--retrieving the sales data for weeks that are holiday weeks--
SELECT *
FROM Walmart
WHERE Holiday_Flag = 1;

--Calculating average weekly sales per store--

SELECT store, AVG(weekly_sales) AS avg_weekly_sales
FROM Walmart
GROUP BY Store;

--comparing the total sales between holiday weeks and non-holiday weeks--
SELECT holiday_flag, SUM(weekly_sales) AS sum_weekly_sales
FROM Walmart
GROUP BY Holiday_Flag;


--finding the week with the highest sales for each store--
SELECT store, [DATE], MAX(weekly_sales) max_weekly_sales
FROM Walmart
GROUP BY store, [DATE];

-- calculating weeks that had sales above 1000000--

SELECT [Date],store, Weekly_Sales
FROM walmart
WHERE Weekly_Sales > 1000000
ORDER BY [date];

-- Checking how temperature affect weekly sales AND the average sales for different temperature ranges --

   WITH temp_cte AS 
   (
    SELECT *,
 CASE
   WHEN Temperature < 60 THEN 'Low'
   WHEN Temperature BETWEEN 70 AND 85  THEN 'Normal'
   ELSE 'High' 
   END AS temp_range 
   FROM Walmart
   )
   SELECT temp_range, avg(weekly_sales) as avg_weekly_sales
  FROM temp_cte
   GROUP BY temp_range;



--correlating fuel price with sales performance and also Showing the weekly sales for different ranges of fuel prices.

WITH fuel_price_range AS 
(SELECT *,
  CASE
       WHEN fuel_price <2.5 THEN 'Low Price'
	   WHEN fuel_price BETWEEN 2.5 AND 3.5 THEN 'Normal Price'
	   ELSE 'High Price'
	   END AS fuel_range
	   FROM Walmart
	   )
	   SELECT fuel_range, [date], weekly_sales 
	   FROM fuel_price_range
	   ORDER BY weekly_sales DESC;

--Calculating stores that had the highest sales during holiday weeks--

SELECT Holiday_flag,store, SUM(weekly_sales) as sum_weekly_sales
FROM walmart
WHERE Holiday_Flag = 1
GROUP BY Store, Holiday_Flag 
ORDER BY sum_weekly_sales desc

--weekly sales differience during holiday events compared to non-holiday event--

SELECT holiday_flag, AVG(weekly_sales) as avg_weekly_sales
 FROM Walmart
 GROUP BY Holiday_Flag

--How Consumer Price Index (CPI) affect weekly sales and also Showing average sales by CPI ranges--

WITH cpi_range AS 
(SELECT *,
  CASE
       WHEN CPI <150 THEN 'Low'
	   WHEN CPI BETWEEN 150 AND 200 THEN 'Normal'
	   ELSE 'High'
	   END AS Cpi_rang
	   FROM Walmart
	   )
	   SELECT cpi_rang,AVG(weekly_sales) avg_weekly_sales 
	   FROM cpi_range
	   GROUP BY cpi_rang
	   ORDER BY avg_weekly_sales 


	   --showing relationship between unemployment rates and sales--
	   SELECT unemployment
	   FROM walmart
	   WHERE Unemployment IS NOT NULL
	   ORDER BY Unemployment asc
	   
	   WITH unemployment_range AS 
(SELECT *,
  CASE
       WHEN Unemployment <5 THEN 'Low'
	   WHEN Unemployment BETWEEN 5 AND 7 THEN 'Normal'
	   ELSE 'High'
	   END AS unemployment_rang
	   FROM Walmart
	   )
	   SELECT unemployment_rang,AVG(weekly_sales) avg_weekly_sales 
	   FROM unemployment_range
	   GROUP BY unemployment_rang
	   ORDER BY avg_weekly_sales 

