DROP DATABASE IF EXISTS index_db;
CREATE DATABASE index_db;

USE index_db;

-- 회원 테이블
CREATE TABLE member (
  mem_id      CHAR(8) NOT NULL PRIMARY KEY,
  mem_name    VARCHAR(10) NOT NULL,
  mem_number  INT NOT NULL,
  addr        CHAR(2) NOT NULL,
  phone1      CHAR(3),
  phone2      CHAR(8),
  height      SMALLINT,
  debut_date  DATE
);

-- 구매 테이블
CREATE TABLE buy (
  num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  mem_id      CHAR(8) NOT NULL,
  prod_name   CHAR(20) NOT NULL,
  group_name  CHAR(4),
  price       INT NOT NULL,
  amount      SMALLINT NOT NULL,
  FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

-- 회원 데이터
INSERT INTO member VALUES('NMX', '엔믹스', 6, '서울', '02', '12345678', 165, '2022-02-22');
INSERT INTO member VALUES('LSR', '르세라핌', 5, '부산', '051', '23456789', 170, '2022-05-02');
INSERT INTO member VALUES('IVE', '아이브', 6, '경기', '031', '34567890', 172, '2021-12-01');
INSERT INTO member VALUES('BBZ', '베이비몬스터', 7, '광주', NULL, NULL, 168, '2023-11-27');
INSERT INTO member VALUES('GID', '(여자)아이들', 5, '대전', '042', '45678901', 161, '2018-05-02');
INSERT INTO member VALUES('TRP', '트리플에스', 10, '인천', NULL, NULL, 166, '2022-10-28');
INSERT INTO member VALUES('ESP', '에스파', 4, '전북', '063', '56789012', 165, '2020-11-17');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '67890123', 163, '2016-08-08');
INSERT INTO member VALUES('QWR', 'QWER', 4, '강원', '033', '78901234', 160, '2023-10-01');
INSERT INTO member VALUES('ILL', '아일릿', 5, '제주', '064', '89012345', 167, '2024-03-25');

-- 구매 정보 
INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'IVE', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'GID', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'GID', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'LSR', 'SQL 마스터되기', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'IVE', 'SQL 마스터되기', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'IVE', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'GID', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'IVE', 'SQL 마스터되기', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'GID', '지갑', NULL, 30, 4);

-- 데이터 확인 쿼리
SELECT * FROM member;
SELECT * FROM buy;

CREATE TABLE table1 (
	col1 INT PRIMARY KEY,
    col2 INT,
    col3 INT
);
SHOW INDEX FROM table1;

CREATE TABLE table2 (
	col1 INT PRIMARY KEY,
    col2 INT UNIQUE,
    col3 INT UNIQUE
);
SHOW INDEX FROM table2; -- unique 지정시 자동으로 보조형 index 만들어짐

CREATE TABLE cluster(
	mem_id  CHAR(8),
    mem_name VARCHAR(10)
);

INSERT INTO cluster VALUES('NMX', '엔믹스');
INSERT INTO cluster VALUES('LSR', '르세라핌');
INSERT INTO cluster VALUES('IVE', '아이브');
INSERT INTO cluster VALUES('BBZ', '베이비몬스터');
INSERT INTO cluster VALUES('GID', '(여자)아이들');
INSERT INTO cluster VALUES('TRP', '트리플에스');
INSERT INTO cluster VALUES('ESP', '에스파');
INSERT INTO cluster VALUES('BLK', '블랙핑크');
INSERT INTO cluster VALUES('QWR', 'QWER');
INSERT INTO cluster VALUES('ILL', '아일릿');

SELECT * FROM cluster;

ALTER TABLE cluster
ADD
CONSTRAINT
PRIMARY KEY (mem_id); -- 기본키 지정

SELECT * FROM cluster; -- 원래 입력한 순서가 아닌 알파벳 순으로 자동 정렬됨

CREATE TABLE second(
	mem_id  CHAR(8),
    mem_name VARCHAR(10)
);

INSERT INTO second VALUES('NMX', '엔믹스');
INSERT INTO second VALUES('LSR', '르세라핌');
INSERT INTO second VALUES('IVE', '아이브');
INSERT INTO second VALUES('BBZ', '베이비몬스터');
INSERT INTO second VALUES('GID', '(여자)아이들');
INSERT INTO second VALUES('TRP', '트리플에스');
INSERT INTO second VALUES('ESP', '에스파');
INSERT INTO second VALUES('BLK', '블랙핑크');
INSERT INTO second VALUES('QWR', 'QWER');
INSERT INTO second VALUES('ILL', '아일릿');

ALTER TABLE second
ADD CONSTRAINT
	UNIQUE (mem_id);

SELECT * FROM second; -- 알파벳 순으로 자동정렬 되진 않음

SELECT * FROM member;

CREATE INDEX idx_member_addr
	ON member(addr); -- addr 기준으로 하는 index 생성

SHOW INDEX FROM member;
ANALYZE TABLE member;
SHOW TABLE STATUS LIKE 'member';
SHOW TABLE STATUS;

CREATE UNIQUE INDEX idx_member_num
ON member(mem_number); -- 중복값 존재, index 지정 안됨

CREATE UNIQUE INDEX idx_member_name
ON member(mem_name); -- index 지정 가능

SELECT mem_id, mem_name, addr FROM member;

-- index 삭제
DROP INDEX idx_member_name ON member;