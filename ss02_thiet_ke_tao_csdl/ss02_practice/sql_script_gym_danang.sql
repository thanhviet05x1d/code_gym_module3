-- Câu 1
SELECT student.student_id, student.student_name, class.class_name FROM student, class WHERE student.class_id = class.class_id;
-- Câu 2
SELECT student.student_id, student.student_name, class.class_name
FROM student
LEFT JOIN class ON student.class_id = class.class_id;

-- Câu 3
SELECT *
FROM student
WHERE student_name LIKE '%hai' OR student_name LIKE '%huynh';

-- Câu 4
SELECT *
FROM student
WHERE student_point > 5;

-- Câu 5
SELECT *
FROM student
WHERE student_name LIKE 'nguyen%';

-- Câu 6
SELECT 
    CASE
        WHEN student_point >= 8 THEN 'Excellent'
        WHEN student_point >= 6.5 THEN 'Good'
        WHEN student_point >= 5 THEN 'Pass'
        ELSE 'Fail'
    END AS point_category,
    COUNT(*) AS student_count
FROM student
GROUP BY point_category;

-- Câu 7
SELECT 
    CASE
        WHEN student_point >= 8 THEN 'Excellent'
        WHEN student_point >= 6.5 THEN 'Good'
        WHEN student_point >= 5 THEN 'Pass'
    END AS point_category,
    COUNT(*) AS student_count
FROM student
WHERE student_point > 5
GROUP BY point_category;

-- Câu 8
SELECT 
    CASE
        WHEN student_point >= 8 THEN 'Excellent'
        WHEN student_point >= 6.5 THEN 'Good'
        WHEN student_point >= 5 THEN 'Pass'
    END AS point_category,
    COUNT(*) AS student_count
FROM student
WHERE student_point > 5
GROUP BY point_category
HAVING student_count >= 2;

-- Câu 9
SELECT student_id, student_name
FROM student
WHERE class_id = (SELECT class_id FROM class WHERE class_name = 'c1121g1')
ORDER BY student_name;



