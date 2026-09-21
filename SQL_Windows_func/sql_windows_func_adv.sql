-- advanced_windows functions

select * from (
	select 
		sale_id,
		employee_name,
		region,
		quantity * unit_price as sale_amount,
		row_number() over(
			partition by region
		    order by quantity * unit_price desc
			) as hs
	from sales_data
) as ranked_sales	
where hs<=2;		


-- top 3 highest sales for each employee.
select * from (
	select
		employee_name,
		sale_date,
		quantity * unit_price as sale_amount,
		row_number() over(
			partition by employee_name
			order by quantity * unit_price desc
			) as hn
     from sales_data			
) as emp_rank
where hn <=3



-- Top-N per group using RANK()

select * from (
	select
		employee_name,
		sale_date,
		quantity * unit_price as sale_amount,
		rank() over(
			partition by employee_name
			order by quantity * unit_price desc
			) as hn
     from sales_data			
) as emp_rank
where hn <=3

--qq
select * from (
	select
		region,
		employee_name,
		quantity * unit_price as sale_amount,
		rank() over(
			partition by region
			order by quantity * unit_price desc
			) as hn
     from sales_data			
) as sales_rank
where hn <=2


-- DENSE_RANK() for Top-N

select * from(
	select
		region,
		employee_name,
		quantity * unit_price as sale_amount,
		dense_rank() over(
			partition by region
			order by quantity*unit_price desc
	    ) s_rank
	from sales_data
) as ranked_series
where s_rank <=3;


--qq
select * from(
	select
		employee_name,
		sale_date,
		quantity * unit_price as sale_amount,
        dense_rank() over(
			partition by employee_name
			order by quantity*unit_price desc
		) as rnk
	from sales_data
) as ranked_series
where rnk <=2
	
-- Latest record per group

-- q_latest sale made by each employee.

select * from(
	select 
		employee_name,
		sale_date,
		product,
		quantity * unit_price as sale_amount,
		row_number() over(
			partition by employee_name 
			order by sale_date desc , sale_id desc
			) as rnk
	from sales_data
) as rnk_sales
where rnk <=1;


-- practice_qq

select * from(
	select
		region,
		employee_name,
		sale_date,
		quantity * unit_price as sale_amount,
		row_number() over(
			partition by region
			order by sale_date desc, sale_id desc
			) as rnk
	from sales_data
) as rnk_sales
where rnk=1;

-- first sale made by each employee.

select * from(
	select
		employee_name,
		sale_date,
		product,
		quantity * unit_price as sale_amount,
		row_number() over(
			partition by employee_name
			order by sale_date asc, sale_id asc
			) as rnk
	from sales_data
) as rnk_sales
where rnk=1;


-- Deduplication with ROW_NUMBER()

select * from(
	select 
		*,
		row_number() over(
			partition by 
				employee_id,
				customer_id,
				sale_date,
				product,
				quantity,
				unit_price
			order by sale_id 
		) as rnk
	from sales_data
) as duplicates
where rnk>1;
			
		
-- identify duplicate sales
select * from(
	select 
		*,
		row_number() over(
			partition by
				customer_id,
				sale_date,
				product,
				quantity,
				unit_price
			order by sale_id
		) as rnk
	from sales_data
) as duplicates
where rnk>1;


-- LAG() for Previous-Period Analysis

select
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	lag(quantity * unit_price) over(
		partition by employee_name
		order by sale_date, sale_id
	) as previous_sale,
	quantity * unit_price 
	- lag(quantity * unit_price) over(
	  partition by employee_name
	  order by sale_date, sale_id
	) as  sales_change
from sales_data;	
	
-- practice q
select
	region,
	sale_date,
	quantity * unit_price as sale_amount,
	lag(quantity * unit_price) over(
		partition by region
		order by sale_date, sale_id
	) as previous_region_sale,
	quantity * unit_price 
	- lag(quantity * unit_price) over(
		partition by region
		order by sale_date, sale_id
	) as sale_change
from sales_data;	

-- Percentage Change with LAG()
select 
	region,
	sale_date,
	quantity * unit_price as sale_amount,
	lag(quantity * unit_price) over(
		partition by region
		order by sale_date, sale_id
	) as previous_sale,

	-- (current-previous)/previous*100
	(
	(quantity * unit_price)
	- lag(quantity * unit_price) over(
		partition by region
		order by sale_date, sale_id)
	 )
	 /
	 (lag(quantity * unit_price) over(
		partition by region
		order by sale_date, sale_id
		)
	  )*100 as percent_change
from sales_data;	  


-- percentage change for each employee

-- Percentage Change with LAG()
select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	lag(quantity * unit_price) over(
		partition by employee_name
		order by sale_date, sale_id
	) as previous_sale,

	-- (current-previous)/previous*100
	(
	(quantity * unit_price)
	- lag(quantity * unit_price) over(
		partition by employee_name
		order by sale_date, sale_id)
	 )
	 /
	 (lag(quantity * unit_price) over(
		partition by employee_name
		order by sale_date, sale_id
		)
	  )*100 as percent_change
from sales_data;	  
	 