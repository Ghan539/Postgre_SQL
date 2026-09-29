create table Books (
	Book_ID serial primary key,
	Title varchar (100),
	Author varchar(100),
	Genre varchar (50),
	Published_Year int,
	Price Numeric (10,2),
	stock int
);

create table Customers(
	Customer_ID serial primary key,
	Name varchar(100),
	Email varchar (100),
	Phone varchar(15),
	City varchar (50),
	Country varchar (150)
	);

create table Orders (
	Order_ID serial primary key,
	Customer_ID int references Customers(Customer_ID),
	Book_ID int references Books(Book_ID),
	Order_Date Date,
	Quantity int,
	Total_Amount numeric(10,2)
	);

select * from Books;
select * from Customers;
select * from Orders;
