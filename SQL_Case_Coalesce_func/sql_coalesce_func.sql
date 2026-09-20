select * from employeed;


-- q1

select employee_name,
	   bonus,
	   coalesce(bonus,0) as bonus_received
from employeed;

-- q2
select employee_name,
	   phone,
	   coalesce(phone,email) as contact_number
from employeed;

-- q3
select employee_name,
	   manager_name,
	   coalesce(manager_name,'not_assigned') as manager_status
from employeed;


-- q4
select employee_name,
	   salary,
	   salary+coalesce(bonus,0)+coalesce(commission,0) as total_comp
	    
from employeed;


-- q5
select employee_name,
	   bonus,
	   commission,
	   coalesce(bonus,0)+coalesce(commission,0) as total_variable_pay
from employeed
where coalesce(bonus,0)+coalesce(commission,0) > 7000;


-- q6
select employee_name ,
	   email,
	   coalesce(email,phone,'no contact') as contact_info
from employeed;	   


-- q7
select employee_name,
	   department,
	   manager_name,
	   coalesce(manager_name,'no_manager_assigned') as manager_status
from employeed;

select * from employeed;

-- q8
select department,
    coalesce(manager_name,'unassigned') as manager_group,
	count(*) as employee_count
from employeed
group by (department,coalesce(manager_name,'unassigned'))
order by employee_count desc ; 

-- q9
select coalesce(manager_name, 'unassigned') as manager_group,
	   count(*) as employee_count
from employeed	   
group by (coalesce(manager_name, 'unassigned'))
having count(*) >=2
order by employee_count desc;


--q10
select department,
		avg(coalesce(bonus,0)) as avg_bonus
from employeed
group by (department)
having avg(coalesce(bonus,0)) > 4000
order by avg_bonus desc;

-- q11
select employee_name,
	   salary,
	   bonus,
	   commission,
	   coalesce(bonus,0)+coalesce(commission,0) as total_variable_pay,
	   case
	   		when (coalesce(bonus,0)+coalesce(commission,0)) >=10000 then 'high'
			when (coalesce(bonus,0)+coalesce(commission,0)) >=5000 then 'medium'
			else 'low'
		end as variable_pay_status
from employeed;


-- q12
select employee_name,
	   phone,
	   email,
	   coalesce('phone :'|| phone,
	   'Email:'||email,
	   'no_contact_available'
	   ) as preferred_contact
from employeed;

-- q13
select department,coalesce(manager_name,'una') as manager_,
		count(*) as employee_count,
		count(*) filter (where manager_name is null) as emp_no_man
from employeed
group by (department)
having count(*) filter (where manager_name is null)  > =1;


