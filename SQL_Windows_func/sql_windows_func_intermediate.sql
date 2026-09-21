-- Window Frames
-- A window frame controls exactly which rows are included in a window

select 
	sale_id,
	sale_date,
	employee_name,
	quantity * unit_price as sale_amount,
	avg(quantity * unit_price) over(
		order by sale_date , sale_id
		rows between 2 preceding and current row
		) as moving_avg_3_sales
from sales_data;


-- practice question
select
	region,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by region
		order by sale_date,sale_id
		rows between 2 preceding and current row
		) as three_sale_total
from sales_data;


-- unbounded preceding

select
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by employee_name
		order by sale_date,sale_id
		rows between unbounded preceding and current row
		) as emp_running_total
from sales_data;		


-- FOLLOWING rows __Current sale + next n sales

select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by employee_name
		order by sale_date , sale_id
		rows between current row and 2 following
		) as nxt_3_sales_total
from sales_data;

-- practice_qq
select 
	region,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by region
		order by sale_date , sale_id
		rows between current row and 2 following 
		) as next_3_region_sales
from sales_data;


-- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING

-- qq
select 
	region,
	sale_date,
	quantity * unit_price as sale_amount,
	avg (quantity * unit_price) over(
		partition by region 
		order by sale_date , sale_id
		rows between 1 preceding and 1 following 
		) as centered_avg
from sales_data;

-- qq
select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	avg (quantity * unit_price) over(
		partition by employee_name 
		order by sale_date , sale_id
		rows between 1 preceding and 1 following 
		) as centered_emp_avg
from sales_data;

-- unbounded following__future sales remaining for each employee
select
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by employee_name
		order by sale_date , sale_id
		rows between current row and unbounded following 
		) as future_sales_total
from sales_data;


-- qq
select
	region,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by region 
		order by sale_date , sale_id
		rows between current row and unbounded following 
		) as remaning_region_sales
from sales_data;		
	
