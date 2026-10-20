
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