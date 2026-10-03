-- basic query part 1

select * from Books;
select * from Customers;
select * from Orders;


-- 1.Retrieve all books in the "Fiction" genre.
select * from Books 
where Genre = 'Fiction';

-- 2.Find books published after the year 1950.
select * from books
where Published_year >1950;

-- 3.List all customers from Canada.
select * from Customers 
where country = 'Canada';

-- 4.Show orders placed in November 2023.
select * from Orders
where order_date between '2023-11-01' and '2023-11-30';

-- 5.Retrieve the total stock of books available.
select sum(stock) as total_stock
from Books;

-- 6.Find the details of the most expensive book.
select * from Books
where price = (
	select max(price)
	from Books
    )
;

-- 7. Show all customers who ordered more than 1 quantity of a book.

select * from orders
where quantity > 1;

-- 8. Retrieve all orders where the total amount exceeds $20.
select * from orders
where total_amount > 20;

-- 9. List all genres available in the Books table.
select distinct genre from Books;

-- 10. Find the book with the lowest stock.
select * from books
order by stock asc limit 1;

-- 11. Calculate the total revenue generated from all orders.
select sum(total_amount) as total_revenue from orders;


