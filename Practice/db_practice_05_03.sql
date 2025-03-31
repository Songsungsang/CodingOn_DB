USE codingon_db;

SELECT class_id, COUNT(name) AS student_count
FROM student
GROUP BY class_id;

SELECT gender, AVG(age) AS avg_age
FROM student
GROUP BY gender;

SELECT gender, AVG(age) AS avg_age
FROM student
GROUP BY gender
HAVING AVG(age) > 26; -- group by 이후 결과는 HAVING으로

SELECT class_id, MAX(join_date) AS first_join
FROM student
GROUP BY class_id;

SELECT class_id, MIN(age) AS min_age
FROM student
GROUP BY class_id
HAVING min_age >= 25;

SELECT gender, (MAX(age) - MIN(age)) AS age_gap
FROM student
GROUP BY gender;

SELECT class_id, AVG(age) AS avg_age
FROM student
GROUP BY class_id
HAVING avg_age >= 24
ORDER BY avg_age DESC;