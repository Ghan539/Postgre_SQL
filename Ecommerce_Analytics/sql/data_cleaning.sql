-- Identify missing values in customers

select * from customers
where customer_name is null 
	or email is null
	or city is null
	or signup_date is null;

-- count the missing signup dates	
select count(*) as missing_signup_dates
from customers 
where signup_date is null;

-- Find blank values and extra spaces
select customer_name,
	length(customer_name),
	length(trim(customer_name))
from customers;

select customer_name
from customers
where length(customer_name) !=
	length(trim(customer_name))
;	

-- Preview the trimmed names
select 
	customer_name as og_name,
	trim(customer_name) as cleaned_name
from customers;

-- permanent_update
update customers
set customer_name = trim(customer_name)
where customer_name is not null;

-- 
select * from customers
where customer_name is null;

-- Standardize city names
select *from customers
where city ='unknown';

-- distinct city names
select distinct city from customers;

-- Find duplicate email addresses

select 
	email,
	count(email)
from customers
group by email 
having count(email) >1;

-- 
select * from customers	
where email='dev.reddy35@example.com';


-- Find invalid email addresses
select email,customer_id  from customers 
where email not like '%@%';

select * from customers 
where customer_id = 43;

update customers
set email = 'unknown'
where customer_id = 43;

-- 
select 
    customer_id,
	customer_name,
	email,
	length(email) as before_trim,
	length(trim(email)) as after_trim
from customers
where length(email) !=
	length(trim(email))
;


-- 
select email,
	trim(email) as trimmed_email
from customers 
where customer_id = 178;

-- update the trim
update customers
set email = trim(email)
where customer_id = 178;

-- --
-- Standardize email capitalization
select 
	customer_id,
	email,
	lower(email)
from customers;

-- update 
update customers
set email = lower(email)
where email is not null
	and email <> lower(email);

-- incosistent customer_names
select 
	customer_id,
	customer_name,
	initcap(customer_name) as cap
from customers
where customer_name <> initcap(customer_name);

-- update that customer_name
update customers 
set customer_name = initcap(trim(customer_name))
where customer_name is not null 
 and  customer_name <> initcap(trim(customer_name));


-- products table
select * from products
limit 10 ;

--
select 
	product_name,
	initcap(trim(product_name)) as clean_name
from products
where product_name is not null
	and product_name <> initcap(trim(product_name));

-- 
select 
	product_name,
	trim(product_name) as clean_name
from products
where product_name is not null
	and product_name <> trim(product_name);

	
-- upadate trimmed product names
update products
set product_name = trim(product_name)
where product_name <> trim(product_name);

-- Find duplicate product names
select 
	product_name,
	count(product_name)
from products 
group by product_name 
having count(product_name) > 1;

--null in product names
select 
	product_id,
	product_name
from products 
where product_name is null;

-- Find invalid product prices
select 
    product_id,
	product_name,
	price 
from products
where price <=0;


-- 
update products 
set price = abs(price)
where price < 0;

-- null values in price column

select 
	product_id,
	product_name,
	price
from products
where price is null;

-- -- orders table
select * from orders  limit 3;

-- 
select distinct status 
from orders;

-- 
select 
	 initcap(trim(status)),
	 count(order_id)
from orders
group by initcap(trim(status));	

-- 
select 
	order_id,
	status,
	initcap(trim(status))
from orders
where status <> initcap(trim(status));


-- 
update orders 
set status = initcap(trim(status))
where status is not null
	and status <> initcap(trim(status));

-- --
select 
	status,
	count(*) as total_orders
from orders 
group by status
order by total_orders desc;


-- null order
select * from orders
where status is null;

-- 
select * from orders
where customer_id is null;


-- An order might contain a customer_id that doesn't exist in the customers table.

select 
	o.order_id,
	c.customer_id
from customers c
right join orders o 
on c.customer_id = o.customer_id
where c.customer_id is null;

-- order_id not not exist in orders table

select * from orders limit 3;
select * from order_items limit 3;

select 
    oi.order_item_id,
	oi.order_id,
	o.order_id as matched_order_id
from order_items oi
left join orders o 
on oi.order_id = o.order_id
where o.order_id is null;

-- Find orders with invalid customer references
select 
	o.order_id,
	o.customer_id,
	o.customer_id
from orders o
left join customers c
	on o.customer_id = c.customer_id
where c.customer_id is null;


-- check whether any order_items rows refer to an order that doesn't exist.
select * from order_items;
select * from orders;

select 
	oi.order_item_id,
	o.order_id
from order_items oi
left join orders o
	on oi.order_id = o.order_id
where o.order_id is null;	


-- Step 29: Does each order item have a valid product?

select 
	oi.order_item_id,
	oi.product_id
from order_items oi
left join products p
on oi.product_id = p.product_id
where p.product_id is null;


-- Check invalid quantities

select 
	order_item_id,
	quantity
from order_items 
where quantity <=0;


-- convert to positive 
update order_items
set quantity = abs(quantity)
where quantity < 0;

-- null quantity 
select 
	order_item_id,
	quantity
from order_items 
where quantity is null;


update order_items
set quantity =0
where quantity is null;


-- 
select 
	order_item_id,
	unit_price
from order_items
where unit_price <=0 ;

-- 
update order_items
set unit_price = abs(unit_price)
where unit_price < 0;


-- null unit_price value
select 
	order_item_id,
	unit_price
from order_items
where unit_price is null ;

-- median find
select 
	percentile_cont(0.5)
	within group(order by unit_price) as median_p
from order_items
where unit_price is not null 
	and unit_price > 0;

-- update null values	
update order_items
set unit_price =(
	select 
	    percentile_cont(0.5)
	    within group(order by unit_price) as median_p
    from order_items
    where unit_price > 0
) 
where unit_price is null ;

-- 
update order_items 
set unit_price =(
	select 
		percentile_cont(0.5)
		within group(order by unit_price)
    from order_items
	where unit_price is not null
	and unit_price > 0
)
where unit_price = 0;


-- Find unusually high quantities
select 
	order_item_id,
	product_id,
	quantity 
from order_items 
where quantity > 100;


select 
	distinct quantity 
from order_items ;


-- replace with median
select 
	percentile_cont(0.5)
	within group(order by quantity) as median_quantity
from order_items
where quantity > 0 
	and quantity <=100
	and quantity is not null;
	
-- update
update order_items
set quantity = (
		select 
	    percentile_cont(0.5)
	    within group(order by quantity) as median_quantity
    from order_items
    where quantity > 0 
	   and quantity <=100
	   and quantity is not null
)
where quantity = 1000;


