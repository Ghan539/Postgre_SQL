select * from product1;

--upper_case
select upper(category) as upp_catergory from product1;

--lower_case
select upper(product_name) as upp_catergory from product1;

-- join product_name and category
select concat(product_name,'-',category) as con_pc from product1;

-- extract first 5 characters from product_name
select substring(product_name,1,5) as short_name from product1;

-- count length
select product_name, length(product_name) as str_len from product1;

-- remove the leading and trailing spaces
select product_name , length(product_name),length(trim(product_name)) as trimed from product1;

-- replace
select replace(product_name,'Smartphone','mobile_phone')  as updated from product1;


-- left/right 
select left(product_name,3) as first_3 from product1;
