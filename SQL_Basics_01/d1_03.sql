select * from employee2;

update employee2
set department = case
	when employee_id = 1 then 'ds'
	when employee_id = 2 then 'research'
	when employee_id = 3 then 'web'
	when employee_id = 4 then 'ds'
	when  employee_id = 5 then 'ds'

end
where employee_id in(1,2,3,4,5);


-- q1
select name , position,salary from employee2;

-- q2
select*from employee2
where salary > 65000;

-- q3
select*from employee2
where position = 'data engineer';

-- q4
select*from employee2
order by salary desc;

-- q5
select*from employee2
order by salary asc;

-- q6
select*from employee2
order by salary desc limit 2;

-- q7
select*from employee2
where department = 'ds' and salary >= 64000;

-- q8
select*from employee2
where salary > 65000 or position = 'data engineer';

-- q8
update employee2
set department = case
	when employee_id = 1 then 'IT'
	when employee_id = 2 then 'Research'
	when employee_id = 3 then 'Web'
	when employee_id = 4 then 'AMC'
	when employee_id = 5 then 'CSE'
end

where employee_id in (1,2,3,4,5);

select*from employee2;

-- q10
update employee2
set department = case
	when salary >= 68000 then 'Senior'
	when salary >= 60000 then 'Mid'
	else 'Junior'
end;

-- q11
select distinct department from employee2;

-- q12
select * from employee2
where salary between 65000 and 70000;

-- q13
select*from employee2
where position in ('data analyst','data engineer','data scientist');

-- q14
select*from employee2
where name like 'a%';

-- q15
select*from employee2
where position is not null;


	
