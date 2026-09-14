create table employee2(
	employee_id int primary key,
	name varchar(100) not null,
	position varchar(50),
	department varchar(50),
	hire_date date,
	salary numeric(10,2)
);

select*from employee2;

insert into employee2(employee_id,name,position,department,hire_date,salary) 
    values
	(1,'ajit sharma','data analyst','ds','2026-10-12',64000),
	(2,'mehul sharma','data engineer','ds','2026-10-1',61000),
	(3,'tek chand','data architect','ds','2026-10-5',70000),
	(4,'parmit armani','data scientist','ds','2026-10-7',68000),
	(5,'ajinkya sharma','product analyst','ds','2026-10-2',50000);

select * from employee2;


-- delete row
delete from employee2
where name='mehul sharma';

-- drop column
alter table employee2
drop column salary;


-- drop table 
drop table if exists employee2;

-- truncate table

truncate table employee2;

-- add new column
alter table employee2 
add column gender varchar(25);

-- add values in gender
update employee2
set gender = case
	when employee_id = 1 then 'male'
    when employee_id = 2 then 'female'
	when employee_id = 3 then 'female'
	when employee_id = 4 then 'male'
	when employee_id = 5 then 'female'
end

 where employee_id in (1,2,3,4,5);

-- add constraints to gender
alter table employee2
alter column gender set not null;


select * from employee2;

select * from employee2
order by employee_id asc;

