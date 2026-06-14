
-- PRODUCT ANALYSIS

USE amazon_db;

-- Top 10 Products With Highest Profit Margin
SELECT
    product_id,
    product_name,
    profit_margin,
    DENSE_RANK() OVER(ORDER BY profit_margin DESC) AS ranking
FROM products
ORDER BY profit_margin DESC
LIMIT 10;

-- Total Products In Each Category
SELECT
    category,
    COUNT(DISTINCT product_id) AS total_products
FROM merged_table
GROUP BY category;

-- Top 10 Highest Profit Generating Products
SELECT
    product_name,
    product_id,
    category,
    SUM(profit) AS total_profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) AS ranking
FROM merged_table
GROUP BY product_id, product_name, category
ORDER BY SUM(profit) DESC
LIMIT 10;

-- Top 10 Most Demanding Products
SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity,
    DENSE_RANK() OVER(ORDER BY SUM(quantity) DESC) AS ranking
FROM merged_table
GROUP BY product_id, product_name
LIMIT 10;

-- Category Wise Profit Ranking
SELECT
    category,
    ROUND(SUM(profit), 2) AS total_profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) AS ranking
FROM merged_table
GROUP BY category;

-- Highest Stock Products
SELECT
    product_id,
    product_name,
    category,
    stock_quantity,
    DENSE_RANK() OVER(ORDER BY stock_quantity DESC) AS ranking
FROM products
ORDER BY stock_quantity DESC
LIMIT 10;

-- Lowest Stock Products
SELECT
    product_id,
    product_name,
    category,
    stock_quantity,
    DENSE_RANK() OVER(ORDER BY stock_quantity ASC) AS ranking
FROM products
ORDER BY stock_quantity ASC
LIMIT 10;

-- Category Wise Sales
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    DENSE_RANK() OVER(ORDER BY SUM(sales) DESC) AS ranking
FROM merged_table
GROUP BY category
ORDER BY total_sales DESC;
