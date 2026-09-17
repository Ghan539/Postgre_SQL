CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50)
);

INSERT INTO customers (customer_name, city, state)
VALUES
('Amit Sharma', 'Jaipur', 'Rajasthan'),
('Priya Singh', 'Delhi', 'Delhi'),
('Rahul Verma', 'Mumbai', 'Maharashtra'),
('Neha Gupta', 'Pune', 'Maharashtra'),
('Arjun Mehta', 'Bangalore', 'Karnataka'),
('Sneha Joshi', 'Jaipur', 'Rajasthan'),
('Vikas Kumar', 'Chennai', 'Tamil Nadu'),
('Riya Patel', 'Ahmedabad', 'Gujarat'),
('Karan Singh', 'Delhi', 'Delhi'),
('Pooja Sharma', 'Jodhpur', 'Rajasthan');


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10,2)
);
INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 65000),
('Smartphone', 'Electronics', 30000),
('Headphones', 'Electronics', 2500),
('Keyboard', 'Accessories', 1500),
('Mouse', 'Accessories', 800),
('Monitor', 'Electronics', 12000),
('Printer', 'Electronics', 18000),
('Office Chair', 'Furniture', 8500),
('Desk', 'Furniture', 12000),
('USB Cable', 'Accessories', 500),
('Webcam', 'Electronics', 3500),
('Tablet', 'Electronics', 22000);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders (customer_id, order_date, status)
VALUES
(1, '2026-01-05', 'Completed'),
(2, '2026-01-08', 'Completed'),
(3, '2026-01-12', 'Pending'),
(1, '2026-01-15', 'Completed'),
(4, '2026-01-20', 'Cancelled'),
(5, '2026-02-02', 'Completed'),
(6, '2026-02-05', 'Completed'),
(7, '2026-02-10', 'Pending'),
(8, '2026-02-14', 'Completed'),
(2, '2026-02-18', 'Completed'),
(9, '2026-03-01', 'Completed'),
(3, '2026-03-05', 'Completed'),
(10, '2026-03-10', 'Pending'),
(5, '2026-03-15', 'Completed'),
(4, '2026-03-20', 'Completed');


CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 5, 2),
(3, 6, 1),
(4, 4, 2),
(4, 5, 1),
(5, 8, 1),
(6, 1, 1),
(6, 10, 3),
(7, 7, 1),
(7, 3, 1),
(8, 9, 1),
(9, 2, 2),
(9, 11, 1),
(10, 6, 2),
(11, 12, 1),
(11, 5, 2),
(12, 1, 1),
(12, 6, 1),
(13, 3, 2),
(14, 2, 1),
(14, 4, 1),
(15, 8, 2),
(15, 10, 2);




