-- customers---> customer_id
-- orders-->order_id
-- order_items-->product_id---->products

select *from customers;
select *from orders;
select *from order_items;
select *from products;

-- q1_inner 
select c.customer_name,
	   o.order_id,
	   o.order_date
from customers c 
inner join orders o
on c.customer_id = o.customer_id;

-- q2
select c.customer_name,
	   c.city,
	   o.order_id,
	   o.status
from customers c 
inner join orders o
on c.customer_id = o.customer_id;

	   
-- q3
select o.order_id,
	   p.product_name,
	   oi.quantity
from orders o
inner join order_items oi
on o.order_id = oi.order_id
inner join products p
on oi.product_id = p.product_id;
	   
	   
-- q4
select c.customer_name,
	   o.order_id,
	   o.status
from customers c
inner join orders o 
on c.customer_id = o.customer_id
where o.status = 'Completed';

-- q5
select c.customer_name,
       c.city,
	   o.order_id
from customers c
inner join orders o
on c.customer_id = o.customer_id
where c.state = 'Rajasthan';


-- q6
select c.customer_name,
	   o.order_id,
	   p.product_name,
	   oi.quantity,
	   p.price
from customers c
inner join orders o
on c.customer_id = o.customer_id
inner join order_items oi
on o.order_id = oi.order_id
inner join products p
on oi.product_id = p.product_id;


-- q7
select c.customer_name,
	   p.product_name,
	   oi.quantity,
	   p.price,
	   oi.quantity * p.price as total_amount
from customers c
inner join orders o
on c.customer_id = o.customer_id
inner join order_items oi
on o.order_id = oi.order_id
inner join  products p
on oi.product_id = p.product_id;



-- q8
select c.customer_name,
	   p.product_name,
	   oi.quantity,
	   oi.quantity*p.price as total_amount
from customers c
inner join orders o
on c.customer_id = o.customer_id
inner join order_items oi
on o.order_id = oi.order_id
inner join products p
on oi.product_id = p.product_id
where oi.quantity*p.price > 20000;



--q9
select c.customer_name,
	   o.order_id
from customers c
left join orders o
on c.customer_id = o.customer_id ;
	   

	   
	   
--q10
select c.customer_name,
	   c.city
from customers c
left join orders o
on c.customer_id = o.customer_id 
where o.order_id is null;
	   
	   
