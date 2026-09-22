-- FIRST_VALUE() — Window Functions

select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,

    first_value(quantity * unit_price) over(
		partition by employee_name
		order by sale_date,sale_id
		) as first_sale
from sales_data;

-- qq
select 
	employee_name,
	sale_date,
	product,
	first_value(product) over(
		partition by employee_name
		order by sale_date,sale_id
		) as first_product
from sales_data;		

-- last_value()

-- last-ever sale amount
select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	last_value(quantity * unit_price) over(
		partition by employee_name
		order by sale_date,sale_id
		rows between unbounded preceding and unbounded following
		) as final_sale
from sales_data;


-- NTH_VALUE() — Window Functions

select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
    nth_value(quantity * unit_price,2) over(
		partition by employee_name
		order by sale_date,sale_id
		rows between unbounded preceding and unbounded following 
	) as second_sale
from sales_data;		

-- qq
select
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	nth_value(quantity * unit_price,3) over(
		partition by employee_name
		order by sale_date,sale_id
		rows between unbounded preceding  and  unbounded following
	) as third_sale	
from sales_data;


-- -- qq
select
	employee_name,
	sale_date,
	product,
	nth_value(product,2) over(
		partition by employee_name
		order by sale_date,sale_id
		rows between unbounded preceding  and  unbounded following
	) as second_product	
from sales_data;

-- Detecting Increase or Decrease with LAG()

select 
	employee_name,
	sale_date,
	quantity * unit_price as sale_amount,
	lag(quantity * unit_price) over(
		partition by employee_name
		order by sale_date ,sale_id
		) as previous_sale,
    case 
        when  lag(quantity * unit_price) over(
			    partition by employee_name
				order by sale_date ,sale_id
			    ) is null 
		    then 'first sale'


	
		when (quantity * unit_price) >
			lag(quantity * unit_price) over(
				partition by employee_name
				order by sale_date ,sale_id
			    ) 
		    then 'increased'
			
		when (quantity * unit_price) <
			lag(quantity * unit_price) over(
				partition by employee_name
				order by sale_date ,sale_id
			    ) 
		    then 'decreased'	
		else 'same'	
	end as sales_trend
from sales_data;




	

	
