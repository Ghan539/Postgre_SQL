-- over

select 
	sale_id,
	employee_name,
	product,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over() as total_sales
from sales_data;

-- q1
select
	sale_id,
	employee_name,
	product,
	quantity,
	unit_price,
	quantity * unit_price as sale_amount,
	avg(quantity * unit_price) over() as average_sage
from sales_data;

-- partition by
select
	sale_id,
	employee_name,
	product,
	quantity,
	unit_price,
	quantity * unit_price as sale_amount,
	avg(quantity * unit_price) over(partition by region) as region_avg_sale
from sales_data;

-- qq
select
	sale_id,
	employee_name,
	product,
	quantity,
	unit_price,
	quantity * unit_price as sale_amount,
	region,
	sum(quantity * unit_price) over(partition by region) as region_avg_sale
from sales_data;


-- order_by
select
	sale_id,
	employee_name,
	product,
	quantity,
	unit_price,
	region,
    sale_date,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(partition by region order by sale_date) as region_avg_sale
from sales_data;


-- qq
select
	sale_id,
	sale_date,
	employee_name,
	quantity * unit_price as sale_amount,
	sum(quantity * unit_price) over(order by sale_date) as running_sales
from sales_data;

-- row_number()

select
	sale_id,
	employee_name,
	quantity * unit_price as sale_amount,
	row_number() over(
		order by quantity * unit_price desc
		) as sale_number
from sales_data;


-- PARTITION BY + ROW_NUMBER()

select 
	sale_id,
	employee_name,
	region,
	quantity * unit_price as sale_amount,
	row_number() over(
		partition by region
		order by quantity * unit_price desc
		) as region_sale_rank
from sales_data;

-- qq_practice
select
	sale_id,
	employee_name,
	region,
	quantity*unit_price as sale_amount,
	row_number() over(
		partition by region
		order by quantity*unit_price desc
		) as region_rank
from sales_data;

-- rank() 

select 
	sale_id,
	employee_name,
	quantity*unit_price as sale_amount,
	rank() over(
		order by quantity*unit_price desc
		) as sale_rank
from sales_data;

-- dense_rank()


		