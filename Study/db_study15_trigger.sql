USE codingon_store_db;

-- 트리거 
-- 테이블 생성
CREATE TABLE order_logs (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
	log_message VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 1. 트리거 생성
DELIMITER //
CREATE TRIGGER trg_after_insert_orders
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	INSERT INTO order_logs(order_id, log_message) 
    VALUES (new.order_id, CONCAT("신규 주문이 생성되었습니다._상태: ", new.order_status));
END //
DELIMITER ;

-- 주문생성
INSERT INTO orders(customer_id, order_date, order_status)
VALUES(1, NOW(), "처리중");

SELECT * FROM order_logs; -- INSERT 이후 처리된 트리거로 인해 저장된 로그

-- 2 delete 시의 트리거
USE index_db;
CREATE TABLE trigger_table (
	id INT,
    txt VARCHAR(10)
);

INSERT INTO trigger_table VALUES(1, "르세라핌");
INSERT INTO trigger_table VALUES(2, "에스파");
INSERT INTO trigger_table VALUES(3, "딥퍼플");

CREATE TABLE delete_logs (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    id INT,
	log_message VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_before_delete
BEFORE DELETE ON trigger_table
FOR EACH ROW
BEGIN
	INSERT INTO delete_logs(id, log_message) 
    VALUES (OLD.id, CONCAT("데이터가 삭제되었습니다._이름: ", OLD.txt)); -- 새거인 new가 아닌 옛날 것의 OLD
END //
DELIMITER ;

DELETE FROM trigger_table WHERE id = 3;

SELECT * FROM delete_logs;

SHOW TRIGGERS;
SHOW TRIGGERS WHERE `TABLE` = "trigger_table";