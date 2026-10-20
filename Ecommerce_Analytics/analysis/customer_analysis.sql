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

