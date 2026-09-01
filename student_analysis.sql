CREATE DATABASE student_analysis;
USE student_analysis;

-- students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender VARCHAR(10),
    age INT
); 

-- subjects table
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50)
); 

-- marks table
CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
); 

-- Students ka data
INSERT INTO students VALUES
(1, 'Rahul', 'Male', 20),
(2, 'Priya', 'Female', 21),
(3, 'Aman', 'Male', 20),
(4, 'Sneha', 'Female', 22),
(5, 'Riya', 'Female', 20); 

-- Subjects ka data
INSERT INTO subjects VALUES
(1, 'Maths'),
(2, 'Science'),
(3, 'English');  
SELECT * FROM subjects;

-- Marks ka data
INSERT INTO marks VALUES
(1, 1, 1, 85),
(2, 1, 2, 78),
(3, 1, 3, 90),
(4, 2, 1, 92),
(5, 2, 2, 88),
(6, 2, 3, 95),
(7, 3, 1, 70),
(8, 3, 2, 75),
(9, 3, 3, 80),
(10, 4, 1, 88),
(11, 4, 2, 91),
(12, 4, 3, 85),
(13, 5, 1, 95),
(14, 5, 2, 89),
(15, 5, 3, 93); 

SELECT * FROM marks; 

-- applying  JOIN(ye tables ko common ids ke through connect krta h )

SELECT 
    students.student_name,
    subjects.subject_name,
    marks.marks
FROM marks
JOIN students 
    ON marks.student_id = students.student_id
JOIN subjects 
    ON marks.subject_id = subjects.subject_id;

-- applying GROUP BY(ye group banata h hr subject ka then avg marks deta h )
SELECT 
    subjects.subject_name,
    AVG(marks.marks) AS average_marks
FROM marks
JOIN subjects 
    ON marks.subject_id = subjects.subject_id
GROUP BY subjects.subject_name; 

-- ORDER BY (desc-highest to lowest)
SELECT 
    subjects.subject_name,
    AVG(marks.marks) AS average_marks
FROM marks
JOIN subjects 
    ON marks.subject_id = subjects.subject_id
GROUP BY subjects.subject_name
ORDER BY average_marks DESC;  

-- Aggregate Functions (min,max,count,avg)
SELECT
    MAX(marks) AS highest_marks,
    MIN(marks) AS lowest_marks,
    AVG(marks) AS average_marks,
    COUNT(marks) AS total_records
FROM marks;   

-- Subquery 
SELECT 
    students.student_name,
    marks.marks
FROM marks
JOIN students 
    ON marks.student_id = students.student_id
WHERE marks.marks > (
    SELECT AVG(marks)
    FROM marks
);  

-- hr Student ka Average Marks  
SELECT
    students.student_name,
    AVG(marks.marks) AS average_marks
FROM students
JOIN marks
    ON students.student_id = marks.student_id
GROUP BY students.student_name
ORDER BY average_marks DESC;  

-- Highest-Scoring Student (for 1 we use ORDER BY marks.marks DESC
-- LIMIT 1;)

SELECT
    students.student_name,
    marks.marks
FROM students
JOIN marks
    ON students.student_id = marks.student_id
WHERE marks.marks = (
    SELECT MAX(marks)
    FROM marks
); 

-- Subject-wise Highest Marks 
SELECT
    subjects.subject_name,
    students.student_name,
    marks.marks
FROM marks
JOIN students
    ON marks.student_id = students.student_id
JOIN subjects
    ON marks.subject_id = subjects.subject_id
WHERE marks.marks = (
    SELECT MAX(m2.marks)
    FROM marks m2
    WHERE m2.subject_id = marks.subject_id
);  

-- Pass/Fail Analysis 
SELECT
    students.student_name,
    subjects.subject_name,
    marks.marks,
    CASE
        WHEN marks.marks >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS result
FROM marks
JOIN students
    ON marks.student_id = students.student_id
JOIN subjects
    ON marks.subject_id = subjects.subject_id ; 
    
-- Student Performance Summary 
SELECT
    students.student_name,
    AVG(marks.marks) AS average_marks,
    MAX(marks.marks) AS highest_marks,
    MIN(marks.marks) AS lowest_marks
FROM students
JOIN marks
    ON students.student_id = marks.student_id
GROUP BY students.student_name
ORDER BY average_marks DESC;  
 