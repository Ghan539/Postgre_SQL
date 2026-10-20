select * from products;

-- category analysis
select 
	distinct category 
from products;

-- null values
select * from products
where category is null;

-- update null value
update products 
set category = 'Fashion'
where category is null ;





