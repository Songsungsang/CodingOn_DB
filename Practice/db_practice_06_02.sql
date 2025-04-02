USE codingon_store_db;

SELECT name, order_date
FROM customers c
	JOIN orders o
    ON c.customer_id = o.customer_id;
    
SELECT name
FROM customers c
	LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE order_date IS NULL;

SELECT name, order_id
FROM customers c
	LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
    
SELECT c.name AS customer_name, p.name AS product_name
FROM customers c
	CROSS JOIN products p;
    
SELECT e.name AS employee_name, m.name AS manager_name
FROM employees e
	LEFT JOIN employees m
    ON e.manager_id = m.employee_id;
    
SELECT name AS customer_name, order_date
FROM customers c
	LEFT JOIN orders o
	ON c.customer_id = o.customer_id  
UNION
SELECT name AS customer_name, order_date
FROM customers c
	RIGHT JOIN orders o
	ON c.customer_id = o.customer_id;
    
SELECT p.name AS product_name, SUM(quantity) AS total_quantity
FROM order_items o
	JOIN products p
    ON o.product_id = p.product_id
GROUP BY product_name
HAVING unit_price IS NOT NULL;