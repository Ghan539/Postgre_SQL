
drop table employee3;

create table employee3(
employee_id integer primary key,
first_name varchar(100),
last_name varchar(100),
department varchar(100),
salary numeric(10,2),
joining_date date,
age integer 
);

copy employee3(employee_id,first_name,last_name,department,salary,joining_date,age)
from 'C:/Users/ghans/Desktop/my_pgsql/d12/employee_data.csv'
delimiter ','
csv header;

select*from employee3;

