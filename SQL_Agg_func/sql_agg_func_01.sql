drop table product1;

CREATE TABLE product1 (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10, 2),
    quantity INT,
    added_date DATE,
    discount_rate NUMERIC(5, 2)
);

INSERT INTO product1
(product_name, category, price, quantity, added_date, discount_rate)
VALUES
('Laptop', 'Electronics', 75000.50, 10, '2024-01-15', 10.00),
('Smartphone', 'Electronics', 45000.99, 25, '2024-02-20', 5.00),
('Headphones', 'Accessories', 1500.75, 50, '2024-03-05', 15.00),
('Office Chair', 'Furniture', 5500.00, 20, '2023-12-01', 20.00),
('Desk', 'Furniture', 8000.00, 15, '2023-11-20', 12.00),
('Monitor', 'Electronics', 12000.00, 8, '2024-01-10', 8.00),
('Printer', 'Electronics', 9500.50, 5, '2024-02-01', 7.50),
('Mouse', 'Accessories', 750.00, 40, '2024-03-18', 10.00),
('Keyboard', 'Accessories', 1250.00, 30, '2024-03-18', 10.00),
('Tablet', 'Electronics', 30000.00, 12, '2024-02-28', 5.00);

select * from product1;


-- aggregate_function

--q1
select count(product_name) as total_prod from product1;

-- q2
select sum(quantity) as t_quantity from product1;

-- q3
select avg(price) as avg_price from product1;

-- q4
select min(price) as mx_price from product1;

-- q5
select sum(price*quantity) as total_revenue from product1;


-- q6
select sum(quantity) as t_quantity from product1
where category = 'Electronics';

-- q8
select avg(quantity) as avg_of_electronic  from product1
where category = 'Electronics';

-- q9
select sum(price * quantity) as elect_revenue from product1
where category = 'Electronics';

-- q10
select avg(price) as avg_of_accessories  from product1
where category = 'Accessories';


-- q11
select max(price) as max_of_furniture  from product1
where category = 'Furniture';

-- q11
select sum(quantity) as t_quantity_furn from product1
where category = 'Furniture';

-- q12
select avg(price) as avg_price_furn from product1
where category = 'Furniture';

select * from product1;


-- q14
select category,sum(price*quantity) as total_inventory_value from product1
group by category
order by total_inventory_value desc;


-- q15
select category,sum(price*quantity) as total_inventory_value from product1
group by category
having sum(price*quantity) > 200000
order by total_inventory_value desc;

-- q16
select category, avg(price) as avg_categ from product1
group by category
having avg(price)>5000
order by avg_categ desc;

-- q18
select category , sum(quantity) as total_quantity from product1
group by category 
order by total_quantity desc
limit 1;

-- q19
select category , sum(price*quantity) as total_revenue from product1
group by category 
order by total_revenue desc
limit 2;

-- q20
select category , avg(price*quantity) as avg_val_in from product1
group by category
order by avg_val_in desc 
limit 1;


