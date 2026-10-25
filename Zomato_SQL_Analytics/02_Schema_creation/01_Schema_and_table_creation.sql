-- schema creation
create schema if not exists staging;
create schema if not exists analytics;
create schema if not exists reporting;

-- verify schema

select schema_name
from information_schema.schemata
where schema_name in (
	'staging',
	'analytics',
	'reporting'
) 
order by schema_name;


-- Create the staging tables

create table staging.locations(
	location_id int,
	city varchar(100),
	state varchar(100),
	area varchar (100),
	postal_code varchar(10)
);

create table staging.cuisines(
	cuisine_id int,
    cuisine_name varchar(100)
);

create table staging.customers(
	customer_id int,
	first_name varchar(100),
	last_name varchar(100),
	email varchar(250),
	phone varchar(15),
	location_id int,
	signup_date date,
	customer_segment varchar(50),
	marketing_opt_in boolean
);


create table staging.restaurants (
	restaurant_id int,
	restaurant_name varchar(200),
	location_id int,
	restaurant_type varchar(100),
	average_rating numeric(2,1),
	price_for_two_inr numeric(10,2),
	has_online_payment boolean,
	is_active boolean,
	opened_date date
);

create table staging.restaurant_cuisines(
	restaurant_id int,
	cuisine_id int
);


create table staging.menu_items(
	menu_item_id int,
	restaurant_id int,
	item_name varchar(200),
	cuisine_id int,
	category varchar(100),
	price_inr numeric(10,2),
	is_vegetarian boolean,
	is_available boolean
);



create table staging.orders(
	order_id bigint,
	customer_id int,
	restaurant_id int,
	order_datetime timestamp,
	order_status varchar(30),
	order_type varchar(30),
	discount_inr numeric(10,2),
	special_instructions text ,
	source_channel varchar(50)
);


create table staging.order_items(
	order_item_id  bigint,
	order_id  bigint,  
	menu_item_id int,
	quantity  int,
	unit_price_inr numeric(10,2)
);


create table staging.payments(
	payment_id bigint,
	order_id  bigint,
	payment_method varchar(50),
	payment_status varchar(30),
	payment_datetime timestamp,
	transaction_reference varchar(100)
);

create table staging.deliveries(
	delivery_id bigint,
	order_id bigint,
	estimated_minutes int,
	actual_minutes int,
	delivery_status varchar(30),
	delivery_partner_id int,
	delivered_at timestamp
);


create table staging.reviews(
	review_id bigint,
	order_id bigint,
	customer_id int,
	restaurant_id int,
	rating int,
	review_text text,
	review_datetime timestamp 
);

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'staging'
  AND table_name = 'deliveries'
ORDER BY ordinal_position;

alter table staging.deliveries
alter column delivery_partner_id
type numeric(10,1);


select 
	column_name,
	data_type
from information_schema.columns
where table_schema ='staging'
	and table_name = 'reviews'
order by ordinal_position;	

alter table staging.reviews
alter column rating
type numeric(2,1);

select* from staging.reviews
limit 10;
