CREATE DATABASE superstore_db;
USE superstore_db;
CREATE TABLE superstore (
    Row_id INT,
    Order_id VARCHAR(50),
    Order_date VARCHAR(20),
    Ship_date VARCHAR(20),
    Ship_mode VARCHAR(50),
    Customer_id VARCHAR(50),
    Customer_name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_code VARCHAR(20),
    Region VARCHAR(50),
    Product_id VARCHAR(50),
    Category VARCHAR(50),
    Sub_category VARCHAR(50),
    Product_name VARCHAR(255),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);
SELECT * FROM superstore;
SELECT *
FROM superstore
WHERE state = 'California';

SELECT *
FROM superstore
ORDER BY sales DESC
LIMIT 10;

SELECT category,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

SELECT region,
       SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

SELECT SUM(sales) AS total_sales
FROM superstore;

SELECT AVG(profit) AS avg_profit
FROM superstore;

SELECT SUM(sales) / COUNT(DISTINCT customer_id) 
AS avg_revenue_per_customer
FROM superstore;

SELECT customer_name,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
HAVING total_sales > 5000
ORDER BY total_sales DESC;

SELECT product_name, sales
FROM superstore
WHERE sales > (
    SELECT AVG(sales)
    FROM superstore
);

SELECT state, SUM(profit) AS total_profit
FROM superstore
GROUP BY state
HAVING total_profit = (
    SELECT MAX(total_profit)
    FROM (
        SELECT SUM(profit) AS total_profit
        FROM superstore
        GROUP BY state
    ) AS temp
);

CREATE VIEW category_summary AS
SELECT category,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM superstore
GROUP BY category;

SELECT * FROM category_summary;
CREATE INDEX idx_customer
ON superstore(customer_id);

CREATE INDEX idx_category
ON superstore(category);

CREATE INDEX idx_state
ON superstore(state);

SELECT a.customer_name,
       a.order_id,
       b.region
FROM superstore a
INNER JOIN superstore b
ON a.order_id = b.order_id
LIMIT 10;
