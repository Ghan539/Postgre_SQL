create table employee(
	employee_id serial primary key,
	name varchar(100) not null,
	position varchar(50),
	department varchar(50),
	hire_date date,
	salary numeric(10,2)
);

select*from employee;

insert into employee(name,position,department,hire_date,salary) 
    values
	('ajit sharma','data analyst','ds','2026-10-12',64000),
	('mehul sharma','data engineer','ds','2026-10-1',61000),
	('ajit sharma','data architect','ds','2026-10-5',70000),
	('ajit sharma','data scientist','ds','2026-10-7',68000),
	('ajit sharma','product analyst','ds','2026-10-2',50000);

select * from employee;


truncate table employee restart identity;