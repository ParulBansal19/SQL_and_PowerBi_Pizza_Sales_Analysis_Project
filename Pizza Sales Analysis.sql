-- Total Revenue:

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

--Total Orders:

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

--Total Pizzas Sold:

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales

--Average Order Value:

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales

--Average Pizza Per Order:

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order
FROM pizza_sales

--Daily Trend for Total Orders:

SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--Monthly Trend for Total Orders:

SELECT DATENAME(MM, order_date) AS Order_Month, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MM, order_date)

--% Sales by Pizza Category:

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price)*100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT DESC

--% Sales by Pizza Size:

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price)* 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT 
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

--Total Pizzas Sold by Pizza Category:

SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold DESC

--Top 5 Pizzas by Revenue:

SELECT TOP 5 pizza_name, SUM(total_price) As Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--Bottom 5 Pizzas by Revenue:

SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--Top 5 Pizzas by Quantity:

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

--Bottom 5 Pizzas by Quantity:

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

--Top 5 Pizzas by Total Orders:

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--Bottom 5 Pizzas by Total Orders:

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC

--If you want to apply the pizza_category and pizza_size filters to the above quries you can use WHERE clause,

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic' OR pizza_size = 'L'
GROUP BY pizza_name
ORDER BY Total_Orders ASC