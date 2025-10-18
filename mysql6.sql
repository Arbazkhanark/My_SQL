
-- create
CREATE TABLE Orders (
  orderId INTEGER PRIMARY KEY,
  category varchar(50) NOT NULL,
  customerName varchar(50) NOT NULL,
  productName varchar(50),
  qty int,
  price INTEGER
  
);

-- insert
INSERT INTO Orders VALUES (0001, 'Fashion', 'Vivek','T-shirt',2,1200);
INSERT INTO Orders VALUES (0002, 'Fashion', 'Ansh','Shirt',1,800);
INSERT INTO Orders VALUES (0003, 'Electronics', 'Vicky','Power Bank',1,2200);
INSERT INTO Orders VALUES (0004, 'Electronics', 'Yash','Mouse',1,900);


-- fetch 
SELECT * FROM Orders ;

SELECT sum(price) from Orders;

SELECT count(customerName) from Orders;

SELECT avg(price) from Orders;

SELECT max(price) from Orders;

SELECT min(price) from Orders;


INSERT INTO Orders (orderId, category, customerName, productName, qty, price)
VALUES (0005, 'Electronics', 'Ansh', 'Keyboard', 1, 1800);

INSERT INTO Orders (orderId, category, customerName, productName, qty, price)
VALUES (0006, 'Electronics', 'Arbaaz', 'Bulb', 1, 900);


INSERT INTO Orders (orderId, category, customerName, productName, qty, price)
VALUES (0007, 'Fashion', 'Arbaaz', 'Specs', 1, 3000);







SELECT * from Orders;

 
-- Find Total is spending per customer per category 

SELECT customerName,category,sum(price) as Total_Spending from Orders group by customerName,category;




-- Find Customers wgo spended more than 1500 in Electronics

SELECT * from Orders where price>1500 and category="Electronics";


