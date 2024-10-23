-- 2.Table Creation
    -- Creating a students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY UNIQUE NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    "age" INT NOT NULL,
    email VARCHAR(30) UNIQUE NOT NULL,
    frontend_mark INT NOT NULL,
    backend_mark INT NOT NULL,
    "status" VARCHAR(50)
);

  -- Create a courses table 
CREATE TABLE courses (
    course_id  SERIAL PRIMARY KEY NOT NULL UNIQUE,
    course_name VARCHAR(100) UNIQUE NOT NULL,
    credits INT NOT NULL
);

   -- Create a enrollment table 
   CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE
);


-- Inserting data into the students table:
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark )
VALUES
 ('Sameer', 21, 'sameer@example.com', 48, 60),
 ('Zoya', 23, 'zoya@example.com', 52, 58),
 ('Nabil', 22, 'nabil@example.com', 37, 46),
 ('Rafi', 24, 'rafi@example.com', 41, 40),
 ('Sophia', 22, 'sophia@example.com', 50, 52),
 ('Hasan', 23, 'hasan@gmail.com', 43, 39)


-- Inserting data into the courses table:
INSERT INTO courses (course_name, credits )
VALUES
 ('Next.js', 3),
 ('React.js', 4),
 ('Databases', 3),
 ('Prisma', 3)
 

-- Inserting data into the enrollment table:
INSERT INTO enrollments (student_id, course_id )
VALUES
 (1, 1),
 (1, 2),
 (2, 1),
 (3, 2)


-- Query 1:
-- Inserting a new student record with the following details:
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark )
VALUES
 ('Mahin', 23, 'mahin@gmail.com', 48, 60)


-- Query 2:
-- Retrieving the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name FROM students s
 JOIN enrollments e ON s.student_id = e.student_id
 JOIN courses "c" ON e.course_id = "c".course_id
 WHERE "c".course_name = 'Next.js';


-- Query 3:
-- Updating the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
    SELECT MAX(frontend_mark + backend_mark)
    FROM students
);


-- Query 4:
-- Deleting all courses that have no students enrolled.
DELETE FROM courses 
   WHERE course_id NOT IN (
    SELECT course_id from enrollments
   );
   

-- Query 5:
-- Retrieving the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students 
    ORDER BY student_id ASC LIMIT 2 OFFSET 2;


-- Query 6:
-- Retrieving the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


-- Query 7:
-- Calculating and display the average age of all students.
SELECT ROUND(AVG(age), 2) AS average_age


-- Query 8:
-- Retrieving the names of students whose email addresses contain 'example.com'.
SELECT student_name FROM students
   WHERE email like '%example.com' ORDER BY student_id ASC;