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


-- LAG().comparing the current sale with the previous sale.
select 
	employee_name,
	sale_date,
	quantity*unit_price as sale_amount,
	lag(quantity*unit_price) over(
		partition by employee_name
		order by sale_date,sale_id
		)as previous_sale,
	quantity*unit_price
			-(lag(quantity*unit_price) over(
		partition by employee_name
		order by sale_date,sale_id
		)) as sale_change
from sales_data;		
	
-- Percentage Change with LAG()
select 
	employee_name,
	sale_date,
	quantity*unit_price as sale_amount,
	lag(quantity*unit_price) over(
		partition by employee_name
		order by sale_date,sale_id
	)as previous_sale,
		
	round((
		(quantity*unit_price)
			-lag(quantity*unit_price) over(
		partition by employee_name
		order by sale_date,sale_id)
	 )	
	/lag(quantity*unit_price) over(
		partition by employee_name
		order by sale_date,sale_id
		)*100,2)
		as percent_change
		
from sales_data;