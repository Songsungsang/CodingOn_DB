use university_db;

-- ALTER
-- 1. 속성 추가. 추가할때 자료형 명시
ALTER TABLE students ADD address VARCHAR(45);
DESC students;

-- 2. 컬럼 수정
ALTER TABLE students MODIFY address CHAR(20);
DESC students;

-- 3. 컬럼 이름 수정
ALTER TABLE students RENAME COLUMN address TO student_addr;
DESC students;

-- 4. 칼럼의 이름과 타입 수정
ALTER TABLE students CHANGE student_addr address VARCHAR(45);
DESC students;

-- 5. 칼럼 삭제
ALTER TABLE students DROP address;
DESC students;

-- 6. FK키 삭제
ALTER TABLE students DROP FOREIGN KEY professor_fk;
ALTER TABLE professors DROP FOREIGN KEY student_fk;

-- 7. 테이블 삭제
DROP TABLE students;
DROP TABLE professors;