select * from product1;

select product_name,price,
	case 
		when price > 50000 then 'expensive'
		when price >=10000 and price <=49000 then 'moderate'
		else 'affordable'
	end as price_category
from products;

--assignment

-- q1
select *from product1;

select product_name,quantity,
	case
		when quantity >=10 then 'in stock'
		when quantity between 5 and 9 then 'limited stock'
		else 'out of stock'
	end as stocks
from product1;


-- q2
select product_name , category,
	case
		when category like 'Electronics' then 'Electronics Item'
		when category like 'Furniture' then 'Furniture Item'
		else 'Accessory Item'
	end as category_type
from product1;

--q2
 select product_name,price,
 	case
	 	when price > 30000 then 'high'
		when price between 10000 and 30000 then 'medium'
		else 'low'
	end as price_level	
from product1;	

-- q3
select product_name,
	   price,
	   quantity,
	   price*quantity as stock_value,
	   case
	   		when price*quantity  > 500000 then 'high value'
		    when price*quantity  between 100000 and 500000 then 'medium value'
			else 'low value'
	   end as value_category
from product1;

-- q5
select product_name,
	   price,
	   discount_rate,
	   case 
	   		when discount_rate > 15 then 'high discount'
			when discount_rate between 10 and 15 then 'medium discount'
			else 'low discount'
	   end as  discount_category
from product1;

-- q6
select product_name,
	   price,
	   quantity,
	   case 
	   		when price > 30000 and quantity < 15 then 'premium'
			when price < 10000 and quantity > 30 then  'bulk' 
			when (price between 10000 and 30000 ) and (quantity between 10 and 30) then 'standard'
			else 'other'
	    end	as product_type
from product1;		

-- q7
select product_name,
	   price,
	   discount_rate,
	   round(price-(price*discount_rate/100)) as final_price,
	   case 
	   		when round(price-(price*discount_rate/100)) >50000 then 'premium'
			when round(price-(price*discount_rate/100)) between 10000 and 50000 then 'mid_range'
			else  'budget'
		end as price_category
from product1;

			
-- q8
select product_name,
	   category,
	   price,
	   quantity,
	   price*quantity as total_value,
	   case
	   		when price*quantity >500000 then 'high'
			when price*quantity between 100000 and 500000 then 'medium'
			else 'low'
       end as category_status
from product1;


-- q9
select product_name,
	   price,
	   quantity,
	   discount_rate,
	   (price-(price*discount_rate/100)) as final_price ,
	   case
	   		when quantity < 10 and (price-(price*discount_rate/100)) > 10000 then 'critical'
			when quantity < 10 and (price-(price*discount_rate/100)) <= 10000 then 'high'
			when quantity between 10 and 30 then 'medium'
			else 'low'
		end as stock_status	
from product1;

			