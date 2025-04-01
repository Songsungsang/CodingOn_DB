USE codingon_db;

UPDATE student
SET age = 26
WHERE name = "정국";

SELECT * FROM student;

UPDATE student
SET age = age + 1
WHERE class_id = "CLS01" AND age < 25;

SELECT * FROM student;

DELETE FROM class
WHERE room LIKE "G%";

SELECT * FROM class;

DELETE FROM student
WHERE join_date < "2024-03-01";

SELECT * FROM student;