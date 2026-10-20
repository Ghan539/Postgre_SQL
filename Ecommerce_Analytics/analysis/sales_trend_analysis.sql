-- Average Order Value

select 
	sum(oi.quantity * oi.unit_price)/count(distinct oi.order_id) as avg_order_value
from order_items oi
inner join orders o
	on oi.order_id = o.order_id
where o.status not in ('Returned','Cancelled')	
;



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

-- Order Status Analysis
-- Calculate the total number of orders for each status.

select
	status,
	count(distinct order_id) as total_orders
from orders
group by status;


