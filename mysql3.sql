
CREATE TABLE Customer (
  CustomerId INTEGER PRIMARY KEY,
  CustomerFirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100),
  Email VARCHAR(100),
  City VARCHAR(100),
  Country VARCHAR(100)
);


CREATE TABLE Product (
  ProductId INTEGER PRIMARY KEY,
  ProductName TEXT NOT NULL,
  Price INTEGER ,
  Stocks INTEGER,
  CustomerId INTEGER,
  FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);


INSERT INTO Customer (CustomerId, CustomerFirstName, LastName, Email, City, Country) VALUES
(1, 'John', 'Doe', 'john@example.com', 'New York', 'USA'),
(2, 'Jane', 'Smith', 'jane@example.com', 'London', 'UK'),
(3, 'Ali', 'Khan', 'ali@example.com', 'Lahore', 'Pakistan');


select * from Customer;


INSERT INTO Product (ProductId, ProductName, Price, Stocks, CustomerId) VALUES
(101, 'Laptop', 1000, 10, 1),
(102, 'Phone', 500, 25, 2),
(103, 'Tablet', 300, 15, 3),
(104, 'Monitor', 200, 5, NULL);  -- No customer associated



select * from Product;



Alter table Customer add phoneNumber VARCHAR(100);

desc Customer;


Alter table Product add barcode VARCHAR(100);
-- ALTER TABLE Product RENAME COLUMN barcode TO Barcode;


desc Product;


-- Alter table Product drop barcode;
-- desc Product;


-- Alter table Product rename barcode to Barcode;
ALTER TABLE Product RENAME COLUMN barcode TO Barcode;

-- select * from Product;
desc Product;



-- // Updating 

-- update Product set Price = MRP;
alter TABLE product add MRP int;
update product set price = MRP;
select * FROM product;


-- update TABLE Customer set pro



-- Alter table Customer drop phoneNumber;
-- desc Customer;   
-- Alter table Customer rename phoneNumber to PhoneNumber;
ALTER TABLE Customer RENAME COLUMN phoneNumber TO PhoneNumber;
-- desc Customer;
-- select * from Customer;
-- update TABLE Customer set PhoneNumber = '123-456-7890' where CustomerId = 1;
-- select * from Customer;
-- desc Customer;