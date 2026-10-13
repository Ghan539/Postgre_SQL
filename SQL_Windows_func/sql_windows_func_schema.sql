
CREATE TABLE sales_data (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    employee_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    product VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    discount NUMERIC(5,2) DEFAULT 0,
    region VARCHAR(50) NOT NULL
);


INSERT INTO sales_data
(sale_date, employee_id, employee_name, department, customer_id, customer_name,
 product, category, quantity, unit_price, discount, region)
VALUES

('2025-01-05', 101, 'Amit Sharma', 'Sales', 1001, 'Rahul Mehta', 'Laptop', 'Electronics', 1, 75000, 5, 'North'),
('2025-01-08', 102, 'Neha Patel', 'Sales', 1002, 'Priya Singh', 'Phone', 'Electronics', 2, 45000, 3, 'West'),
('2025-01-12', 103, 'Rahul Verma', 'Sales', 1003, 'Karan Joshi', 'Headphones', 'Accessories', 3, 1500, 10, 'North'),
('2025-01-15', 101, 'Amit Sharma', 'Sales', 1004, 'Anjali Rao', 'Laptop', 'Electronics', 1, 75000, 8, 'South'),
('2025-01-18', 104, 'Priya Mehta', 'Sales', 1005, 'Vikas Kumar', 'Monitor', 'Electronics', 2, 12000, 5, 'West'),

('2025-02-02', 102, 'Neha Patel', 'Sales', 1001, 'Rahul Mehta', 'Phone', 'Electronics', 1, 45000, 2, 'West'),
('2025-02-05', 103, 'Rahul Verma', 'Sales', 1006, 'Riya Gupta', 'Keyboard', 'Accessories', 4, 1250, 5, 'North'),
('2025-02-09', 101, 'Amit Sharma', 'Sales', 1007, 'Suresh Reddy', 'Laptop', 'Electronics', 2, 75000, 10, 'South'),
('2025-02-14', 104, 'Priya Mehta', 'Sales', 1008, 'Pooja Sharma', 'Printer', 'Electronics', 1, 9500, 4, 'East'),
('2025-02-20', 105, 'Vikas Kumar', 'Sales', 1009, 'Arjun Mehta', 'Office Chair', 'Furniture', 3, 5500, 5, 'West'),

('2025-03-03', 101, 'Amit Sharma', 'Sales', 1002, 'Priya Singh', 'Monitor', 'Electronics', 1, 12000, 3, 'South'),
('2025-03-07', 102, 'Neha Patel', 'Sales', 1003, 'Karan Joshi', 'Phone', 'Electronics', 2, 45000, 5, 'West'),
('2025-03-11', 103, 'Rahul Verma', 'Sales', 1004, 'Anjali Rao', 'Mouse', 'Accessories', 5, 750, 0, 'North'),
('2025-03-15', 104, 'Priya Mehta', 'Sales', 1005, 'Vikas Kumar', 'Laptop', 'Electronics', 1, 75000, 7, 'East'),
('2025-03-22', 105, 'Vikas Kumar', 'Sales', 1006, 'Riya Gupta', 'Desk', 'Furniture', 2, 8000, 10, 'West'),

('2025-04-02', 101, 'Amit Sharma', 'Sales', 1007, 'Suresh Reddy', 'Phone', 'Electronics', 1, 45000, 4, 'South'),
('2025-04-06', 102, 'Neha Patel', 'Sales', 1008, 'Pooja Sharma', 'Headphones', 'Accessories', 4, 1500, 5, 'West'),
('2025-04-10', 103, 'Rahul Verma', 'Sales', 1009, 'Arjun Mehta', 'Monitor', 'Electronics', 2, 12000, 8, 'North'),
('2025-04-17', 104, 'Priya Mehta', 'Sales', 1001, 'Rahul Mehta', 'Laptop', 'Electronics', 1, 75000, 5, 'East'),
('2025-04-25', 105, 'Vikas Kumar', 'Sales', 1002, 'Priya Singh', 'Printer', 'Electronics', 2, 9500, 3, 'West'),

('2025-05-03', 101, 'Amit Sharma', 'Sales', 1003, 'Karan Joshi', 'Laptop', 'Electronics', 1, 75000, 6, 'South'),
('2025-05-08', 102, 'Neha Patel', 'Sales', 1004, 'Anjali Rao', 'Phone', 'Electronics', 3, 45000, 5, 'West'),
('2025-05-12', 103, 'Rahul Verma', 'Sales', 1005, 'Vikas Kumar', 'Keyboard', 'Accessories', 6, 1250, 4, 'North'),
('2025-05-18', 104, 'Priya Mehta', 'Sales', 1006, 'Riya Gupta', 'Office Chair', 'Furniture', 2, 5500, 7, 'East'),
('2025-05-27', 105, 'Vikas Kumar', 'Sales', 1007, 'Suresh Reddy', 'Monitor', 'Electronics', 2, 12000, 5, 'West'),

('2025-06-04', 101, 'Amit Sharma', 'Sales', 1008, 'Pooja Sharma', 'Phone', 'Electronics', 1, 45000, 3, 'South'),
('2025-06-09', 102, 'Neha Patel', 'Sales', 1009, 'Arjun Mehta', 'Laptop', 'Electronics', 1, 75000, 10, 'West'),
('2025-06-14', 103, 'Rahul Verma', 'Sales', 1001, 'Rahul Mehta', 'Mouse', 'Accessories', 8, 750, 0, 'North'),
('2025-06-20', 104, 'Priya Mehta', 'Sales', 1002, 'Priya Singh', 'Desk', 'Furniture', 1, 8000, 5, 'East'),
('2025-06-28', 105, 'Vikas Kumar', 'Sales', 1003, 'Karan Joshi', 'Printer', 'Electronics', 2, 9500, 4, 'West');

select * from sales_data;
