USE codingon_store_db;

-- 1. 고객 주문 내역을 나타내는 v_order_summary뷰를 생성하세요.
-- 포함할 컬럼: customer_id, customer_name, product_name, quantity, order_date
-- 사용해야 할 테이블: customers, orders, order_items, products
CREATE VIEW v_order_summary AS
SELECT c.customer_id, c.name AS customer_name, p.name AS product_name, o_i.quantity, o.order_date
FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items o_i ON o.order_id = o_i.order_id
	JOIN products p ON o_i.product_id = p.product_id;
    
SELECT * FROM v_order_summary;

-- 2. 생성한 뷰를 조회하여 고객 이름과 주문일 기준으로 정렬해보세요. 주문일은 내림차순으로 정렬합니다.
SELECT *
FROM v_order_summary
ORDER BY customer_name, order_date;

-- 3.Step 3. 뷰에 order_status컬럼을 추가한 후, 주문 상태가 '완료'인 주문만 포함되도록 뷰를 수정하세요.
-- 최종 컬럼 구성: customer_id, customer_name, product_name, quantity, order_date, order_status
ALTER VIEW v_order_summary AS
SELECT c.customer_id, c.name AS customer_name, p.name AS product_name, o_i.quantity, o.order_date, order_status
FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items o_i ON o.order_id = o_i.order_id
	JOIN products p ON o_i.product_id = p.product_id
WHERE order_status = "완료";

SELECT * FROM v_order_summary;