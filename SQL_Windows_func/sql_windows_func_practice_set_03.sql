-- Advanced Window Functions

-- Topics covered
-- LAG()	
-- LEAD()	
-- Window frames	
-- PRECEDING	
-- FOLLOWING	
-- UNBOUNDED PRECEDING	
-- UNBOUNDED FOLLOWING	
-- Centered window	
-- Top-N per group	
-- Latest record per group	
-- First record per group



-- q1.top 2 highest sales for each region.
select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	row_number() over(
		partition by region
		order by quantity * unit_price desc
	) as high_sale
from sales_data;


-- q1.top 2 highest sales for each region.
select * from (
	select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	row_number() over(
		partition by region
		order by quantity * unit_price desc
	) as rnk
from sales_data
) as second_highest
where rnk <=2;


-- Top-N per group using RANK()
select * from(
		select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	rank() over(
		partition by region
		order by quantity * unit_price desc
	) as rnk
from sales_data
) as rnk
where rnk<=3;

-- DENSE_RANK() for Top-N
select * from(
		select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	dense_rank() over(
		partition by region
		order by quantity * unit_price desc
	) as rnk
from sales_data
) as rnk
where rnk<=2;	

--q. top 3 distinct sale amounts for each region
-- fro distinct use dense_rank()
select * from(
		select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	dense_rank() over(
		partition by region
		order by quantity * unit_price desc
	) as rnk
from sales_data
) as rnk
where rnk<=3;


-- Latest record per group
--Q. Find the latest sale made by each employee.
select * from(
    select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	row_number() over(
		partition by employee_name
		order by sale_date desc,sale_id desc
	) as rnk
from sales_data
) as rnk
where rnk =1;


-- Find the latest sale for each region.
select * from(
    select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	row_number() over(
		partition by region
		order by sale_date desc,sale_id desc
	) as rnk
from sales_data
) as rnk
where rnk =1;


-- First record per employee group
select * from(
    select 
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	row_number() over(
		partition by employee_name
		order by sale_date asc,sale_id asc
	) as rnk
from sales_data
) as rnk
where rnk =1;