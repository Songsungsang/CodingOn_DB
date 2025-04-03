USE codingon_store_db;

-- 1. 카테고리가 '전자기기'인 상품 중, 가장 가격이 높은 상품의 이름과 가격을 조회하시오.
SELECT name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products WHERE category = "전자기기");

-- 2. 결제가 '신용카드'로 이루어진 주문을 한 고객의 이름과 ID를 조회하시오.
SELECT name, customer_id
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE payment_method = "신용카드");

-- 3. 1회 이상 주문한 고객 중 가장 최근에 주문한 고객의 이름과 주문일을 출력하시오.
SELECT name, order_date
FROM customers c
	JOIN orders o
    ON c.customer_id = o.customer_id
WHERE order_date = (SELECT MAX(order_date) FROM orders);

-- 4. 서브쿼리를 사용하여, 주문별 총 결제 금액(수량 ×단가 ×할인 반영 합계)이 30만 원 이상인 주문의 주문 ID와 금액을 출력하시오
-- total_price는 정수형으로 출력(출력 예시 참조)
-- 할인율은 (1 -discount_rate/ 100)로 계산
SELECT order_id, ROUND(total_price, 0) AS total_price
FROM (
	SELECT order_id, 
    SUM(quantity * unit_price * (1-discount_rate/100)) AS total_price
    FROM order_items
    GROUP BY order_id) o
WHERE total_price >= 300000;