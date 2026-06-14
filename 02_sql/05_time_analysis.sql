
-- TIME ANALYSIS


USE amazon_db;

-- Year Wise Sales Trend
SELECT
    YEAR(order_date) AS order_year,
    ROUND(SUM(sales), 2) AS total_sales
FROM merged_table
GROUP BY order_year
ORDER BY order_year;

-- Monthly Sales Trend
SELECT
    MONTHNAME(order_date) AS order_month,
    ROUND(SUM(sales), 2) AS total_sales
FROM merged_table
GROUP BY order_month
ORDER BY order_month;

-- Weekly Sales Trend
SELECT
    DAYNAME(order_date) AS order_day,
    ROUND(SUM(sales), 2) AS total_sales
FROM merged_table
GROUP BY order_day
ORDER BY order_day;

-- Month On Month Growth
WITH monthly_sales AS (
    SELECT
        MONTH(order_date) AS order_month,
        YEAR(order_date) AS order_year,
        ROUND(SUM(sales), 2) AS current_total_sales
    FROM merged_table
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    order_year,
    order_month,
    current_total_sales,
    LAG(current_total_sales) OVER(ORDER BY order_year, order_month) AS previous_month_sales,
    ROUND(
        (
            current_total_sales
            -
            LAG(current_total_sales) OVER(ORDER BY order_year, order_month)
        ) * 100
        /
        LAG(current_total_sales) OVER(ORDER BY order_year, order_month),
        2
    ) AS month_on_month_growth_percentage
FROM monthly_sales;

-- Peak Sales Month
SELECT
    MONTHNAME(order_date) AS order_month,
    ROUND(SUM(sales), 2) AS total_sales
FROM merged_table
GROUP BY order_month
ORDER BY total_sales DESC
LIMIT 5;
