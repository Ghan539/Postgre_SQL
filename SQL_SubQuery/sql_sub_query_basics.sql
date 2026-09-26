select * from enrollments;
select * from students;
select * from courses;
select * from instructors;
select * from departments;

-- q1
select 
	student_name ,
	cgpa
from students
where cgpa > (
		select avg(cgpa)
		from students
);


-- q2
select 
	student_name ,
	cgpa
from students
where cgpa > (
		select cgpa
		from students
		where student_name = 'Rahul Verma'
);

-- q3
select student_name,
	department_id
from students
where department_id = (
	select department_id
	from students
	where student_name= 'Amit Sharma'
);


-- q4
select student_name,cgpa
from students
where cgpa = (
	select max(cgpa)
	from students
);


-- q5
select 
	s.student_name,
	s.department_id,
	s.cgpa
from students s
where cgpa > (
	select 
	avg(s2.cgpa) 
	from  students s2
	where s2.department_id = s.department_id
);


-- q6

select 
	s.student_name,
	s.department_id,
	s.cgpa
from students s
where cgpa = (
	select 
	max(s2.cgpa) 
	from  students s2
	where s2.department_id = s.department_id
);

-- q7
select 
	 student_name
from students
where student_id in (
	select student_id
	from enrollments 
	where course_id in (
	select course_id 
	from courses
	where fee > (
			select avg(fee)
			from courses
			)
	)		
);

-- q8

select 
	student_name
	from students
	where student_id not in (
		select student_id
		from enrollments
		where course_id = (
			select course_id
			from courses
			where course_name = 'Machine learning'
		)
);


-- exists 
select 
	s.student_name
from students s
where exists (
	select 1 
	from enrollments e
	where e.student_id = s.student_id
);

-- not exists
select 
	s.student_name 
from students s 
where not exists (
	select 1
	from enrollments e
	where e.student_id = s.student_id
);	


-- Any | All
select 
	student_name,
	cgpa
from students
where cgpa > any (
	select cgpa
	from students
	where department_id = (
		select department_id 
		from departments
		where department_name = 'Computer Science'
	)
);


-- q12.  all

select 
	student_name,
	cgpa
from students
where cgpa > all (
	select cgpa
	from students
	where department_id = (
		select department_id 
		from departments
		where department_name = 'Data Science'
	)
);
	

-- q13 highest cgpa in own department
select 
	s.student_name,
	s.department_id,
	s.cgpa
from students s
where cgpa = (
	select max(s2.cgpa)
	from students s2
	where s2.department_id = s.department_id
);
