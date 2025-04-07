USE codingon_store_db;

-- WHERE절 서브쿼리
SELECT name, price
FROM products
WHERE price > (
	SELECT AVG(price) FROM products
);

-- FROM절 서브쿼리
-- 카테고리별 평균 가격을 구하고, 평균이 100,000 이상인 카테고리만 출력
SELECT category, avg_price
FROM (
	SELECT category, AVG(price) avg_price
	FROM products
	GROUP BY category
    ) categor_product
WHERE avg_price > 30000;


-- SELECT절 서브쿼리
-- 각 고객의 이름과 해당 고객의 총 주문 수를 함께 출력
SELECT name,
	(SELECT COUNT(*)
	 FROM orders
     WHERE customer_id = c.customer_id -- 바깥 SELECT의 customer의 customer_id 접근 가능
     ) order_count
FROM customers c;

-- View = 가상의 테이블을 저장. 함수랑 같진 않지만 비슷
CREATE VIEW order_price AS
	SELECT order_id, 
    SUM(quantity * unit_price * (1-discount_rate/100)) AS total_price
    FROM order_items
    GROUP BY order_id;
