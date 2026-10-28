select * from staging.customers 
limit 5 ;

-- Q1.How many unique customers are registered in the platform

select 
	count(distinct c.customer_id) as total_customers
from staging.customers  c;


-- Q2.Customer Distribution by City
-- How are registered customers distributed across cities,
-- and which cities have the largest customer bases


select 
	l.city,
	count(distinct c.customer_id) as total_customers
from staging.customers c
left join staging.locations l
	on c.location_id = l.location_id
group by l.city
order by total_customers  desc;


-- Q3.Customer Segment Distribution
-- How many registered customers belong to each customer segment,
-- and what percentage of all registered customers does each segment represent

with segment_customers as (
	select 
		c.customer_segment as cust_segment,
		count(distinct c.customer_id) as seg_wise_customers
	from staging.customers c
	group by customer_segment 
),
total_customers as(
	select 
		count(distinct c.customer_id) as total_customer
	from staging.customers c 
)
select
	sc.cust_segment,
	sc.seg_wise_customers,
	round(sc.seg_wise_customers*100.0/tc.total_customer,2) as seg_percent
from segment_customers sc
cross join total_customers tc
order by seg_percent desc;


-- Customer Tenure
-- How long have customers been registered on the platform

select * from staging.customers
limit 5 ;

with tenure as (
select 
	c.customer_id,
	age(current_date,c.signup_date) as tenure_age
from staging.customers c
)
select
	case
		when tenure_age < interval '1 year' then 'less_than_1_year'
		when tenure_age < interval'2 years' then '1-2 year'
	   else 'more_than_2_year'
	end as tenure_category,
	count(distinct customer_id ) as total_customers
from tenure	
group by case
		when tenure_age < interval '1 year' then 'less_than_1_year'
		when tenure_age <  interval'2 years' then '1-2 year'
	   else 'more_than_2_year'
	end
order by min (tenure_age)	
;	


-- Q5. Monthly Customer Registrations
-- How many new customers registered each month, 
-- and how does the number of registrations change over time
select * from staging.customers
limit 5 ;	

select 
	to_char(date_trunc('month',c.signup_date),'mon-yyyy') as monthly,
	count(distinct c.customer_id) as total_customers
from staging.customers c
group by date_trunc('month',c.signup_date)
order by date_trunc('month',c.signup_date);


-- Q6. Customer Registration Growth
-- What is the month-over-month percentage change 
-- in new customer registrations?

with reg_month as (
	select 
		date_trunc('month',c.signup_date) as reg_date,
		to_char(date_trunc('month',c.signup_date),'mon-yyyy') as monthly,
		count(distinct c.customer_id) as current_regs
	from staging.customers c
	group by date_trunc('month',c.signup_date) 
)
select 
	 monthly,
	 current_regs,
	lag(current_regs) over(
		order by reg_date
	) as pre_month_regs,

	round((current_regs - lag(current_regs) over(order by reg_date))
	*100.0
	/nullif(lag(current_regs) over(order by reg_date),0),2)
	as regs_change
from reg_month
order by reg_date;

	
------------------------method 2----------------------------- 
with reg_month as (
	select 
		date_trunc('month',c.signup_date) as reg_date,
		to_char(date_trunc('month',c.signup_date),'mon-yyyy') as monthly,
		count(distinct c.customer_id) as current_regs
	from staging.customers c
	group by date_trunc('month',c.signup_date) 
),
previous_month as(
select 
	reg_date,
	monthly,
	current_regs,
	lag(current_regs) over(
		order by reg_date
	) as pre_month_regs	
from reg_month
)
select 
	monthly,
	current_regs,
	pre_month_regs,
	round(
		(current_regs -pre_month_regs)*100.0
		/nullif(pre_month_regs,0)
		,2) as percent_change
from previous_month
order by reg_date;

-- Q7. Customer Activity
-- How many registered customers have placed at least one order, 
-- and how many have never placed an orders

with no_order_customers as(
	select
		count(distinct c.customer_id) as never_order
	from staging.customers c
	left join staging.orders o
		on c.customer_id  = o.customer_id 
	where o.order_id is null
),

atleast_1_orders as (
	select
		count(distinct c.customer_id) as atleast_one
	from staging.customers c
	left join staging.orders o
		on c.customer_id  = o.customer_id 
	where  o.order_id is not null
)
select 
	'never_ordered' as category,
	never_order
from no_order_customers

union all

select 
	'Atleat_once_ordered' as category,
	atleast_one
from atleast_1_orders
;


-- Q8.Repeat Customers
-- How many customers have placed more than one order, 
-- and what percentage of customers who have ordered does this represent? 
with customer_orders as (
select 
	c.customer_id as customer_id ,
	concat(c.first_name,' ',c.last_name) as full_name,
	count(*) as total_orders
from staging.customers c
inner join staging.orders o
	on c.customer_id = o.customer_id
group by c.customer_id , full_name 
) 
select
	count(*) filter (where total_orders >1 )
			as repeat_customers,
	count(*) as customers_who_ordered,
	round(
		count(*) filter(where total_orders >1) *100.0
		/nullif(count(*),0),2
	) as repeat_customer_percentage
from customer_orders 
;


-- Q9. Customer ordering frequency distribution.
-- How many customers placed exactly 1 order, 
-- exactly 2 orders, exactly 3 orders, and so on.

with customer_orders as(
	select 
		c.customer_id as customer_id,
		count(*) as total_orders
	from staging.customers c
	inner join staging.orders o
		on c.customer_id = o.customer_id
	group by c.customer_id  
)
select 
	total_orders,
	count(*) as total_customers
from customer_orders
group by total_orders
order by total_orders;


-- Q10. Average orders per ordering customer
-- What is the average number of orders placed
-- per customer who has ordered at least once?

with customer_orders as(
	select 
		c.customer_id as customer_id,
		count(*) as total_orders
	from staging.customers c
	inner join staging.orders o
		on c.customer_id = o.customer_id
	group by c.customer_id  
)
select
	round(avg(total_orders),2) as avg_orders_per_customers
from customer_orders ;



-- Q11. Identify loyal customers
-- Find the top 10 customers 
-- who placed the highest number of orders.

select 
	c.customer_id as customer_id ,
	concat(c.first_name,' ',c.last_name) as full_name,
	count(*) as total_orders
from staging.customers c
inner join staging.orders o
	on c.customer_id = o.customer_id
group by c.customer_id , full_name 
order by  total_orders desc
limit 10;


-- Q12.Customers with no orders in the last 30 days
-- Identify customers who have ordered previously but have not placed any orders in the last 30 days.

with customer_orders as (
select 
	c.customer_id ,
	concat(c.first_name,' ',c.last_name) as full_name,
	max(o.order_datetime) as last_order_date
from staging.customers c
inner join staging.orders o
	on c.customer_id = o.customer_id 
group by c.customer_id ,full_name
)
select
	customer_id,
	full_name
from customer_orders
where last_order_date < current_date - interval '30 days';


-- Q13 . Customers with the highest spending
-- Find the top 10 customers by 
-- total spending on successfully delivered orders.


select 
	c.customer_id,
	concat(first_name,' ',last_name) as full_name,
	sum(oi.quantity * oi.unit_price_inr) as amount_spend
from staging.customers c
inner join staging.orders o
	on c.customer_id = o.customer_id
inner join staging.order_items oi
	on o.order_id = oi.order_id 
where o.order_status = 'Delivered'
group by c.customer_id,full_name
order by amount_spend desc
limit 10 
;


-- Q14. Customer lifetime spending, including customers who never ordered
-- Calculate each registered customer's total spending on delivered orders, 
-- including customers with zero spending, and rank them from highest to lowest spending.


with spend as (
select 
	c.customer_id as customer_id,
	concat(first_name,' ',last_name) as full_name,
	coalesce(sum(oi.quantity * oi.unit_price_inr),0) as amount_spend
from staging.customers c
left join staging.orders o
	on c.customer_id = o.customer_id
	and o.order_status = 'Delivered'
left join staging.order_items oi
	on o.order_id = oi.order_id 
group by c.customer_id,full_name
)
select
	customer_id,
	full_name,
	amount_spend,
	dense_rank() over(
		order by amount_spend desc
	) as d_rank
from spend ;


-- Q15.Repeat-customer rate by segment
-- For each customer segment, what percentage 
-- of customers have placed more than one order

select * from staging.orders
limit 5 ;
select * from staging.customers
limit 5 ;

with repeat_orders as (
	select 
		c.customer_id,
		count(distinct o.order_id) as total_orders
from staging.customers c
inner join staging.orders o
	on c.customer_id = o.customer_id
group by c.customer_id	
)
select 
	c.customer_segment,
	count(*) as total_customers,
	count(*) filter(where ro.total_orders >1
		) as repeat_customers,
	round(count(*) filter(where ro.total_orders >1)*100.0
	/nullif(count(*),0)
	,2)as repeat_percent
from repeat_orders ro
inner join staging.customers c
	on ro.customer_id = c.customer_id
group by c.customer_segment
order by c.customer_segment ;


-- Q16. Customer purchase recency
-- Identify the customers who placed orders in the 
-- last 30 days and classify them into three groups
-- based on their most recent order.
-- - Recent: Ordered within the last 7 days.
-- - Warm: Ordered 8–30 days ago.
-- - Inactive: Last order was more than 30 days ago.



	


