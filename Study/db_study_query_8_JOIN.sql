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