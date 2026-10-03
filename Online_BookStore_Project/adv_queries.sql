-- advanced queries

-- 1. Retrieve the total number of books sold for each genre.

select b.genre,sum(o.quantity) as total_books
from Books b
join orders o 
	on b.book_id = o.book_id
group by b.genre;


-- 2. Find the average price of books in the "Fantasy" genre.
select genre , avg(price) as avg_price 
from books
group by genre
having genre = 'Fantasy';


-- 3. List customers who have placed at least 2 orders.
select c.name,
	count(o.order_id) as total_orders
from Customers c
join orders o 
on c.customer_id = o.customer_id
group by c.customer_id , c.name
having count (o.order_id) >= 2 ;

-- 4. Find the most frequently ordered book.
select b.title,
	   sum(o.quantity) as freq
from books b
join orders o 
on b.book_id = o.book_id
group by  b.book_id , b.title
order by freq desc 
limit 1;


-- 5. Find the top 3 most expensive books of the "Fantasy" genre.

select 
	title ,
	price,
	genre
from books 
where genre = 'Fantasy'
order by price desc limit 3;
	   
-- 6.Retrieve the total quantity of books sold by each author.
