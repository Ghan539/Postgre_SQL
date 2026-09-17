DROP TABLE IF EXISTS students_2023;

CREATE TABLE students_2023 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course VARCHAR(50)
);

INSERT INTO students_2023 (student_id, student_name, course) VALUES
(1, 'Aarav Sharma', 'Computer Science'),
(2, 'Ishita Verma', 'Mechanical Engineering'),
(3, 'Kabir Patel', 'Electronics'),
(4, 'Ananya Desai', 'Civil Engineering'),
(5, 'Rahul Gupta', 'Computer Science');

SELECT * FROM students_2023;


DROP TABLE IF EXISTS students_2024;

CREATE TABLE students_2024 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course VARCHAR(50)
);

INSERT INTO students_2024 (student_id, student_name, course) VALUES
(3, 'Kabir Patel', 'Electronics'),
(4, 'Ananya Desai', 'Civil Engineering'),
(6, 'Meera Rao', 'Computer Science'),
(7, 'Vikram Singh', 'Mathematics');

select * from students_2024;



-- union
select student_name ,course 
from students_2023
union 
select student_name, course
from students_2024;

-- union all 
select student_name ,course 
from students_2023
union all
select student_name, course
from students_2024;

-- intersect 
select student_name ,course 
from students_2023
intersect
select student_name, course
from students_2024;


-- except
select student_name ,course 
from students_2023
except
select student_name, course
from students_2024;