
-- Department Table (not needed for products but included if required elsewhere)


CREATE TABLE Department (
  deptId INTEGER PRIMARY KEY,
  deptName VARCHAR(100) UNIQUE
);

-- Product Table
CREATE TABLE Product (
  productId INTEGER PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2)
);

-- Customer Table
CREATE TABLE Customer (
  customerId INTEGER PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE
);

-- Orders Table (Each order belongs to one customer)
CREATE TABLE Orders (
  orderId INTEGER PRIMARY KEY,
  customerId INTEGER,
  -- orderDate DATE DEFAULT DATE,
  FOREIGN KEY (customerId) REFERENCES Customer(customerId),
);

-- OrderDetails Table (Many-to-many between orders and products)
CREATE TABLE OrderDetails (
  orderId INTEGER,
  productId INTEGER,
  quantity INTEGER CHECK (quantity > 0),
  PRIMARY KEY (orderId, productId),
  FOREIGN KEY (orderId) REFERENCES Orders(orderId) ON DELETE CASCADE,
  FOREIGN KEY (productId) REFERENCES Product(productId)
);







INSERT INTO Product VALUES (1, 'Laptop', 75000.00);
INSERT INTO Product VALUES (2, 'Mouse', 500.00);
INSERT INTO Product VALUES (3, 'Keyboard', 1500.00);



INSERT INTO Customer VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Customer VALUES (2, 'Bob', 'bob@example.com');


INSERT INTO Orders VALUES (101, 1, '2025-09-03'); -- Order by Alice
INSERT INTO Orders VALUES (102, 2, '2025-09-03'); -- Order by Bob


SELECT * FROM Customer;

SELECT * FROM Product;

SELECT * FROM Orders;

SELECT * FROM OrderDetails;