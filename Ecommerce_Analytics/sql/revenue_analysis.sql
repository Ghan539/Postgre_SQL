-- Total Revenue

select 
	sum(oi.quantity*oi.unit_price) as revenue
from order_items oi
inner join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled');

-- total revenue for each month excluding excluding orders with status Cancelled or Returned

select
	date_trunc('month', o.order_date) as month,
	sum(oi.quantity*oi.unit_price) as monthly_revenue
from order_items oi
left join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled')	
group by date_trunc('month', o.order_date)  
order by date_trunc('month', o.order_date)
;


-- daily revenue
select
	to_char(date_trunc('day', o.order_date),'dd-mon-yy') as daily,
	sum(oi.quantity*oi.unit_price) as daily_revenue
from order_items oi
left join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled')	
group by date_trunc('day', o.order_date)  
order by date_trunc('day', o.order_date)
;


-- extract month
select
	to_char(date_trunc('month', o.order_date),'mon yyyy')  as month,
	sum(oi.quantity*oi.unit_price) as monthly_revenue
from order_items oi
left join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled')	
group by date_trunc('month', o.order_date)  
order by date_trunc('month', o.order_date)
;


-- year wise revenue
select
	to_char(date_trunc('year',o.order_date),'yyyy')  as month,
	sum(oi.quantity*oi.unit_price) as monthly_revenue
from order_items oi
left join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled')	
group by date_trunc('year', o.order_date)  
order by date_trunc('year', o.order_date)
;

-- Top 5 Best-Selling Products
select 
	p.product_name,
	sum(oi.quantity) as total_quantity_sold
from products p
inner join order_items oi
  on p.product_id = oi.product_id
inner join orders o
  on oi.order_id = o.order_id
where  o.status not in ('Returned','Cancelled')
group by  p.product_name
order by total_quantity_sold desc
limit 5
;

-- Top 5 Products by Revenue
select 
	p.category,
	sum(oi.quantity * oi.unit_price) as product_revenue
from products p
inner join order_items oi
  on p.product_id = oi.product_id
inner join orders o
  on oi.order_id = o.order_id
where  o.status not in ('Returned','Cancelled')
group by  p.product_name
order by product_revenue desc
limit 5
;


select distinct category from products;

update products
set category = initcap(trim(category))
where category is not null;


-- Revenue by Product Category
select 
	p.category,
	sum(oi.quantity * oi.unit_price) as category_revenue
from products p
inner join order_items oi
  on p.product_id = oi.product_id
inner join orders o
  on oi.order_id = o.order_id
where  o.status not in ('Returned','Cancelled')
group by  p.category
order by category_revenue desc
;


-- Top 5 Customers by Revenue

select * from customers;
select * from products;
select * from order_items;
select * from orders;

select 
	c.customer_id,
	c.customer_name,
	sum(oi.quantity * oi.unit_price) as total_spend
from  customers c 
inner join orders o
	on c.customer_id = o.customer_id
inner join order_items oi
	on o.order_id = oi.order_id
where o.status not in ('Returned','Cancelled')	
group by c.customer_id, c.customer_name
order by  total_spend desc
limit 5 
; 

-- Customers Who Have Never Placed an Order
select
	c.customer_id,
	c.customer_name
from customers c
left join orders o
  on c.customer_id = o.customer_id
where o.order_id is null
order by c.customer_id ;  

  
--Revenue by City
select * from customers;
select * from products;
select * from order_items;


select 
	c.city ,
	sum(oi.quantity * oi.unit_price) as city_revenue 
from customers c 
inner join orders o
	on c.customer_id = o.customer_id
inner join order_items oi
	on o.order_id = oi.order_id
where o.status not in ('Returned','Cancelled')
group by c.city 
order by city_revenue desc
;


-- Average Order Value

select 
	sum(oi.quantity * oi.unit_price)/count(distinct oi.order_id) as avg_order_value
from order_items oi
inner join orders o
	on oi.order_id = o.order_id
where o.status not in ('Returned','Cancelled')	
;	


-- Repeat Customers
-- customers who have placed more than one order,
-- excluding Cancelled and Returned orders.

select 
	c.customer_id,
	c.customer_name,
	count(distinct oi.order_id) as total_orders
from customers c
inner join orders o
	on c.customer_id = o.customer_id
inner join order_items oi
	on o.order_id = oi.order_id 
where o.status not in ('Returned','Cancelled')
group by c.customer_id,c.customer_name
having count(distinct oi.order_id) > 1
order by total_orders desc
;
	

-- category_revenue
select 
	p.category,
	sum(oi.quantity * oi.unit_price) as category_revenue
from products p
inner join order_items oi
  on p.product_id = oi.product_id
inner join orders o
  on oi.order_id = o.order_id
where  o.status not in ('Returned','Cancelled')
group by  p.category
order by category_revenue desc
;


-- Top 5 Customers by Number of Orders

select 
	c.customer_id,
	c.customer_name,
	count(distinct o.order_id) as total_orders 	
from customers c 
inner join orders o
   on c.customer_id = o.customer_id
where o.status not in  ('Returned','Cancelled')
group by c.customer_id ,c.customer_name
order by total_orders desc
limit 5;

-- Monthly Order Count
select 
	to_char(date_trunc('month',o.order_date),'mon yyyy') as mon_yy,
    count(distinct o.order_id) as monthly_order_count
from order_items oi
inner join orders o
	on oi.order_id = o.order_id
where o.status not in ('Returned','Cancelled')	
group by date_trunc('month',o.order_date)
order by date_trunc('month',o.order_date)
;

-- Find the number of unique customers in each city.

select 
	city,
	count(distinct customer_id) as total_customers
from customers 
group by city
order by city;



-- Customers Who Have Never Placed an Order
select
	count(distinct c.customer_id) as customers_without_orders
from customers c
left join orders o
  on c.customer_id = o.customer_id
where o.order_id is null
;

-- Order Status Analysis
-- Calculate the total number of orders for each status.

select
	status,
	count(distinct order_id) as total_orders
from orders
group by status;


-- Revenue by Order Status
-- Calculate the total revenue for each order status.
select 
	o.status,
	sum(oi.quantity * oi.unit_price) as revenue
from orders o
inner join order_items oi
	on o.order_id = oi.order_id
group by o.status
order by revenue desc ;


-- Highest Revenue Month
select
	to_char(date_trunc('month',o.order_date),'mon yyyy') as monthly,
	sum(oi.quantity * oi.unit_price) as highest_revenue
from orders o
inner join order_items oi
	on o.order_id = oi.order_id
where o.status not in ('Returned','Cancelled')	
group by date_trunc('month',o.order_date)
order by  highest_revenue desc
limit 1
;

-- Highest Revenue Month  by year
select
	to_char(date_trunc('year',o.order_date),'mon yyyy') as monthly,
	sum(oi.quantity * oi.unit_price) as highest_revenue
from orders o
inner join order_items oi
	on o.order_id = oi.order_id
where o.status not in ('Returned','Cancelled')	
group by date_trunc('year',o.order_date)
order by date_trunc('year',o.order_date)
;


-- Best-Selling Product Category
-- Find the product category with the highest total quantity sold,
-- excluding Cancelled and Returned orders.

select * from products;
select * from order_items;
select * from orders;

select 
	p.category,
	sum(oi.quantity) as total_quantity
from products p
inner join order_items oi
	on p.product_id = oi.product_id	
inner join orders o 
	on oi.order_id = o.order_id
where o.status not in ('Returned','Cancelled')	
group by p.category
order by sum(oi.quantity) desc
;


-- Top 5 Products by Average Selling Price
select * from products;

select 
	p.product_name,
	round(avg(oi.unit_price),2) as avg_sell_price
from products p
inner join order_items oi
	on p.product_id = oi.product_id
inner join orders o
	on oi.order_id = o.order_id
where o.status not in ('Returned','Cancelled')		
group by p.product_name ,p.product_id
order by avg(oi.unit_price) desc
limit 5 ;


-- Products Never Sold
-- Find products that have never been included in any order.
select * from products;
select * from order_items;

select 
	p.product_id,
	p.product_name
from products p
left join order_items oi
	on p.product_id = oi.product_id
where oi.order_id is null;


