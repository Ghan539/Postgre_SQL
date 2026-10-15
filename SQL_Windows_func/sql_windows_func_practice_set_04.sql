-- Advanced Window Functions

-- top 2 highest sales for each region.
select * from(
	select 
		sale_id,
		employee_name,
		region,
		quantity*unit_price as sale_amount,
		row_number() over(
			partition by region
			order by quantity*unit_price desc
		) as rnk
	from sales_data	
) as rank_sales
where rnk<=2;

-- top 3 highest sales for each employee.

select * from(
	select 
		employee_name,
		sale_date,
		quantity*unit_price as sale_amount,
		row_number() over(
			partition by employee_name
			order by quantity*unit_price desc
		) as rnk
	from sales_data	
) as rank_sales
where rnk<=3;


-- Top-N per group using RANK()

select * from(
	select 
		employee_name,
		sale_date,
		quantity*unit_price as sale_amount,
		dense_rank() over(
			partition by employee_name
			order by quantity*unit_price desc
		) as rnk
	from sales_data	
) as rank_sales
where rnk<=3;


-- Latest record per group
-- Find the latest sale made by each employee.
select * from(
	select 
		employee_name,
		sale_date,
		quantity*unit_price as sale_amount,
		row_number() over(
			partition by employee_name
			order by sale_date desc ,sale_id desc
		) as rnk
	from sales_data	
) as rank_sales
where rnk<=1;


-- Find the latest sale for each region.
select * from(
	select 
		employee_name,
		sale_date,
		region,
		quantity*unit_price as sale_amount,
		row_number() over(
			partition by region
			order by sale_date desc ,sale_id desc
		) as rnk
	from sales_data	
) as rank_sales
where rnk<=1;

-- first sale made by each employee
select * from(
	select 
		employee_name,
		sale_date,
		product,
		quantity*unit_price as sale_amount,
		row_number() over(
			partition by employee_name
			order by sale_date asc ,sale_id asc
		) as rnk
	from sales_data	
) as rank_sales
where rnk<=1;


