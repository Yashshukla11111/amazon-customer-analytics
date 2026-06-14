
-- CUSTOMER ANALYSIS


USE amazon_db;

-- Total Customers Per State
SELECT
    state,
    COUNT(DISTINCT customer_id) AS total_customers
FROM merged_table
GROUP BY state;

-- Total Customers Per Gender
SELECT
    gender,
    COUNT(DISTINCT customer_id) AS total_customers
FROM merged_table
GROUP BY gender;

-- Top 10 Customers By Sales
SELECT
    name,
    customer_id,
    SUM(sales) AS total_sales,
    DENSE_RANK() OVER(ORDER BY SUM(sales) DESC) AS ranking
FROM merged_table
GROUP BY customer_id, name
LIMIT 10;

-- Top Customers By Profit
SELECT
    customer_id,
    name,
    SUM(profit) AS total_profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) AS ranking
FROM merged_table
GROUP BY customer_id, name
LIMIT 10;

-- Top 10 Maharashtra Customers By Sales
SELECT
    customer_id,
    name,
    state,
    SUM(sales) AS total_sales,
    DENSE_RANK() OVER(ORDER BY SUM(sales) DESC) AS ranking
FROM merged_table
WHERE state = 'Maharashtra'
GROUP BY customer_id, name, state
ORDER BY total_sales DESC
LIMIT 10;

-- Top Customers By Total Orders
SELECT
    customer_id,
    name,
    total_orders,
    state,
    DENSE_RANK() OVER(ORDER BY total_orders DESC) AS ranking
FROM merged_table
LIMIT 10;
