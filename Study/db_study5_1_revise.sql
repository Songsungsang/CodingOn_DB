-- FK 연습
DROP DATABASE IF EXISTS test_db;
CREATE DATABASE test_db;

CREATE TABLE departments(
	department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employee_cascade( -- cascade 옵션
	employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    
    CONSTRAINT cascade_fk
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
    ON DELETE CASCADE -- 삭제했을때 반응
);

CREATE TABLE employee_setnull( -- set null 옵션
	employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    
    CONSTRAINT setnull_fk
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
    ON DELETE SET NULL
);

INSERT INTO departments VALUES (1, "교육팀");
INSERT INTO departments VALUES (2, "개발팀");

SELECT * FROM departments;

INSERT INTO employee_cascade VALUES
(1, "김다운", 1),
(2, "최창일", 2);

INSERT INTO employee_setnull VALUES
(1, "김소은", 1),
(2, "이혜린", 2);

DELETE FROM departments
WHERE department_id = 1;

SELECT * FROM departments; -- 부서 확인
SELECT * FROM employee_cascade; -- 연결된 테이블의 row 자체 삭제됨
SELECT * FROM employee_setnull; -- 연결된 테이블의 해당 column 값 null 처리 되고 끝