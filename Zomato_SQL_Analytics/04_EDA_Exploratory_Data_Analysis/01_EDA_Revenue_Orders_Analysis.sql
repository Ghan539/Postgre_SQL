-- EDA — Revenue & Orders
select * from staging.orders
limit 5 ;

-- total_orders
select 
	count(distinct order_id) as total_orders
from staging.orders;

-- Order Status Distribution
select 
	order_status,
	count(distinct order_id) as total_orders
from staging.orders
group by order_status
order by total_orders desc;

-- orders per source_channel
select 
	source_channel,
	count(distinct order_id) as total_orders
from staging.orders
group by source_channel
order by total_orders desc;


-- total_orders per month
select 
	to_char(date_trunc('month', order_datetime),'mon-yyyy') as month_wise_orders,
	count(distinct order_id) as total_orders
from staging.orders
group by date_trunc('month' , order_datetime)
order by date_trunc('month' , order_datetime) asc;

-- total_order per year
select 
	to_char(date_trunc('year', order_datetime),'yyyy') as month_wise_orders,
	count(distinct order_id) as total_orders
from staging.orders
group by date_trunc('year' , order_datetime)
order by date_trunc('year' , order_datetime) asc;


-- total_discount
select
	sum(coalesce(discount_inr,0)) as total_discount
from staging.orders	;

-- avg_discount_per order
select
	avg(coalesce(discount_inr,0)) as avg_discount_per_order	
from staging.orders	;


-- Order Status Percentage
select 
	order_status,
	round(count(distinct order_id)*100.0/
		(select count(distinct order_id) from staging.orders
	  ),2)  as order_percent
from staging.orders
group by order_status
order by  order_percent desc ;



-- order_percent per source channel
select
	source_channel,
	round(count(distinct order_id)*100.0/
		(select count(distinct order_id) from staging.orders
		),2) as o_percent_source_channel
from staging.orders
group by source_channel
order by o_percent_source_channel desc ;

--Peak Ordering Hours
-- At which hour of the day are the most orders placed
select 
	extract ('hour' from order_datetime) as peak_hrs,
	count(distinct order_id ) as total_orders
from staging.orders
group by extract ('hour' from order_datetime)
order by total_orders desc;


-- in AM/PM peak hours
select 
	to_char(order_datetime,'FMHH12 AM') as peak_hrs,
	count(distinct order_id ) as total_orders
from staging.orders
group by extract ('hour' from order_datetime),
		 to_char(order_datetime,'FMHH12 AM')
order by total_orders desc;


-- no of orders as per time 
-- in AM/PM peak hours
select 
	to_char(order_datetime,'FMHH12 AM') as peak_hrs,
	count(distinct order_id ) as total_orders
from staging.orders
group by extract ('hour' from order_datetime),
		 to_char(order_datetime,'FMHH12 AM')
order by extract ('hour' from order_datetime);


-- Weekday vs. Weekend Orders
-- Weekday: Monday to Friday.
-- Weekend: Saturday and Sunday.

select 
	extract(dow from order_datetime) as day_number,
	count(distinct order_id) as total_orders
from staging.orders
group by extract(dow from order_datetime)
order by day_number;

-- group by weekday and weekend

select 
	case
		when extract(dow from order_datetime) in (0,6) then 'weekend'
		else 'weekday'
	end as day_type,
	count(distinct order_id) as total_orders
from staging.orders
group by day_type
order  by day_type;


-- EDA Question 11 — Revenue Analysis
-- Which top 10 restaurants generated the highest total revenue from food items ordered?

select * from staging.restaurants
limit 5;
select * from staging.orders
limit 5;
select * from staging.order_items
limit 5;

select 
	r.restaurant_id,
	r.restaurant_name,
	sum(oi.quantity * oi.unit_price_inr) as total_revenue
from staging.restaurants r
inner join staging.orders o
	on r.restaurant_id = o.restaurant_id
inner join staging.order_items oi
	on o.order_id = oi.order_id 
where o.order_status = 'Delivered'		
group by r.restaurant_name , r.restaurant_id
order by total_revenue desc
limit 10 ;


-- Actual total revenue of top 10 restaurants - discount

with restaurant_sales as (
	select 
		r.restaurant_id,
		r.restaurant_name,
		sum(oi.quantity * oi.unit_price_inr) as total_sales
	from staging.restaurants r
	inner join staging.orders o
		on r.restaurant_id = o.restaurant_id
	inner join staging.order_items oi
		on o.order_id = oi.order_id 
	where o.order_status = 'Delivered'		
	group by r.restaurant_name , r.restaurant_id
),
restaurant_discounts as (
	select 
		restaurant_id,
		sum(coalesce(discount_inr,0)) as total_discount
	from staging.orders
	where order_status = 'Delivered'
	group by restaurant_id
)
select 
	rs.restaurant_id,
	rs.restaurant_name,
	rs.total_sales,
	coalesce(rd.total_discount,0) as total_discount,
	rs.total_sales - coalesce(rd.total_discount,0) 
		as actual_total_revenue
from restaurant_sales rs
left join restaurant_discounts rd
	on rs.restaurant_id = rd.restaurant_id
order by actual_total_revenue desc
limit 10 ;


-- Monthly Revenue Trends
select * from staging.orders
limit 5;
select * from staging.order_items
limit 5;

select 
	to_char(date_trunc('month' ,o.order_datetime),'mon-yyyy') as mon_year,
	sum(coalesce(oi.quantity*oi.unit_price_inr,0)) as monthly_total_revenue
from staging.orders o
inner join staging.order_items oi
	on o.order_id = oi.order_id
where o.order_status = 'Delivered'	
group by date_trunc('month',o.order_datetime),
		date_trunc('year',o.order_datetime)
order by  date_trunc('month',o.order_datetime),
		date_trunc('year',o.order_datetime);


-- EDA Question 13 — Average Order Value (AOV)
-- Calculate the average order value for delivered orders in your dataset.

-- Average Order Value (AOV) means the average amount of money spent on each order.
select * from staging.orders
limit 5;
select * from staging.order_items
limit 5;


select 
	round(
		sum(coalesce(oi.quantity * oi.unit_price_inr,0))*1.0
		/ count(distinct o.order_id),2) as AOV
from staging.order_items oi
inner join staging.orders o 
	on oi.order_id = o.order_id
where o.order_status = 'Delivered' ;


-- EDA Question 14 — Revenue by Source Channel
select 
	o.source_channel,
	sum(coalesce(oi.quantity * oi.unit_price_inr,0)) as total_revenue
from staging.order_items oi
inner join staging.orders o 
	on oi.order_id = o.order_id	
where o.order_status = 'Delivered' 
group by o.source_channel
order by total_revenue desc
limit 1;


-- Question 15 — Revenue by Order Type
-- Which order type generates the highest total revenue from delivered orders?
select * from staging.orders
limit 5;
select * from staging.order_items
limit 5;

select
	o.order_type,
	sum(coalesce(oi.quantity * oi.unit_price_inr,0)) as total_revenue
from staging.orders o
inner join staging.order_items oi
	on o.order_id = oi.order_id
where o.order_status = 'Delivered'
group by o.order_type
order by total_revenue desc;


-- Question 16 — Order Value Distribution
with order_values as(
select 
	o.order_id,
	sum(coalesce(oi.quantity * oi.unit_price_inr,0)) as order_value
from staging.orders o
inner join staging.order_items oi
on o.order_id = oi.order_id
where o.order_status = 'Delivered'	
group by o.order_id
)
select 	
	case
		when order_value <= 300 then '0-300'
		when order_value <= 600 then '301-600'
		when order_value <= 1000  then '601-1000'
	else 'above 1000'
end as 	order_value_distribution,
count(*) as total_orders
from order_values
group by
	case
		when order_value <= 300 then '0-300'
		when order_value <= 600 then '301-600'
		when order_value <= 1000  then '601-1000'
	   else 'above 1000'
	end 
order by min(order_value);


-- Question 17 — Month-over-Month Revenue Growth
select * from staging.orders
limit 5 ;

select * from staging.order_items
limit 5 ;


with curr_monthly_revenue as (
	select 
		date_trunc('month',o.order_datetime) as month_date,
		to_char(date_trunc('month',o.order_datetime),'mon-yyyy') as monthly,
		sum(oi.quantity*oi.unit_price_inr) as current_revenue
		from staging.order_items oi
		inner join staging.orders o
			on oi.order_id = o.order_id
		where o.order_status = 'Delivered'	
		group by date_trunc('month',o.order_datetime)
)
select 
	monthly,
	current_revenue,
	lag(current_revenue) over(
		order by month_date
		) as previous_revenue,
		
	round(coalesce((current_revenue - lag(current_revenue) over(
		order by month_date))
	* (100.0)/nullif(lag(current_revenue) over(
		order by month_date),0
		)
		,0),2)
from curr_monthly_revenue
order by month_date ;


-- Question 18 — Running Total Revenue
-- Calculate the cumulative revenue for delivered orders month by month, 
-- from the earliest month to the latest month.

with curr_monthly_revenue as (
	select 
		date_trunc('month',o.order_datetime) as month_date,
		to_char(date_trunc('month',o.order_datetime),'mon-yyyy') as monthly,
		sum(oi.quantity*oi.unit_price_inr) as current_revenue
		from staging.order_items oi
		inner join staging.orders o
			on oi.order_id = o.order_id
		where o.order_status = 'Delivered'	
		group by date_trunc('month',o.order_datetime)
)
select 
	monthly,
	current_revenue,
	sum(current_revenue) over(
		order by month_date
		) as monthly_running_total
from curr_monthly_revenue
order by month_date ;


-- Question 20 — Monthly Revenue Contribution
-- What percentage of total delivered-order revenue does each month contribute

with total_revenue as(
	select sum(coalesce(oi.quantity*oi.unit_price_inr,0)) as t_revenue
	from staging.orders o
	inner join staging.order_items oi
		on o.order_id = oi.order_id
	where o.order_status = 'Delivered'
)
select 
	to_char(date_trunc('month', o.order_datetime),'mon-yyyy') as monthly,
	round(sum(coalesce(oi.quantity*oi.unit_price_inr,0))
	/(select t_revenue from total_revenue)
	*100.0,2) as monthly_percent_contri
from staging.orders o	
inner join staging.order_items oi
	on o.order_id = oi.order_id
where o.order_status = 'Delivered'
group by date_trunc('month', o.order_datetime)
order by date_trunc('month', o.order_datetime);

	
-- For each month, calculate the percentage change in the number of
-- delivered orders compared with the previous month.

with no_of_orders as (
	select 
		date_trunc('month',o.order_datetime) as month_date,
		to_char(date_trunc('month',o.order_datetime),'mon-yyyy') as monthly,
		count(distinct o.order_id) as current_orders
	from staging.order_items oi
	inner join staging.orders o
		on oi.order_id = o.order_id 
	where o.order_status = 'Delivered'
	group by date_trunc('month',o.order_datetime)
)	
select 
	monthly,
	current_orders,
	lag(current_orders) over(order by month_date) as previous_month,
	
	round(((current_orders - lag(current_orders) over(order by month_date))*1.0
	/nullif(lag(current_orders) over(order by month_date),0)
	)*100.0,2) as per_change
from no_of_orders
order by month_date;
	

-- EDA Question 22 — Highest and Lowest Order Months
-- Question: Which month had the highest number of delivered orders, 
-- and which month had the lowest? Return the month and its order count for each.

with monthly_orders as (
	select 
		date_trunc('month', o.order_datetime) as month_date,
		to_char(date_trunc('month', o.order_datetime),'mon-yyyy') as monthly,
		count(distinct o.order_id) as total_orders
		from staging.order_items oi
	inner join staging.orders o
		on oi.order_id = o.order_id 
	where o.order_status = 'Delivered'
	group by date_trunc('month',o.order_datetime)
)
select
	monthly,
	total_orders,
	'highest' as order_category
from monthly_orders
where total_orders = (
select max(total_orders) from monthly_orders) 
union all
select
	monthly,
	total_orders,
	'lowest' as order_category
from monthly_orders
where total_orders = (
select min(total_orders) from monthly_orders)
;

	

-- EDA Question 23 — Restaurant Performance
-- Question: Which 10 restaurants have the highest number of delivered orders?

select * from staging.restaurants
limit 5 ;
select * from staging.order_items
limit 5 ;
select * from staging.orders 
limit 5;


select
	r.restaurant_name,
	count(distinct oi.order_id) as total_orders
from staging.restaurants r
inner join staging.orders o
	on r.restaurant_id = o.restaurant_id
inner join staging.order_items oi
	on o.order_id = oi.order_id
where o.order_status = 'Delivered'
group by r.restaurant_name , r.restaurant_id
order by total_orders desc
limit 10 ;


-- 
-- EDA Question 24 — Customer Analysis
-- Question: Which 10 customers have placed the highest number of orders,
-- regardless of order status?

select * from staging.customers
limit 5 ;
select * from staging.orders
limit 5 ;

select 
	c.customer_id,
	concat(first_name,' ',last_name) as customer_name,
	count(distinct order_id) as total_orders
from staging.customers c
inner join staging.orders o
	on c.customer_id = o.customer_id
group by concat(first_name,' ',last_name) , c.customer_id
order by total_orders desc
limit 10 ;


-- 
-- EDA Question 23 — Revenue by Order Status
-- Question: How much total item revenue is 
-- associated with each order status (Delivered, Cancelled, Pending
select * from staging.orders
limit 5 ;

select 
	o.order_status,
	count(distinct o.order_id) as total_orders,
	sum(coalesce(oi.quantity * oi.unit_price_inr,0)) as total_revenue
from staging.orders o
left join staging.order_items oi
	on o.order_id = oi.order_id 
group by o.order_status
order by total_revenue desc;


-- EDA Question 24 — Cancellation Rate
-- Question: What percentage of all orders were cancelled

select 
	count(distinct o.order_id) as total_orders,
	count(distinct o.order_id) filter(where o.order_status = 'Cancelled') as Cancelled_orders,

	round((count(distinct o.order_id) filter(where o.order_status = 'Cancelled')*100.0)
	/
	nullif(count(distinct o.order_id),0),2) as cancellation_rate_pct
from staging.orders o
;



-- EDA Question 26 — Discount Impact
-- What is the total discount amount on delivered orders, and
-- what percentage of their gross item revenue does that discount represent?

select * from staging.orders
limit 5 ;


with total_discounts as (
	select 
		sum(coalesce(o.discount_inr,0)) as total_discount
from staging.orders o
where o.order_status = 'Delivered' 
),
gross_total_revenue as(
	select 
		sum(oi.quantity * oi.unit_price_inr) as total_revenue
from staging.orders o
left join staging.order_items oi
	on o.order_id = oi.order_id
where o.order_status = 'Delivered' 
)
select 
	total_discount,
	total_revenue,
	round((total_discount*1.0/nullif(total_revenue,0))*100.0
	,2) as gross_disocunt_percent
from total_discounts
cross join gross_total_revenue
;



-- 
-- EDA Question 27 — Daily Order Trends
-- Question: Which dates had the highest and lowest numbers of orders

select * from staging.orders
limit 5 ;

with daily_orders as(
	select 
		o.order_datetime::date as order_date,
		count(distinct o.order_id) as total_orders
	from staging.orders o
	group by o.order_datetime::date
	order by o.order_datetime::date
) 
select 
	order_date,
	total_orders,
	'highest' as category
from daily_orders	
where total_orders = (
	select max(total_orders) from daily_orders
)
union all
select 
	order_date,
	total_orders,
	'lowest' as category
from daily_orders	
where total_orders = (
	select min(total_orders) from daily_orders
);


-- EDA Question 28 — Revenue by Customer Segment
-- Which customer segments generate the highest total revenue from delivered orders?

select 
	c.customer_segment,
	sum(oi.quantity * oi.unit_price_inr) as total_revenue,
	count(distinct c.customer_id) as new_customers
from staging.customers c
inner join staging.orders o 	
	on c.customer_id = o.customer_id
inner join staging.order_items oi
	on o.order_id = oi.order_id
where o.order_status = 'Delivered'
group by c.customer_segment
order by total_revenue desc ;




