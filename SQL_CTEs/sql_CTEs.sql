-- CTE - common table expression

-- without cte
select 
	employee_name,
	sum(quantity * unit_price) as total_sales
from sales_data
group by employee_name;

-- with cte
with employee_sales as (
	select 	
		employee_name,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_name
)
select * from employee_sales;

-- without cte
select 
	employee_name,
	sum(quantity * unit_price) as total_sales
from sales_data
group by employee_name
having sum(quantity * unit_price) >300000;

-- with cte

with employee_sales as (
	select 	
		employee_name,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_name
)
select
	employee_name,
	total_sales
from employee_sales
where total_sales > 300000;

-- qq
with employee_sales as(
	select 
		employee_name,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_name
)
select 
	employee_name,
	total_sales 
from employee_sales;	

-- qq
with employee_sales as(
	select 
		employee_name,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_name
)
select 
	employee_name,
	total_sales
from employee_sales
where total_sales > 300000;

-- CTE + CASE
-- qq
with employee_sales as(
	select 
		employee_name,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_name
)
select 
	employee_name,
	total_sales,
	case 
		when total_sales >= 300000 then 'high'
		when total_sales >= 200000 then 'medium'
		else 'low'
    end as sales_category
from employee_sales;


-- qq
with employee_sales as(
	select 
		employee_name,
		sum(quantity ) as total_quantity
	from sales_data
	group by employee_name
)

select 
	employee_name,
	total_quantity,
	case
		when total_quantity >=50 then 'high volume'
		when total_quantity >=30 then 'medium volume'
		else 'low volume'
	end as volume_category
from employee_sales;	

-- CTE + JOIN()

with employee_sales as(
	select 	
		employee_id,
		sum(quantity * unit_price) as total_sales
    from sales_data
    group by employee_id
)

select 
	e.employee_id,
	e.department,
	es.total_sales
from employees e
join employee_sales es
	on e.employee_id = es.employee_id;
	
-- practice_q

with employee_sales as (
	select 
		employee_id,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_id
)
select 
	e.employee_id,
	e.first_name,
	e.last_name,
	es.total_sales
from employees e
join employee_sales es
on e.employee_id = es.employee_id;

-- total sales for each employee.

with employee_sales as (
	select 
		employee_id,
		employee_name,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_name,employee_id
)
select 
	e.employee_id,
	e.first_name,
	e.last_name,
	es.total_sales,
	case 
		when es.total_sales >=300000 then 'high performer'
		when es.total_sales >=200000 then 'medium performer'
		else 'low performer'
	end as performance	
from employees e
join employee_sales es
on e.employee_id = es.employee_id;

-- two CTEs in the same query.

with employee_sales as (
	select 
		employee_id,
		sum(quantity * unit_price) as total_sales
	from sales_data
	group by employee_id	
),
sales_average as(
	select 
		avg(total_sales) as average_sales
	from employee_sales	
)
select 
	es.employee_id,
	es.total_sales,
	sa.average_sales
from employee_sales es
cross join sales_average sa;
