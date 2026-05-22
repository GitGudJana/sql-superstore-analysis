DROP table orders;

DROP TABLE orders;

CREATE TABLE orders (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);

COPY orders
FROM 'C:\superstore.csv'
DELIMITER ','
CSV HEADER
ENCODING 'WIN1252';

SELECT * FROM orders LIMIT 10;

--Which region makes the most money?

SELECT region, SUM(profit) AS total_profit from orders
GROUP BY region
ORDER BY SUM(profit) DESC;

--What's the slowest shipment ever recorded?

SELECT order_id, customer_name, ship_date, order_date, (ship_date - order_date) AS days_to_ship
FROM orders
ORDER BY days_to_ship DESC
Limit 1;

--Which region discounts the most but profits the least?

SELECT region, concat(ROUND(AVG(discount)*100, 1), '%') AS avg_discount, SUM(profit) AS total_profit
       FROM orders
GROUP BY region
ORDER BY avg_discount DESC, total_profit ASC
Limit 1;

--check
