--pk_  customer_id 
select * from staging.customers limit 5;

alter table staging.customers
add constraint pk_customer_id
primary key (customer_id);

--pk_  order_id 
select * from staging.orders limit 5;

alter table staging.orders
add constraint pk_order_id
primary key (order_id);


--pk_  delivery_id 
select * from staging.deliveries limit 5;

alter table staging.deliveries
add constraint pk_delivery_id
primary key (delivery_id);


--pk_  location_id
select * from staging.locations limit 5;

alter table staging.locations
add constraint pk_location_id
primary key (location_id);


--pk_  menu_item_id
select * from staging.menu_items limit 5;

alter table staging.menu_items
add constraint pk_menu_item_id
primary key (menu_item_id);


--pk_  order_item_id
select * from staging.order_items limit 5;

alter table staging.order_items
add constraint pk_order_item_id
primary key (order_item_id);


--pk_  cuisine_id
select * from staging.cuisines limit 5;

alter table staging.cuisines
add constraint pk_cuisine_id
primary key (cuisine_id);


--pk_  payment_id
select * from staging.payments limit 5;

alter table staging.payments
add constraint pk_payment_id
primary key (payment_id);


--pk_  restaurant_id
select * from staging.restaurants limit 5;

alter table staging.restaurants
add constraint pk_restaurant_id
primary key (restaurant_id);


--pk_  review_id
select * from staging.reviews limit 5;

alter table staging.reviews
add constraint pk_review_id
primary key (review_id);



--pk_ (restaurant_id,cuisine_id)
select * from staging.restaurant_cuisines limit 5;

alter table staging.restaurant_cuisines
add constraint pk_restaurant_id_cuisine_id
primary key (restaurant_id,cuisine_id);


-- ---------------------fk-----------------------------------------------

-- customers
-- fk_customers_location_id
alter table staging.customers
add constraint fk_customers_location_id
foreign key (location_id)
references staging.locations(location_id);

-- orders
-- fk_orders_customer_id
alter table staging.orders
add constraint fk_orders_customer_id
foreign key(customer_id)
references staging.customers(customer_id);

-- orders
-- fk_orders_restaurant_id
alter table staging.orders
add constraint fk_orders_restaurant_id
foreign key(restaurant_id)
references staging.restaurants(restaurant_id);


-- deliveries
-- fk_deliveries_order_id
alter table staging.deliveries
add constraint fk_deliveries_order_id
foreign key(order_id)
references staging.orders(order_id);

-- menu_items
-- fk_menu_items_restaurant_id
alter table staging.menu_items
add constraint fk_menu_items_restaurant_id
foreign key (restaurant_id)
references staging.restaurants(restaurant_id);


-- menu_items
-- fk_menu_items_cuisine_id
alter table staging.menu_items
add constraint fk_menu_items_cuisine_id
foreign key (cuisine_id)
references staging.cuisines(cuisine_id);


-- order_items
-- fk_order_items_order_id
alter table staging.order_items
add constraint fk_order_items_order_id
foreign key (order_id)
references staging.orders(order_id);

-- order_items
-- fk_order_items_menu_item_id
alter table staging.order_items
add constraint fk_order_items_menu_item_id
foreign key (menu_item_id)
references staging.menu_items(menu_item_id);


-- payments
-- fk_payments_order_id
alter table staging.payments
add constraint fk_payments_order_id
foreign key (order_id)
references staging.orders(order_id);

-- restaurants
-- fk_restaurants_location_id
alter table staging.restaurants
add constraint fk_restaurants_location_id
foreign key (location_id)
references staging.locations(location_id);


-- reviews
-- fk_reviews_order_id
alter table staging.reviews
add constraint fk_reviews_order_id
foreign key (order_id)
references staging.orders(order_id);

-- reviews
-- fk_reviews_customer_id
alter table staging.reviews
add constraint fk_reviews_customer_id
foreign key (customer_id)
references staging.customers(customer_id);

-- reviews
-- fk_reviews_restaurant_id
alter table staging.reviews
add constraint fk_reviews_restaurant_id
foreign key (restaurant_id)
references staging.restaurants(restaurant_id);

-- restaurant_cuisines
-- fk_restaurant_cuisines_id
alter table staging.restaurant_cuisines
add constraint fk_restaurant_cuisines_restaurant_id
foreign key (restaurant_id)
references staging.restaurants(restaurant_id);

-- restaurant_cuisines
-- fk_restaurant_cuisines_id
alter table staging.restaurant_cuisines
add constraint fk_restaurant_cuisines_cuisine_id
foreign key (cuisine_id)
references staging.cuisines(cuisine_id);




































