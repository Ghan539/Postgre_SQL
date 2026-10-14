-- lag()-- access element from previous row

select 
	sale_id,
	employee_name,
	quantity * unit_price as sale_amount,
	lag(quantity * unit_price) over(
		order by sale_date , sale_id
	) as previous_sale
from sales_data;

-- q1
-- Find each employee's sale and the previous sale made by the same employee.
select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	lag(quantity * unit_price) over(
		partition by employee_name
		order by sale_date , sale_id
	) as previous_sale
from sales_data;


-- lead()-lets you access a value from the next row
select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	lead(quantity * unit_price) over(
		partition by employee_name
		order by sale_date , sale_id
	) as previous_sale
from sales_data;

-- Window Frames
-- A window frame controls exactly which rows are included in a window calculation.

select 
	sale_id,
	sale_date,
	employee_name,
	quantity*unit_price as sale_amount,
	avg(quantity*unit_price) over(
		order by sale_date,sale_id
		rows between 2 preceding and current row
	) as moving_avg_3_sales
from sales_data;

-- UNBOUNDED PRECEDING

select 
	sale_id,
	sale_date,
	employee_name,
	quantity*unit_price as sale_amount,
	sum(quantity*unit_price) over(
		order by sale_date,sale_id
		rows between unbounded preceding and current row
	) as moving_avg_3_sales
from sales_data;


--q1. Calculate a running total of sales separately for each employee

select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by employee_name
		order by sale_date,sale_id 
		rows between unbounded preceding and current row
	) as employ_running_sales
from sales_data;


-- FOLLOWING rows --current row + next 2 rows 
select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by employee_name
		order by sale_date,sale_id 
		rows between current row and 2 following
	) as employ_running_sales
from sales_data;



-- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING

-- q1.Calculate the 3-sale average centered around each sale for each region:
select 
	region,
	sale_date,
	quantity*unit_price as sale_amount,
	avg(quantity*unit_price) over(
		partition by region
		order by sale_date , sale_id
		rows between 1 preceding and 1 following
	) as centered_avg
from sales_data;


-- UNBOUNDED FOLLOWING
select 
	employee_name,
	sale_date,
	quantity*unit_price as sale_amount,
	sum(quantity*unit_price) over(
		partition by employee_name
		order by sale_date ,sale_id
		rows between current row and unbounded following
	) as future_sales_total
from sales_data;

	

	
