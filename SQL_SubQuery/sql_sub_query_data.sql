DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    department_id INT REFERENCES departments(department_id),
    admission_year INT,
    cgpa NUMERIC(3,2)
);

CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    instructor_name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES departments(department_id),
    salary NUMERIC(10,2),
    experience_years INT
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES departments(department_id),
    credits INT,
    fee NUMERIC(10,2),
    instructor_id INT REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE,
    marks INT,
    grade VARCHAR(2)
);

INSERT INTO departments
(department_name)
VALUES
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Electronics'),
('Mechanical'),
('Civil');

INSERT INTO students
(student_name, age, gender, city, department_id, admission_year, cgpa)
VALUES
('Amit Sharma', 21, 'Male', 'Jaipur', 1, 2024, 8.70),
('Neha Patel', 20, 'Female', 'Delhi', 2, 2024, 9.10),
('Rahul Verma', 22, 'Male', 'Jaipur', 3, 2023, 8.40),
('Priya Singh', 21, 'Female', 'Jodhpur', 1, 2024, 9.30),
('Vikas Kumar', 23, 'Male', 'Kota', 4, 2022, 7.80),
('Anjali Mehta', 20, 'Female', 'Jaipur', 2, 2025, 9.50),
('Rohit Jain', 22, 'Male', 'Delhi', 3, 2023, 8.90),
('Sneha Gupta', 21, 'Female', 'Ajmer', 1, 2024, 8.20),
('Karan Joshi', 24, 'Male', 'Jaipur', 5, 2021, 7.60),
('Pooja Sharma', 20, 'Female', 'Udaipur', 3, 2025, 9.00),
('Arjun Mehta', 22, 'Male', 'Jodhpur', 2, 2023, 8.60),
('Kavita Rao', 21, 'Female', 'Kota', 4, 2024, 8.10),
('Manish Agarwal', 23, 'Male', 'Jaipur', 1, 2022, 7.90),
('Riya Kapoor', 20, 'Female', 'Delhi', 2, 2025, 9.20),
('Suresh Yadav', 22, 'Male', 'Ajmer', 3, 2023, 8.30),
('Divya Singh', 21, 'Female', 'Jaipur', 1, 2024, 9.40),
('Mohit Bansal', 23, 'Male', 'Kota', 5, 2022, 7.70),
('Nisha Jain', 20, 'Female', 'Jodhpur', 3, 2025, 8.80),
('Aditya Verma', 22, 'Male', 'Delhi', 2, 2023, 8.50),
('Simran Kaur', 21, 'Female', 'Jaipur', 4, 2024, 8.70);

INSERT INTO instructors
(instructor_name, department_id, salary, experience_years)
VALUES
('Dr. Rajesh Kumar', 1, 95000, 12),
('Dr. Priya Sharma', 2, 110000, 15),
('Dr. Amit Verma', 3, 105000, 13),
('Dr. Suresh Gupta', 4, 85000, 10),
('Dr. Rakesh Singh', 5, 90000, 11),
('Dr. Neha Joshi', 6, 88000, 9),
('Dr. Anil Mehta', 1, 100000, 14),
('Dr. Kavita Rao', 3, 98000, 8);


INSERT INTO courses
(course_name, department_id, credits, fee, instructor_id)
VALUES
('Database Management', 1, 4, 15000, 1),
('Data Structures', 1, 4, 14000, 7),
('Operating Systems', 1, 3, 12000, 1),
('Artificial Intelligence', 2, 4, 20000, 2),
('Machine Learning', 2, 4, 22000, 2),
('Deep Learning', 2, 3, 25000, 2),
('Data Analytics', 3, 4, 18000, 3),
('Big Data', 3, 4, 21000, 8),
('Statistics', 3, 3, 13000, 3),
('Digital Electronics', 4, 4, 16000, 4),
('Microprocessors', 4, 3, 15000, 4),
('Thermodynamics', 5, 4, 17000, 5),
('Engineering Mechanics', 5, 3, 14000, 5),
('Structural Engineering', 6, 4, 19000, 6);


INSERT INTO enrollments
(student_id, course_id, enrollment_date, marks, grade)
VALUES
(1, 1, '2025-01-10', 85, 'A'),
(1, 2, '2025-01-11', 78, 'B'),
(1, 3, '2025-01-12', 82, 'A'),

(2, 4, '2025-01-10', 91, 'A'),
(2, 5, '2025-01-11', 88, 'A'),
(2, 6, '2025-01-12', 94, 'A'),

(3, 7, '2025-01-10', 79, 'B'),
(3, 8, '2025-01-11', 85, 'A'),
(3, 9, '2025-01-12', 76, 'B'),

(4, 1, '2025-01-10', 95, 'A'),
(4, 2, '2025-01-11', 92, 'A'),

(5, 10, '2025-01-10', 72, 'C'),
(5, 11, '2025-01-11', 80, 'B'),

(6, 4, '2025-01-10', 96, 'A'),
(6, 5, '2025-01-11', 93, 'A'),
(6, 6, '2025-01-12', 97, 'A'),

(7, 7, '2025-01-10', 89, 'A'),
(7, 8, '2025-01-11', 91, 'A'),

(8, 1, '2025-01-10', 75, 'B'),
(8, 3, '2025-01-11', 81, 'A'),

(9, 12, '2025-01-10', 70, 'C'),
(9, 13, '2025-01-11', 74, 'C'),

(10, 7, '2025-01-10', 90, 'A'),
(10, 9, '2025-01-11', 87, 'A'),

(11, 4, '2025-01-10', 84, 'A'),
(11, 5, '2025-01-11', 86, 'A'),

(12, 10, '2025-01-10', 88, 'A'),
(12, 11, '2025-01-11', 83, 'A'),

(13, 1, '2025-01-10', 69, 'C'),
(13, 2, '2025-01-11', 77, 'B'),

(14, 4, '2025-01-10', 92, 'A'),
(14, 5, '2025-01-11', 95, 'A'),

(15, 7, '2025-01-10', 80, 'B'),
(15, 8, '2025-01-11', 82, 'A'),

(16, 1, '2025-01-10', 98, 'A'),
(16, 2, '2025-01-11', 94, 'A'),

(17, 12, '2025-01-10', 73, 'C'),
(17, 13, '2025-01-11', 79, 'B'),

(18, 7, '2025-01-10', 86, 'A'),
(18, 9, '2025-01-11', 89, 'A'),

(19, 4, '2025-01-10', 81, 'A'),
(19, 5, '2025-01-11', 84, 'A'),

(20, 10, '2025-01-10', 91, 'A'),
(20, 11, '2025-01-11', 87, 'A');


