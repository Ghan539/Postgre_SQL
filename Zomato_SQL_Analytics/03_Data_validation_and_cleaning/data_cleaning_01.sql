-------data_cleaning_____

-- 1) customers
select * from staging.customers
limit 5;

-- check null values and blank values
select 
	count(*) as total_rows,
	count(*) filter(where customer_id is null) as mis_customer_id,
	count(*) filter(where first_name is null or trim(first_name) = '') as mis_first_name,
	count(*) filter(where last_name is null or trim(last_name) = '') as mis_last_name,
	count(*) filter(where email is null or trim(email) = '') as mis_email,
	count(*) filter(where phone is null or trim(phone) = '') as mis_phone,
	count(*) filter(where location_id is null) as mis_location_id,
	count(*) filter(where signup_date is null) as mis_signup_date,
	count(*) filter(where customer_segment is null or trim(customer_segment) = '') as mis_customer_segment,
	count(*) filter(where marketing_opt_in is null) as mis_marketing_opt_in
from staging.customers;

	
-- resut: mis_email=25 
-- 	      mis_phone=43
--        marketing_opt_in =36

select 
	count(*) as total_null
from staging.customers
where email is null;

select 
	count(*) as total_null
from staging.customers
where phone is null ;

select * from staging.customers
limit 5;

--------column_wise data cleaning___________

-- first_name
select 
	first_name,
	trim(first_name),
	length(first_name),
	length(trim(first_name))
from staging.customers
where length(first_name) <> length(trim(first_name));


select 
	trim(first_name),
	initcap(trim(first_name))
from staging.customers
where trim(first_name) <> initcap(trim(first_name));


-- last_name
select 
	last_name,
	trim(last_name),
	length(last_name),
	length(trim(last_name))
from staging.customers
where length(last_name) <> length(trim(last_name));	

select 
	trim(last_name),
	initcap(trim(last_name))
from staging.customers
where trim(last_name) <> initcap(trim(last_name));


-- emails
select email from staging.customers
limit 5;

-- null emails
select 
	count(*) filter(where email is null) as null_emails
from staging.customers;

-- duplicate emails
select 
	email,
	count(*) as d_emails
from staging.customers
group by email
having count(*) > 1;

select
	email
from staging.customers
where email <> trim(email);

-- like '%@example.com'
select 
	count(*) filter(where email like '%@example.com')
from staging.customers;

-- not like '%@example.com'
select 
	count(*) filter(where email not like '%@example.com')
from staging.customers;

-- phone
select phone from staging.customers
limit 5 ;

-- null phone
select
	count(*) filter(where phone is null) as null_phone
from staging.customers;

-- duplicate phone
select
	phone,
	count(*) as d_phone
from staging.customers
group by phone
having count(*) > 1;

-- 
select
	phone
from staging.customers
where phone <> trim(phone);

-- like
select
	count(*) filter(where phone not like '+91%') as invalid_ph
from staging.customers ;


-- location_id
select * from staging.customers
limit 5;

select 
	count(*) filter(where location_id is null) as null_location_id
from staging.customers;


-- signup_date
select 
	signup_date 
from staging.customers
where signup_date is null;


-- future signup_date
select 
	signup_date 
from staging.customers
where signup_date > current_date;


-- check data_type of signup_date 
select distinct pg_typeof(signup_date)
from staging.customers;


-- customer_segment
select distinct customer_segment
from staging.customers;

-- marketing_opt_in
select 
	distinct marketing_opt_in
from staging.customers;

-- null values in marketing_opt_in
select 
	count(*) filter(where marketing_opt_in is null) as null_values
from staging.customers;



-- ---------------------------------------
select * from staging.orders
limit 5 ;

-- customer_id
select 
	count(*) filter(where customer_id is null)
from staging.orders;

-- Invalid references: Does every customer_id exist in staging.customer
select 
	o.order_id,
	o.customer_id
from staging.orders o
left join staging.customers c
	on o.customer_id = c.customer_id
where c.customer_id is null;


-- customer_id values that are less than or equal to zero.
select 
	o.customer_id
from staging.orders o
left join staging.customers c
	on o.customer_id = c.customer_id
where o.customer_id <1 ;

-- restaurant_id
-- null values in restaurant_id

select 
	count(*) filter(where restaurant_id is null) as null_values
from staging.orders;

-- invalid references
select 
	o.order_id,
	o.restaurant_id
from staging.orders o
left join staging.restaurants r
	on o.restaurant_id = r.restaurant_id
where r.restaurant_id is null;

-- invalid o.restaurant_id
select 
	o.restaurant_id
from staging.orders o
left join staging.restaurants r
	on o.restaurant_id = r.restaurant_id
where o.restaurant_id < 1 ;


-- order_status
select 
	count(*) filter(where order_status is null) as null_values
from staging.orders;

-- distinct in order_status
select 
	distinct order_status
from staging.orders;


-- order_type
select 
	count(*) filter(where order_type is null)
from staging.orders;

-- distinct order_type
select 
	distinct order_type
from staging.orders;


-- discount_inr
select 
	count(*) filter (where discount_inr is null)
from staging.orders;

-- invalid discount
select 
	discount_inr
from staging.orders
where discount_inr < 0;

-- max discount
select
	max(discount_inr)
from staging.orders;

-- special_instructions
select
	count(*) filter(where special_instructions is null)
from staging.orders ;
 
-- result : 2128 null values in special_instructions
select 
	distinct special_instructions
from staging.orders ;	

-- source_channel
select distinct source_channel
from staging.orders;

-- null values in source_channel
select
	count(*) filter(where source_channel is null)
from staging.orders;


-- ---------------------------------------------------------------
-- null values in locations
select
	count(*) as total_rows,
	count(*) filter(where city is null or trim(city)='') as miss_city,
	count(*) filter(where state is null or trim(state)='') as miss_state,
	count(*) filter(where area is null or trim(area)='') as miss_area,
	count(*) filter(where postal_code is null or trim(postal_code)='') as postal_code
from staging.locations;	
	


-- locations table
select * from staging.locations
limit 5;

-- distinct city 
select 
	distinct city 
from staging.locations;

-- distinct state
select 
	distinct state 
from staging.locations;

-- menu_items 
select * from staging.menu_items 
limit 5 ;


--invalid restaurant_id referance
select 
	mi.menu_item_id,
	mi.restaurant_id
from staging.menu_items mi
left join staging.restaurants r
	on mi.restaurant_id = r.restaurant_id
where r.restaurant_id is null;


--invalid cuisine_id referance
select 
	mi.menu_item_id,
	mi.cuisine_id
from staging.menu_items mi
left join staging.cuisines cu
	on mi.cuisine_id = cu.cuisine_id
where cu.cuisine_id is null;

-- null values in is_vegetarian
select 
	count(*) filter (where is_vegetarian is null) as null_values
from staging.menu_items;


-- 
select 
	item_name,
	is_vegetarian
from  staging.menu_items
where is_vegetarian is null
and item_name in ('Chicken Biryani','Egg Biryani');

-- update is_vegetarian
update staging.menu_items
set is_vegetarian = False
where is_vegetarian is null
and item_name in ('Chicken Biryani','Egg Biryani');


	
-- order_items

select * from staging.order_items
limit 5;

-- check null values
select 
	count(*) as total_rows,
	count(*) filter(where order_id is null) as null_order_id,
	count(*) filter(where menu_item_id is null) as null_menu_item_id,
	count(*) filter(where quantity is null) as null_quantity,
	count(*) filter(where unit_price_inr is null) as null_unit_price
from staging.order_items ;


-- invalid reference of order_id
select 
	oi.order_item_id,
	oi.order_id
from staging.order_items oi
left join staging.orders o
on oi.order_id = o.order_id
where o.order_id is null;


-- invalid reference of menu_item_id
select 
	oi.order_item_id,
	oi.menu_item_id
from staging.order_items oi
left join staging.menu_items m
on oi.menu_item_id = m.menu_item_id
where m.menu_item_id is null;


--  invalid quantity
select 
	quantity
	from staging.order_items
where quantity <=0;


----  invalid price
select 
	unit_price_inr
	from staging.order_items
where unit_price_inr < 0; 


-- cuisines
select * from staging.cuisines
limit 5;

-- distinct cuisine_name
select distinct cuisine_name
from staging.cuisines;


-- payments
select * from staging.payments
limit 5;

-- null values 
select 
	count(*) as total_transactions,
	count(*) filter(where order_id is null) as null_values,
	count(*) filter(where payment_method is null) as null_payments_methods,
	count(*) filter(where payment_status is null ) as null_payment_status,
	count(*) filter(where payment_datetime is null) as null_payment_datetime,
	count(*) filter(where transaction_reference is null) as null_transaction_reference
from staging.payments;



-- 
select 
	payment_method,
	payment_status,
	transaction_reference
from staging.payments
where transaction_reference is null
and payment_method = 'Cash'
;


-- 
select 
	payment_method,
	payment_status,
	transaction_reference
from staging.payments
where  payment_method = 'Cash'
;

-- 
select distinct payment_status
from staging.payments;


--restaurants
select * from staging.restaurants
limit 5 ;

-- null values in restaurants
select 
	count(*) as total_transactions,
	count(*) filter(where restaurant_name is null) as null_restaurant_name,
	count(*) filter(where location_id is null) as null_location_id,
	count(*) filter(where restaurant_type is null) as null_restaurant_type,
	count(*) filter(where average_rating is null) as null_average_rating,
	count(*) filter(where price_for_two_inr is null) as null_price_for_two_inr,
	count(*) filter(where has_online_payment is null) as null_has_online_payment,
	count(*) filter(where is_active is null) as null_is_active,
	count(*) filter(where opened_date is null) as null_opened_date
from staging.restaurants;


   
-- 
select 
	restaurant_id,
	restaurant_name,
	average_rating
from staging.restaurants
where average_rating is null;



-- reviews
select * from staging.reviews
limit 5 ;

-- null values in reviews
select
	count(*) as total_rows,
	count(*) filter(where order_id is null) as null_order_id,
	count(*) filter(where customer_id is null) as null_customer_id,
	count(*) filter(where restaurant_id is null) as null_restaurant_id,
	count(*) filter(where rating is null) as null_rating,
	count(*) filter(where review_text is null) as null_review_text,
	count(*) filter (where review_datetime is null) as null_review_datetime
from staging.reviews ;


-- invalid referance of order_id
select 
	rv.review_id,
	rv.order_id
from staging.reviews rv
left join staging.orders o
	on rv.order_id = o.order_id 
where o.order_id is null;

-- invalid referance of customer_id
select 
	rv.review_id,
	rv.customer_id
from staging.reviews rv
left join staging.customers c
	on rv.customer_id = c.customer_id
where c.customer_id is null;


-- invalid referance of restaurant_id
select 
	rv.review_id,
	rv.restaurant_id
from staging.reviews rv
left join staging.restaurants r
	on rv.restaurant_id = r.restaurant_id
where r.restaurant_id is null;

	















