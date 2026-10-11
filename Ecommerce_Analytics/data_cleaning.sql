-- data cleaning table customers

select * from customers 
where customer_name is null;

update customers
set customer_name = 'sai das'
where customer_id = 156;

select * from customers
where email is null;

update customers
set email = 'unknown'
where email is null;

select * from customers
where city is null;

update customers
set city = 'unknown'
where city is null;

select * from customers
where signup_date is null;



-- Find duplicate records
select 
	email,
	count(*) as total
from customers
where email is not null
group by email 
having count(*)>1;

-- Find inconsistent text values

select distinct city 
from customers 
order by city;

select distinct city ,
length(city) 
from  customers;


update customers
set city = trim(city);

-- select where customer_id is null

select order_id from orders
where customer_id is null;

-- 




