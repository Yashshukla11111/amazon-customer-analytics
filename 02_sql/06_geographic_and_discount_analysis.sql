
-- GEOGRAPHIC ANALYSIS


USE amazon_db;

-- State Wise Sales
SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM merged_table
GROUP BY state
ORDER BY total_sales DESC;

-- State Wise Profit
SELECT
    state,
    ROUND(SUM(profit), 2) AS total_profit
FROM merged_table
GROUP BY state
ORDER BY total_profit DESC;

-- Top 5 Cities By Profit
SELECT
    city,
    ROUND(SUM(profit), 2) AS total_profit
FROM merged_table
GROUP BY city
ORDER BY total_profit DESC
LIMIT 5;

-- State Wise Total Customers
SELECT
    state,
    COUNT(DISTINCT customer_id) AS total_customers
FROM merged_table
GROUP BY state
ORDER BY total_customers DESC;

-- Average Sales Per Customer By State
SELECT
    state,
    ROUND(
        SUM(sales) / COUNT(DISTINCT customer_id),
        2
    ) AS average_sales_per_customer
FROM merged_table
GROUP BY state
ORDER BY average_sales_per_customer DESC;


-- DISCOUNT ANALYSIS


-- Category Wise Average Discount
SELECT
    category,
    ROUND(AVG(discount_percentage), 2) AS average_discount
FROM merged_table
GROUP BY category
ORDER BY AVG(discount_percentage) DESC;

-- Discount Percentage Wise Sales
SELECT
    discount_percentage,
    ROUND(SUM(sales), 2) AS total_sales
FROM merged_table
GROUP BY discount_percentage
ORDER BY discount_percentage DESC;

-- Discount Percentage Wise Profit
SELECT
    discount_percentage,
    ROUND(SUM(profit), 2) AS total_profit
FROM merged_table
GROUP BY discount_percentage
ORDER BY discount_percentage DESC;

-- Payment Mode Wise Average Discount
SELECT
    payment_mode,
    ROUND(AVG(discount_percentage), 2) AS average_discount
FROM merged_table
GROUP BY payment_mode
ORDER BY payment_mode DESC;
