select * from product1;

-- now()
select added_date , now() as current_dt from product1;


-- current_date()
select current_date as cuurent_d;

-- day_diff
select added_date, current_date as c_date ,(current_date - added_date) as day_diff from product1;

-- extract()--year
select product_name, extract(year from added_date) as t_years from product1;

-- extract() --month
select product_name , extract(month from added_date) as monthh from product1;

-- extract() --day
select product_name , extract(day from added_date) as dayy from product1;


-- age()
select product_name,
		age(current_date,added_date) as aggee
from product1;		

-- to_char()

select product_name,	
	to_char(added_date,'dd-mon-yy') as new_date
from product1;

-- date_part()
select product_name,
	date_part('day',added_date) as dayy
from product1;

-- date_trunc()

select product_name,
	added_date,
	date_trunc('month',added_date) as month_start
from product1;

-- interval--add or substract from dates
select product_name , added_date,
added_date+interval '1 year' as holiday
from product1;

-- current_time()
select current_time as curr_time ;

-- to_date()-- convert string to date
select pg_typeof(to_date('23-2-2012','dd-mm-yy')) as datee ;

-- pg_typeof()
select pg_typeof('23-2-2012') ;


-- to_char

select pg_typeof(to_char(added_date,'dd-mon-yy')) as new_date
from product1;



