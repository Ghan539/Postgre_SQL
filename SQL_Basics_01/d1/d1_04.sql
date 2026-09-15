CREATE TABLE employ (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    department VARCHAR(50),
    hire_date DATE,
    salary NUMERIC(10,2),
    city VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO employ
(name, position, department, hire_date, salary, city, email)
VALUES
('Ajit Sharma', 'Data Analyst', 'Data', '2023-01-15', 64000.00, 'Jaipur', 'ajit@company.com'),
('Mehul Sharma', 'Data Engineer', 'Data', '2022-06-20', 75000.00, 'Delhi', 'mehul@company.com'),
('Priya Singh', 'Data Scientist', 'Data', '2024-02-10', 68000.00, 'Mumbai', 'priya@company.com'),
('Rahul Verma', 'Software Engineer', 'Engineering', '2021-11-05', 82000.00, 'Bangalore', 'rahul@company.com'),
('Neha Gupta', 'HR Manager', 'HR', '2020-08-18', 55000.00, 'Jaipur', 'neha@company.com'),
('Arjun Mehta', 'Backend Developer', 'Engineering', '2023-04-12', 70000.00, 'Pune', 'arjun@company.com'),
('Sneha Joshi', 'Business Analyst', 'Business', '2024-01-22', 60000.00, 'Delhi', NULL),
('Vikas Kumar', 'Data Engineer', 'Data', '2022-09-30', 78000.00, 'Mumbai', 'vikas@company.com'),
('Riya Patel', 'Product Manager', 'Product', '2021-03-14', 90000.00, 'Bangalore', 'riya@company.com'),
('Karan Singh', 'Software Engineer', 'Engineering', '2024-05-01', 65000.00, 'Jaipur', NULL);


-- level1

-- q1
select * from employ;
-- q2
select name , position , salary from employ;
-- q3
select*from employ
where department = 'Data';
-- q4
select*from employ
where salary > 70000;
-- q5
select*from employ
where salary <= 70000;

-- level2

-- q6
select*from employ
where city='Jaipur';
-- q7
select*from employ
where city='Jaipur' and salary > 60000;
-- q8
select*from employ
where city='Delhi' or  city='Mumbai';
-- q9
select*from employ
where position='Data Engineer' or position='Software Engineer';
-- q10
select*from employ
where salary between 60000 and 75000;


-- level3

-- q11
select * from employ
order by salary desc;
-- q12
select * from employ
order by salary;
-- q13
select * from employ
order by salary desc limit 3;
-- q14
select * from employ
order by department , salary;

-- level4

-- q15
select * from employ 
where name like 'A%';
-- q16
select * from employ 
where name like 'a%';
-- q17
select * from employ
where position like '%Engineer%'
-- q18
select * from employ 
where email is null;
-- q19
select * from employ 
where email is not null;
-- q20
select distinct department from employ;


-- add column
alter table employ
add column duration interval ;

-- update duration column 

update employ 
set duration = age(current_date , hire_date);

select * from employ;

-- senior_most employ
select * from employ
order by duration desc limit 1;

alter table employ
alter column hire_date type timestamp;

update employ
set name = 'Mainak sharma'
where employee_id = 2;

select * from employ
order by employee_id ;

-- level5
update employ 
set salary = 72000
where name ='Mainak sharma';

-- q22
update employ 
set city = 'Delhi'
where name = 'Priya Singh';

-- q23
alter table employ 
rename column duration to experience_years;

select * from employ;

-- q24
alter table employ
rename column city to location ;

-- q25
alter table employ
alter column position type text;



