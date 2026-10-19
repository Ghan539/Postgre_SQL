
-- import customers.csv

create table customers(
	customer_id int primary key,
	customer_name varchar(100),
	email varchar(100),
	city varchar(50),
	signup_date date
);

select * from customers;

-- import products.csv

create table products(
	product_id int primary key,
	product_name varchar(100),
	category varchar(50),
	price numeric(10,2)
);

select count(*) as total from products;

-- import orders.csv

create table orders(
	order_id int primary key ,
	customer_id int references customers(customer_id),
	order_date date,
	status varchar(50)
);	

select * from orders limit 10;	

-- import order_items.csv

create table order_items(
	order_item_id int primary key,
	order_id int references orders(order_id),
	product_id int references products(product_id),
	quantity int,
	unit_price numeric(10,2)
);

select count(*) as t from order_items;
