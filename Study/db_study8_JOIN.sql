USE codingon_store_db;

-- JOIN - 두 테이블을 공통점으로 연결
-- INNER JOIN 내부에 ON 조건이 충족하는, 겹치는 데이터만 나옴
SELECT *
FROM customers
	INNER JOIN orders
    ON customers.customer_id = orders.customer_id;
    
-- customer_id는 두 테이블 모두에 존재하는 상황. SELECT 하려면 명시를 해야함
SELECT c.customer_id, name, email, order_date, order_status
FROM customers c
	JOIN orders o
    ON c.customer_id = o.customer_id
WHERE order_status IS NOT NULL -- 조건 붙이기
ORDER BY order_date DESC; -- 합친 데이터를 정렬해서 보여주기 가능

-- LEFT (OUTER) JOIN
SELECT c.customer_id, name, email, order_date, order_status
FROM customers c
	LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
    
-- UNION - 두개 이상의 SELECT 문 결과 합치기
SELECT name, email FROM customers
UNION
SELECT order_date, order_status FROM orders;

-- FULL OUTER JOIN
SELECT c.customer_id, name, email, order_id, order_date, order_status 
FROM customers c
	LEFT JOIN orders o
	ON c.customer_id = o.customer_id  
UNION
SELECT c.customer_id, name, email, order_id, order_date, order_status 
FROM customers c
	RIGHT JOIN orders o
	ON c.customer_id = o.customer_id;
    
-- 어떤 고객이
-- 어떤 주문을 했으며(주문ID)
-- 어떤 상품을 주문했고(상픔ID)
-- 몇개 샀고(수량)
-- 상품 이름은 무엇이며
-- 얼마에 샀는가
-- 여러 테이블 JOIN
SELECT c.name, o.order_id, p.product_id, p.name, oi.quantity, p.price
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id;

-- CROSS JOIN
USE codingon_db;

SELECT * FROM class
CROSS JOIN student;

-- SELF JOIN
SELECT e.name, m.name
FROM employees e
	LEFT JOIN employees m -- 2개의 employees 테이블, 다른 이름
    ON e.manager_id = m.employee_id; -- 상사의 id = 상사인 직원의 직원 id