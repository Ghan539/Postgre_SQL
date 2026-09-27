select 
	department_id,
	avg_cgpa
from ( 
	select 
		department_id,
		avg(cgpa) as avg_cgpa
	from students
	group by department_id
) as dept_avg
where avg_cgpa >8.5;

-- q2

