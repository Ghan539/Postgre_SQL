DROP TABLE IF EXISTS employee_data;

CREATE TABLE employee_data (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    joining_date DATE,
    birth_date DATE,
    last_promotion_date DATE,
    project_start TIMESTAMP,
    project_end TIMESTAMP
);

INSERT INTO employee_data
(employee_name, department, joining_date, birth_date, last_promotion_date, project_start, project_end)
VALUES
('Amit Sharma', 'IT', '2021-05-12', '1998-03-15', '2024-06-10',
 '2026-01-10 09:30:00', '2026-04-10 18:00:00'),

('Neha Patel', 'HR', '2020-08-25', '1996-11-22', '2023-09-15',
 '2026-02-05 10:00:00', '2026-05-20 17:30:00'),

('Rahul Verma', 'Finance', '2019-02-18', '1995-07-09', '2022-12-01',
 '2026-01-20 09:00:00', '2026-03-25 18:30:00'),

('Anjali Singh', 'IT', '2022-11-03', '2000-01-28', '2025-01-15',
 '2026-03-01 11:00:00', '2026-06-15 19:00:00'),

('Vikas Kumar', 'Sales', '2018-06-30', '1994-05-17', '2023-04-20',
 '2026-02-15 09:45:00', '2026-05-30 18:15:00'),

('Priya Mehta', 'Marketing', '2023-01-10', '1999-09-05', '2025-07-01',
 '2026-04-05 10:30:00', '2026-07-10 17:45:00'),

('Suresh Reddy', 'Operations', '2017-09-14', '1993-12-12', '2022-08-18',
 '2026-01-05 08:30:00', '2026-02-28 17:00:00'),

('Riya Gupta', 'IT', '2024-03-22', '2001-06-25', '2025-12-10',
 '2026-05-01 09:15:00', '2026-08-01 18:00:00'),

('Karan Joshi', 'Finance', '2021-12-05', '1997-02-14', '2024-11-25',
 '2026-03-10 10:15:00', '2026-06-05 18:45:00'),

('Pooja Sharma', 'HR', '2019-10-28', '1996-08-30', '2023-06-12',
 '2026-02-20 09:30:00', '2026-04-30 17:30:00'),

('Arjun Mehta', 'Sales', '2020-04-16', '1998-10-11', '2024-02-20',
 '2026-04-01 10:00:00', '2026-07-01 18:30:00'),

('Sneha Joshi', 'Marketing', '2022-07-19', '2000-12-03', '2025-03-05',
 '2026-05-10 11:30:00', '2026-08-20 19:15:00'),

('Rohit Jain', 'Operations', '2018-12-01', '1992-04-19', '2022-05-10',
 '2026-01-15 08:45:00', '2026-03-10 17:30:00'),

('Kavita Rao', 'IT', '2023-09-11', '1999-03-27', '2025-10-15',
 '2026-06-01 09:00:00', '2026-09-01 18:00:00'),

('Manish Agarwal', 'Finance', '2016-05-20', '1991-01-08', '2021-11-30',
 '2026-02-01 08:00:00', '2026-04-15 17:00:00');


 select * from employee_data;
 
-- q1
select employee_name ,
	extract(year from joining_date) as year_joined 
from employee_data;

-- or
select employee_name ,
	date_part('year',joining_date) as year_joined 
from employee_data;

-- q2
select employee_name ,
	extract('month' from joining_date) as year_joined 
from employee_data;
-- or 
select employee_name ,
	date_part('month',joining_date) as year_joined 
from employee_data;

-- q3
select  employee_name,
	(current_date-joining_date) as no_of_days
from employee_data ;

-- q4
select  employee_name,
	age(current_date,joining_date) as experience
from employee_data ;


-- q5
select employee_name,
to_char(joining_date,'dd-mon-yy') as join_date from employee_data;

-- q6
select employee_name,joining_date,
	(joining_date+interval '2 year') as exact_2yy
from employee_data;

-- q7
select employee_name,
	extract(year from age(current_date,joining_date)) as com_year 
from employee_data;

-- q
select*from employee_data;
select employee_name,
	last_promotion_date,
	age(current_date,last_promotion_date) as mn_sin
from employee_data;	


-- q8
select employee_name,
	extract('month' from age(current_date,last_promotion_date)) as mn_sin
	
from employee_data;


-- q9
select employee_name ,
	project_start,
	date_trunc('month' ,project_start) as mn_start
from employee_data;

-- q10
select employee_name,
	(project_end - project_start ) as project_durn
from employee_data;

-- q11
select department,
	avg(extract(year from age(current_date ,joining_date))) as avg_exp
from employee_data	
group by department
order by avg_exp desc;


-- q12
select department,
	avg(extract(year from age(current_date ,joining_date))) as avg_exp
from employee_data	
group by department
order by avg_exp desc
limit 1;

-- q13
select employee_name,
	project_start,
	project_end,
    extract('day' from (project_end - project_start)) as project_duration
from employee_data
where extract('day' from (project_end - project_start)) > 60;	

-- q14
select employee_name,
	joining_date,
	extract(year from age(current_date,joining_date)) as exp
from employee_data
order by exp desc
limit 1;

select*from employee_data;

-- q15
select employee_name,
	joining_date,
	extract(year from age(current_date,joining_date)) as experience,
	last_promotion_date,
	extract(year from age(current_date,last_promotion_date)) as years_since_prom,
	(project_end - project_start ) as project_duration
from employee_data;