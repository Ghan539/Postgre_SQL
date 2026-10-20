-- Total Revenue

select 
	sum(oi.quantity*oi.unit_price) as total_revenue
from order_items oi
inner join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled');


-- total revenue for each month excluding excluding orders with status Cancelled or Returned

select
	to_char(date_trunc('month', o.order_date),'mon yyyy') as month,
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
	to_char(date_trunc('day', o.order_date),'dd-mon-yy') as dayy,
	sum(oi.quantity*oi.unit_price) as daily_revenue
from order_items oi
left join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled')	
group by date_trunc('day', o.order_date)  
order by date_trunc('day', o.order_date)
;


-- monthly revenue as mon-yyyy
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
	to_char(date_trunc('year',o.order_date),'yyyy')  as year,
	sum(oi.quantity*oi.unit_price) as yearly_revenue
from order_items oi
left join orders o
	on oi.order_id = o.order_id 
where o.status not in ('Returned','Cancelled')	
group by date_trunc('year', o.order_date)  
order by date_trunc('year', o.order_date)
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
group by  p.category
order by product_revenue desc
limit 5
;


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


-- revenue by products
select * from customers;
select * from products;
select * from order_items;

select 
	p.product_name,
	sum(oi.quantity * oi.unit_price) as product_revenue
from products p
inner join order_items oi
	on p.product_id = oi.product_id
inner join orders o
	on oi.order_id = o.order_id
where o.status not in ('Returned','Cancelled')
group by p.product_name , p.product_id
order by product_revenue desc
limit 5
;


