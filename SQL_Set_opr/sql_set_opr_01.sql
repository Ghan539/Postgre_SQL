DROP TABLE IF EXISTS online_customers;
DROP TABLE IF EXISTS store_customers;
DROP TABLE IF EXISTS wholesale_customers;

CREATE TABLE online_customers (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    category VARCHAR(50)
);

INSERT INTO online_customers (customer_id, customer_name, city, category)
VALUES
(1, 'Amit Sharma', 'Jaipur', 'Electronics'),
(2, 'Priya Singh', 'Delhi', 'Fashion'),
(3, 'Rahul Verma', 'Mumbai', 'Electronics'),
(4, 'Neha Gupta', 'Pune', 'Furniture'),
(5, 'Arjun Mehta', 'Bangalore', 'Electronics'),
(6, 'Sneha Joshi', 'Jaipur', 'Fashion'),
(7, 'Vikas Kumar', 'Chennai', 'Furniture'),
(8, 'Riya Patel', 'Ahmedabad', 'Electronics'),
(9, 'Karan Singh', 'Delhi', 'Fashion'),
(10, 'Pooja Sharma', 'Jodhpur', 'Furniture');

CREATE TABLE store_customers (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    category VARCHAR(50)
);

INSERT INTO store_customers (customer_id, customer_name, city, category)
VALUES
(3, 'Rahul Verma', 'Mumbai', 'Electronics'),
(4, 'Neha Gupta', 'Pune', 'Furniture'),
(6, 'Sneha Joshi', 'Jaipur', 'Fashion'),
(11, 'Rohit Jain', 'Kota', 'Electronics'),
(12, 'Anjali Mehta', 'Udaipur', 'Fashion'),
(13, 'Suresh Reddy', 'Hyderabad', 'Electronics'),
(14, 'Meera Rao', 'Chennai', 'Furniture'),
(15, 'Nitin Patel', 'Ahmedabad', 'Fashion'),
(16, 'Kavita Singh', 'Delhi', 'Electronics'),
(17, 'Deepak Kumar', 'Jaipur', 'Furniture');


CREATE TABLE wholesale_customers (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    category VARCHAR(50)
);

INSERT INTO wholesale_customers (customer_id, customer_name, city, category)
VALUES
(4, 'Neha Gupta', 'Pune', 'Furniture'),
(5, 'Arjun Mehta', 'Bangalore', 'Electronics'),
(8, 'Riya Patel', 'Ahmedabad', 'Electronics'),
(11, 'Rohit Jain', 'Kota', 'Electronics'),
(18, 'Manish Agarwal', 'Jaipur', 'Electronics'),
(19, 'Rajesh Gupta', 'Jodhpur', 'Furniture'),
(20, 'Sunita Verma', 'Mumbai', 'Fashion'),
(21, 'Akash Sharma', 'Delhi', 'Electronics'),
(22, 'Nisha Patel', 'Surat', 'Fashion'),
(23, 'Varun Mehta', 'Pune', 'Electronics');


-- q1
select customer_name from online_customers
union 
select customer_name from store_customers;


-- q2
select customer_name from online_customers
union all 
select customer_name from store_customers;

-- q3
select customer_name from online_customers
intersect
select customer_name from store_customers;


-- q4
select customer_name from online_customers
except
select customer_name from store_customers;


-- q5
select customer_name from store_customers
except
select customer_name from online_customers;

-- q6
select customer_name , city from online_customers
union
select customer_name , city from store_customers ;

-- q7
select customer_name , city from online_customers
intersect
select customer_name , city from store_customers ;

-- q8
select customer_name , city , category from online_customers
except
select customer_name , city , category from store_customers;

-- q9
select customer_name , city from online_customers
union
select customer_name , city from store_customers
union
select customer_name , city from wholesale_customers;


-- q10
select customer_name , city from online_customers
where city = 'Jaipur'
union
select customer_name , city from store_customers
where city = 'Jaipur';

-- q12
select customer_name ,category  from online_customers
where category = 'Electronics'
intersect
select customer_name , category from store_customers
where category = 'Electronics';

-- q13
select customer_name,city from online_customers
where city ='Delhi'
except
select customer_name , city  from store_customers
where city ='Delhi';


-- q14
select customer_name , category from online_customers
where category in ('Electronics','Fashion')
union
select customer_name , category from store_customers
where category in ('Electronics','Fashion')
union
select customer_name , category from wholesale_customers
where category in ('Electronics','Fashion');

-- q15
select customer_name , category from online_customers
intersect
select customer_name , category from store_customers
except
select customer_name , category from wholesale_customers;

-- q16
select customer_name
from (
	select customer_name from online_customers
	union all
	select customer_name from store_customers
	union all
	select customer_name from wholesale_customers
	) as customer_name
group by customer_name
having count(*) = 1;


-- q17
select customer_name
from (
	select customer_name from online_customers
	union all
	select customer_name from store_customers
	union all
	select customer_name from wholesale_customers
	) as customer_name
group by customer_name
having count(*) >=2;


-- q18
select customer_name 
from(
	select customer_name  from online_customers
	union all
	select customer_name  from store_customers
) as customer_name
group by customer_name
having count(*) = 1;


-- q19
select customer_id , customer_name  from online_customers
intersect
select  customer_id , customer_name from store_customers
intersect
select  customer_id , customer_name from wholesale_customers;


-- q20
select customer_id , customer_name , 'online' as source  from online_customers
union all
select  customer_id , customer_name , 'store' as source from store_customers
union all
select  customer_id , customer_name , 'wholesale' as source from wholesale_customers;

