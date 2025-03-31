-- db 생성 및 지정
CREATE DATABASE codingon_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE codingon_db;

CREATE TABLE class (
	class_id CHAR(5) NOT NULL PRIMARY KEY,
    class_name VARCHAR(30) NOT NULL,
    category VARCHAR(20),
    room CHAR(5) NOT NULL,
    start_date DATE
);

CREATE TABLE student (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age INT,
    gender ENUM("남", "여"),
    class_id CHAR(5) NOT NULL,
    join_date DATE,
    CONSTRAINT class_id_fk
    FOREIGN KEY (class_id) REFERENCES class(class_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

ALTER TABLE student MODIFY age INT;

INSERT INTO class VALUES
("CLS01", "프론트엔드 12기", "프론트엔드", "B-101", "2024-01-08"),
("CLS02", "백엔드 8기", "백엔드", "B-102", "2024-02-05"),
("CLS03", "AI 엔지니어 3기", "AI", "C-201", "2024-03-01"),
("CLS04", "모바일 앱 개발 5기", "모바일", "A-301", "2024-04-10"),
("CLS05", "UI/UX 디자인 6기", "디자인", "D-401", "2024-05-15"),
("CLS06", "데이터 분석 2기", "데이터분석", "B-201", "2024-06-03"),
("CLS07", "클라우드 인프라 1기", "클라우드", "E-102", "2024-06-24"),
("CLS08", "게임 프로그래밍 4기", "게임개발", "G-301", "2024-07-15");

INSERT INTO student VALUES
(NULL, "정국", 25, "남", "CLS01", "2024-01-08"),
(NULL, "장원영", 21, "여", "CLS01", "2024-01-09"),
(NULL, "변우석", NULL, "남", "CLS02", "2024-02-05"),
(NULL, "고윤정", 24, "여", "CLS02", "2024-02-06"),
(NULL, "안유진", 23, "여", "CLS03", "2024-03-01"),
(NULL, "이도현", 26, "남", "CLS03", "2024-03-02"),
(NULL, "박채영", NULL, "여", "CLS04", "2024-04-10"),
(NULL, "박보검", 29, "남", "CLS04", "2024-04-11"),
(NULL, "이지은", NULL, "여", "CLS05", "2024-05-15"),
(NULL, "오해원", 22, "여", "CLS05", "2024-05-16");

SELECT * FROM class;
SELECT * FROM student;