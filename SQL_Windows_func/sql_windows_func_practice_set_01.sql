-- Topics covered_______________

-- OVER()
-- PARTITION BY
-- ORDER BY inside OVER()
-- ROW_NUMBER()
-- RANK()
-- DENSE_RANK()
-- SUM() OVER()
-- AVG() OVER()
-- COUNT() OVER()
-- Running total
-- Running total with PARTITION BY
-- Running average with ORDER BY
-- Running average with PARTITION BY

-- over()
-- q1
select 
	sale_id,
	employee_name,
	quantity*unit_price as sale_amount,
	sum(quantity*unit_price) over() as total_sales
from sales_data;

-- over(partition by)
-- q2
select 
	sale_id,
	region,
	quantity*unit_price as sale_amount,
	avg(quantity*unit_price) over(
		partition by region
		) as region_avg_sale
from sales_data;

-- over(order by ) ___running total
select 
	sale_id,
	quantity*unit_price as sale_amount,
	sum(quantity*unit_price) over(
		order by sale_date ,sale_id
	) as running_sales
from sales_data;

	
-- row number()
select 
	sale_id,
	employee_name,
	quantity*unit_price as sale_amount,
	row_number() over(
		order by quantity*unit_price desc
	) as sale_no
from sales_data;

-- PARTITION BY + ROW_NUMBER()
select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	row_number() over(
		partition by region
		order by quantity*unit_price desc
		) as reg_sale_no
from sales_data;
	
-- rank()
select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	rank() over(
		order by quantity*unit_price desc
	) as rankk	
from sales_data;


-- dense_rank()
select 
	sale_id,
	employee_name,
	quantity*unit_price as sale_amount,
	dense_rank() over(
		order by quantity*unit_price desc	
	) as d_rankk
from sales_data;

--q2 dense_rank() by region
select 
	sale_id,
	employee_name,
	quantity*unit_price as sale_amount,
	dense_rank() over(
		partition by region
		order by quantity*unit_price desc	
	) as d_rankk
from sales_data;


-- SUM() OVER() + PARTITION BY
select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	sum(quantity*unit_price) over(
		partition by region	
	) as reg_total_sales
from sales_data;

-- AVG() OVER(PARTITION BY ...)
select 
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	avg(quantity*unit_price) over(
		partition by region
	) as region_avg_sale,
	quantity*unit_price - (avg(quantity*unit_price) over(
		partition by region
	)) as diff_from_avg
from sales_data;	


-- count() over()
select 
	sale_id,
	employee_name,
	region,
	count(*) over(
		partition by region
	) as region_sale_count
from sales_data;


-- running_total
select 
	sale_id,
	sale_date,
	employee_name,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		order by sale_date, sale_id	
	) as running_sales
from sales_data;

-- running_total for each region
select 
	sale_id,
	sale_date,
	region,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(
		partition by region
		order by sale_date, sale_id	
	) as running_sales
from sales_data;

-- Running Average
select 
	sale_id,
	sale_date,
	region,
	quantity * unit_price as sale_amount,
	avg(quantity * unit_price) over(
		order by sale_date, sale_id	
	) as running_avg
from sales_data;

-- Running Average by region
select 
	sale_id,
	sale_date,
	region,
	quantity * unit_price as sale_amount,
	avg(quantity * unit_price) over(
		partition by region
		order by sale_date, sale_id	
	) as running_avg
from sales_data;
	