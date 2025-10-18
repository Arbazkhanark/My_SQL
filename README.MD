# MySQL Tutorial: From Basics to Advanced

This guide teaches MySQL/SQL from scratch to advanced concepts, using the code you provided. It’s written in simple English (thodi Hindi ke saath for clarity) to make learning easy. Each section explains a concept, shows the SQL code, describes what it does, and includes tips to avoid common mistakes. You can practice these in MySQL Workbench, DB-Fiddle, or any MySQL environment.

---

## 1. Introduction to SQL and MySQL
### Explanation
SQL (Structured Query Language) is used to manage and query data in databases. MySQL is a popular, free database system that uses SQL. Data is stored in **tables** (like Excel sheets), with **rows** (one record, e.g., one customer) and **columns** (fields, e.g., Name, Email).

- **Key Terms**:
  - **Table**: Stores data in rows and columns.
  - **Primary Key**: Unique ID for each row (no duplicates).
  - **Foreign Key**: Links tables (e.g., a product linked to a customer).
  - **Database**: Collection of tables.

### Creating a Database
Before creating tables, you need a database. Your code assumes one exists, but let’s start with this.

**SQL Code Example**:
```sql
CREATE DATABASE MyDatabase;
USE MyDatabase;
```

**What It Does**:
- `CREATE DATABASE MyDatabase;`: Creates a new database named `MyDatabase`.
- `USE MyDatabase;`: Switches to this database for all further commands.

**Tips/Notes**:
- Always create and select a database first.
- If you see “database not found” errors, you forgot `USE`.

---

## 2. Creating Tables
### Explanation
Tables hold your data. Use `CREATE TABLE` to define:
- **Columns**: Fields like Name, Age (with data types like INTEGER, VARCHAR).
- **Constraints**: Rules like `NOT NULL` (must have value), `PRIMARY KEY` (unique ID), `FOREIGN KEY` (links tables).

Your code includes tables like Customer, Product, Department, Employee, Orders, STUDENT, COURSES, and OrderDetails.

### Basic Table Creation (Customer Table)
**SQL Code Example**:
```sql
CREATE TABLE Customer (
  CustomerId INTEGER PRIMARY KEY,
  CustomerFirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100),
  Email VARCHAR(100),
  City VARCHAR(100),
  Country VARCHAR(100)
);
```

**What It Does**:
- Creates a `Customer` table.
- Columns:
  - `CustomerId`: Unique ID (number, PRIMARY KEY ensures no duplicates).
  - `CustomerFirstName`: Text (up to 100 characters, required due to NOT NULL).
  - Others: Optional text fields.

**Tips/Notes**:
- Data types: `INTEGER` (numbers), `VARCHAR(n)` (text up to n characters), `TEXT` (long text).
- `NOT NULL` means the field can’t be empty.

### Table with Foreign Key (Product Table)
Foreign keys connect tables (e.g., a product linked to a customer).

**SQL Code Example**:
```sql
CREATE TABLE Product (
  ProductId INTEGER PRIMARY KEY,
  ProductName TEXT NOT NULL,
  Price INTEGER,
  Stocks INTEGER,
  CustomerId INTEGER,
  FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);
```

**What It Does**:
- Creates `Product` table.
- `CustomerId` is a foreign key linking to `Customer` table’s `CustomerId`.
- Ensures only valid `CustomerId` values are used.

### More Table Examples
- **Department Table**:
```sql
CREATE TABLE Department (
  deptId INTEGER PRIMARY KEY,
  deptName VARCHAR(100) UNIQUE,
  location VARCHAR(100)
);
```
- `UNIQUE` ensures no duplicate `deptName`.

- **Employee Table** (links to Department):
```sql
CREATE TABLE EMPLOYEE (
  emp_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  dept_id INTEGER,
  FOREIGN KEY (dept_id) REFERENCES Department(deptId)
);
```

- **Orders Table** (simple, no foreign key in your version):
```sql
CREATE TABLE Orders (
  orderId INTEGER PRIMARY KEY,
  category VARCHAR(50) NOT NULL,
  customerName VARCHAR(50) NOT NULL,
  productName VARCHAR(50),
  qty INT,
  price INTEGER
);
```

- **STUDENT and COURSES Tables** (like Employee-Department):
```sql
CREATE TABLE STUDENT (
  student_id INTEGER PRIMARY KEY,
  name VARCHAR(200),
  age INTEGER,
  address VARCHAR(200),
  location VARCHAR(100),
  phone_number VARCHAR(100)
);

CREATE TABLE COURSES (
  course_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  student_id INTEGER,
  FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);
```

- **OrderDetails Table** (many-to-many between Orders and Product):
```sql
CREATE TABLE OrderDetails (
  orderId INTEGER,
  productId INTEGER,
  quantity INTEGER CHECK (quantity > 0),
  PRIMARY KEY (orderId, productId),
  FOREIGN KEY (orderId) REFERENCES Orders(orderId) ON DELETE CASCADE,
  FOREIGN KEY (productId) REFERENCES Product(productId)
);
```
- `CHECK`: Ensures `quantity` > 0.
- `ON DELETE CASCADE`: If an order is deleted, its details are too.

**Tips/Notes**:
- Plan relationships (one-to-one, one-to-many, many-to-many) before creating tables.
- Error? Ensure referenced table (e.g., Customer for Product’s foreign key) exists.

---

## 3. Inserting Data
### Explanation
Use `INSERT INTO` to add rows. List columns and values, or insert values in column order.

### Basic Insert (Customer Data)
**SQL Code Example**:
```sql
INSERT INTO Customer (CustomerId, CustomerFirstName, LastName, Email, City, Country) VALUES
(1, 'John', 'Doe', 'john@example.com', 'New York', 'USA'),
(2, 'Jane', 'Smith', 'jane@example.com', 'London', 'UK'),
(3, 'Ali', 'Khan', 'ali@example.com', 'Lahore', 'Pakistan');
```

**What It Does**:
- Adds 3 rows to `Customer`.
- Multiple rows can be inserted in one statement.

### Insert with NULL (Product Data)
**SQL Code Example**:
```sql
INSERT INTO Product (ProductId, ProductName, Price, Stocks, CustomerId) VALUES
(101, 'Laptop', 1000, 10, 1),
(102, 'Phone', 500, 25, 2),
(103, 'Tablet', 300, 15, 3),
(104, 'Monitor', 200, 5, NULL);
```

**What It Does**:
- Adds products, some linked to customers (`CustomerId` = 1, 2, 3).
- `NULL` for `CustomerId` means no customer (allowed if not `NOT NULL`).

### More Inserts
- **Department**:
```sql
INSERT INTO Department VALUES (1, 'MCA', 'New Delhi');
INSERT INTO Department VALUES (2, 'BCA', 'Rajasthan');
INSERT INTO Department VALUES (3, 'MSc', 'UP');
```

- **Employee**:
```sql
INSERT INTO EMPLOYEE VALUES (0001, 'Arbaaz khan', 1);
INSERT INTO EMPLOYEE VALUES (0002, 'Vanshu', 2);
INSERT INTO EMPLOYEE VALUES (0003, 'Viv', 1);
```

- **Orders**:
```sql
INSERT INTO Orders (orderId, category, customerName, productName, qty, price) VALUES
(0001, 'Fashion', 'Vivek', 'T-shirt', 2, 1200),
(0002, 'Fashion', 'Ansh', 'Shirt', 1, 800),
(0003, 'Electronics', 'Vicky', 'Power Bank', 1, 2200),
(0004, 'Electronics', 'Yash', 'Mouse', 1, 900),
(0005, 'Electronics', 'Ansh', 'Keyboard', 1, 1800),
(0006, 'Electronics', 'Arbaaz', 'Bulb', 1, 900),
(0007, 'Fashion', 'Arbaaz', 'Specs', 1, 3000);
```

- **STUDENT and COURSES**:
```sql
INSERT INTO STUDENT VALUES (1, 'ABC', 20, 'ABC', 'New Delhi', '8287823966');
INSERT INTO STUDENT VALUES (2, 'BVA', 24, 'ABC', 'Rajasthan', '8287823966');
INSERT INTO STUDENT VALUES (3, 'Aman', 21, 'ABC', 'UP', '8287823966');

INSERT INTO COURSES VALUES (0001, 'DSA', 1);
INSERT INTO COURSES VALUES (0002, 'Python', 2);
INSERT INTO COURSES VALUES (0003, 'DS', 1);
```

- **OrderDetails**:
```sql
INSERT INTO OrderDetails VALUES (101, 1, 2);
INSERT INTO OrderDetails VALUES (102, 2, 1);
```

**Tips/Notes**:
- Match column count in `INSERT`.
- Foreign key values must exist (e.g., `CustomerId` 1 must be in `Customer`).
- Use single quotes (`'`) for text, numbers don’t need quotes.

---

## 4. Viewing Data (SELECT Queries)
### Explanation
`SELECT` retrieves data. Use `*` for all columns, or list specific columns. `FROM` specifies the table.

### Basic Select
**SQL Code Example**:
```sql
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Department;
SELECT * FROM EMPLOYEE;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
```

**What It Does**:
- Shows all rows and columns of the table.

### Describing Table Structure
`DESC` (or `DESCRIBE`) shows table structure (columns, types, constraints).

**SQL Code Example**:
```sql
DESC Customer;
DESC Product;
```

**What It Does**:
- Lists columns, data types, keys, and constraints.

**Tips/Notes**:
- `SELECT` for data, `DESC` for table info.
- Use `WHERE` (covered later) to filter rows.

---

## 5. Altering Tables (Modifying Structure)
### Explanation
`ALTER TABLE` changes table structure: add, drop, or rename columns.

### Add Column
**SQL Code Example**:
```sql
ALTER TABLE Customer ADD phoneNumber VARCHAR(100);
ALTER TABLE Product ADD barcode VARCHAR(100);
ALTER TABLE Product ADD MRP INT;
```

**What It Does**:
- Adds new columns (`phoneNumber`, `barcode`, `MRP`).
- Existing rows get `NULL` for new columns.

### Rename Column
**SQL Code Example**:
```sql
ALTER TABLE Product RENAME COLUMN barcode TO Barcode;
ALTER TABLE Customer RENAME COLUMN phoneNumber TO PhoneNumber;
```

**What It Does**:
- Renames columns to `Barcode`, `PhoneNumber`.

### Drop Column (Commented in Your Code)
**SQL Code Example**:
```sql
-- ALTER TABLE Product DROP Barcode;
-- ALTER TABLE Customer DROP PhoneNumber;
```

**What It Does**:
- Removes column (and its data). Uncomment to use.

**Tips/Notes**:
- `ALTER` is permanent—be careful!
- Check changes with `DESC`.
- MySQL uses `RENAME COLUMN` (not just `RENAME`).

---

## 6. Updating Data
### Explanation
`UPDATE` modifies existing rows. Use `SET` to change values, `WHERE` to target specific rows.

### Basic Update
**SQL Code Example**:
```sql
ALTER TABLE Product ADD MRP INT;  -- If not already added
UPDATE Product SET Price = MRP;
UPDATE Customer SET PhoneNumber = '123-456-7890' WHERE CustomerId = 1;
```

**What It Does**:
- `UPDATE Product SET Price = MRP;`: Sets `Price` to `MRP` for all rows (no WHERE = all rows).
- `UPDATE Customer`: Sets `PhoneNumber` for customer with `CustomerId = 1`.

**Tips/Notes**:
- Without `WHERE`, all rows update—dangerous!
- Your code had incomplete updates (e.g., `set pro`); fixed here.
- Verify with `SELECT` after updating.

---

## 7. Joins (Combining Tables)
### Explanation
Joins combine data from multiple tables based on related columns. Types: `INNER JOIN`, `NATURAL JOIN`, `LEFT JOIN`, etc.

### Natural Join
Matches on columns with same name and data type.

**SQL Code Example** (Employee and Department):
```sql
SELECT e.emp_id, e.name, d.dept_name
FROM EMPLOYEE e
NATURAL JOIN Department d;
```

**What It Does**:
- Joins on `dept_id` (common column).
- Shows employee ID, name, and department name.

### Inner Join
Explicitly specify join condition with `ON`.

**SQL Code Example** (Student and Courses):
```sql
SELECT s.student_id, s.name, s.age, c.course_id
FROM STUDENT s
INNER JOIN COURSES c ON s.student_id = c.student_id
WHERE s.age > 20;

SELECT s.name, c.course_id, c.name
FROM STUDENT s
INNER JOIN COURSES c ON s.student_id = c.student_id;

SELECT s.name
FROM STUDENT s
INNER JOIN COURSES c ON s.student_id = c.student_id
WHERE s.age > 15 AND c.course_id = 2;
```

**What It Does**:
- `INNER JOIN`: Returns only matching rows.
- `ON`: Specifies join condition (e.g., `s.student_id = c.student_id`).
- `WHERE`: Filters results (e.g., age > 20 or specific course).

**Tips/Notes**:
- Use aliases (e.g., `s` for `STUDENT`) for shorter queries.
- `NATURAL JOIN` assumes same column names; `INNER JOIN` is more explicit.
- Error? Check foreign key values exist.

---

## 8. Aggregate Functions
### Explanation
Aggregates summarize data:
- `SUM`: Total.
- `COUNT`: Number of rows.
- `AVG`: Average.
- `MAX`: Highest value.
- `MIN`: Lowest value.

### Basic Aggregates
**SQL Code Example** (Orders Table):
```sql
SELECT SUM(price) AS TotalPrice FROM Orders;
SELECT COUNT(customerName) AS CustomerCount FROM Orders;
SELECT AVG(price) AS AvgPrice FROM Orders;
SELECT MAX(price) AS MaxPrice FROM Orders;
SELECT MIN(price) AS MinPrice FROM Orders;
```

**What It Does**:
- Calculates totals, counts, etc., across all rows.
- `AS` gives a readable column name.

**Tips/Notes**:
- Use with `GROUP BY` for per-group aggregates (next section).
- `COUNT(*)` counts all rows; `COUNT(column)` counts non-NULL values.

---

## 9. Group By and Advanced Queries
### Explanation
`GROUP BY` groups rows for aggregates (e.g., total per customer). Use `WHERE` for filters before grouping, `HAVING` for filters on aggregates.

### Group By Example
**SQL Code Example**:
```sql
SELECT customerName, category, SUM(price) AS Total_Spending
FROM Orders
GROUP BY customerName, category;
```

**What It Does**:
- Groups rows by `customerName` and `category`.
- Calculates total `price` for each group.

### Filtered Query
**SQL Code Example**:
```sql
SELECT * FROM Orders
WHERE price > 1500 AND category = 'Electronics';
```

**What It Does**:
- Shows orders with `price` > 1500 in `Electronics` category.

**Tips/Notes**:
- Order: `FROM` → `WHERE` → `GROUP BY` → `SELECT` → `ORDER BY`.
- Use `HAVING` for aggregate filters (e.g., `HAVING SUM(price) > 1000`).
- Your code for Orders was clean—great job!

---

## 10. Common Errors and Fixes
- **“Unknown database”**: Run `CREATE DATABASE` and `USE`.
- **“Unknown column”**: Check column names or `ALTER TABLE` to add.
- **Foreign key error**: Ensure referenced value exists (e.g., `CustomerId` in `Customer`).
- **Syntax error**: Check commas, quotes, or MySQL version (e.g., `RENAME COLUMN` is newer).

---

## 11. Next Steps for Advanced Topics
You’ve covered basics (CREATE, INSERT, SELECT) to intermediate (JOIN, GROUP BY). For advanced learning:
- **Subqueries**: SELECT inside SELECT (e.g., `SELECT name FROM Customer WHERE id IN (SELECT customerId FROM Orders)`).
- **Indexes**: Speed up queries (`CREATE INDEX`).
- **Views**: Virtual tables (`CREATE VIEW`).
- **Triggers**: Auto-run SQL on events (`CREATE TRIGGER`).
- **Stored Procedures**: Saved SQL functions (`CREATE PROCEDURE`).

### Practice Tips
- Run queries in MySQL Workbench or online tools.
- Add more data to test (e.g., 10+ rows).
- Try errors (e.g., insert invalid foreign key) to learn debugging.
- Use `SELECT *` to verify data after each step.

---

## 12. Full Example Database
Run this in order to set up everything:

```sql
CREATE DATABASE MyDatabase;
USE MyDatabase;

-- Create Tables
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
  Price INTEGER,
  Stocks INTEGER,
  CustomerId INTEGER,
  FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE Department (
  deptId INTEGER PRIMARY KEY,
  deptName VARCHAR(100) UNIQUE,
  location VARCHAR(100)
);

CREATE TABLE EMPLOYEE (
  emp_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  dept_id INTEGER,
  FOREIGN KEY (dept_id) REFERENCES Department(deptId)
);

CREATE TABLE Orders (
  orderId INTEGER PRIMARY KEY,
  category VARCHAR(50) NOT NULL,
  customerName VARCHAR(50) NOT NULL,
  productName VARCHAR(50),
  qty INT,
  price INTEGER
);

CREATE TABLE STUDENT (
  student_id INTEGER PRIMARY KEY,
  name VARCHAR(200),
  age INTEGER,
  address VARCHAR(200),
  location VARCHAR(100),
  phone_number VARCHAR(100)
);

CREATE TABLE COURSES (
  course_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  student_id INTEGER,
  FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

CREATE TABLE OrderDetails (
  orderId INTEGER,
  productId INTEGER,
  quantity INTEGER CHECK (quantity > 0),
  PRIMARY KEY (orderId, productId),
  FOREIGN KEY (orderId) REFERENCES Orders(orderId) ON DELETE CASCADE,
  FOREIGN KEY (productId) REFERENCES Product(productId)
);

-- Insert Data
INSERT INTO Customer (CustomerId, CustomerFirstName, LastName, Email, City, Country) VALUES
(1, 'John', 'Doe', 'john@example.com', 'New York', 'USA'),
(2, 'Jane', 'Smith', 'jane@example.com', 'London', 'UK'),
(3, 'Ali', 'Khan', 'ali@example.com', 'Lahore', 'Pakistan');

INSERT INTO Product (ProductId, ProductName, Price, Stocks, CustomerId) VALUES
(101, 'Laptop', 1000, 10, 1),
(102, 'Phone', 500, 25, 2),
(103, 'Tablet', 300, 15, 3),
(104, 'Monitor', 200, 5, NULL);

INSERT INTO Department VALUES (1, 'MCA', 'New Delhi');
INSERT INTO Department VALUES (2, 'BCA', 'Rajasthan');
INSERT INTO Department VALUES (3, 'MSc', 'UP');

INSERT INTO EMPLOYEE VALUES (0001, 'Arbaaz khan', 1);
INSERT INTO EMPLOYEE VALUES (0002, 'Vanshu', 2);
INSERT INTO EMPLOYEE VALUES (0003, 'Viv', 1);

INSERT INTO Orders (orderId, category, customerName, productName, qty, price) VALUES
(0001, 'Fashion', 'Vivek', 'T-shirt', 2, 1200),
(0002, 'Fashion', 'Ansh', 'Shirt', 1, 800),
(0003, 'Electronics', 'Vicky', 'Power Bank', 1, 2200),
(0004, 'Electronics', 'Yash', 'Mouse', 1, 900),
(0005, 'Electronics', 'Ansh', 'Keyboard', 1, 1800),
(0006, 'Electronics', 'Arbaaz', 'Bulb', 1, 900),
(0007, 'Fashion', 'Arbaaz', 'Specs', 1, 3000);

INSERT INTO STUDENT VALUES (1, 'ABC', 20, 'ABC', 'New Delhi', '8287823966');
INSERT INTO STUDENT VALUES (2, 'BVA', 24, 'ABC', 'Rajasthan', '8287823966');
INSERT INTO STUDENT VALUES (3, 'Aman', 21, 'ABC', 'UP', '8287823966');

INSERT INTO COURSES VALUES (0001, 'DSA', 1);
INSERT INTO COURSES VALUES (0002, 'Python', 2);
INSERT INTO COURSES VALUES (0003, 'DS', 1);

-- Alter Tables
ALTER TABLE Customer ADD phoneNumber VARCHAR(100);
ALTER TABLE Product ADD barcode VARCHAR(100);
ALTER TABLE Product ADD MRP INT;
ALTER TABLE Product RENAME COLUMN barcode TO Barcode;
ALTER TABLE Customer RENAME COLUMN phoneNumber TO PhoneNumber;

-- Updates
UPDATE Customer SET PhoneNumber = '123-456-7890' WHERE CustomerId = 1;
-- UPDATE Product SET Price = MRP;  -- Uncomment after setting MRP values

-- Queries
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Department;
SELECT * FROM EMPLOYEE;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM STUDENT;
SELECT * FROM COURSES;

-- Joins
SELECT e.emp_id, e.name, d.dept_name
FROM EMPLOYEE e
NATURAL JOIN Department d;

SELECT s.student_id, s.name, s.age, c.course_id
FROM STUDENT s
INNER JOIN COURSES c ON s.student_id = c.student_id
WHERE s.age > 20;

-- Aggregates
SELECT SUM(price) AS TotalPrice FROM Orders;
SELECT COUNT(customerName) AS CustomerCount FROM Orders;
SELECT AVG(price) AS AvgPrice FROM Orders;
SELECT MAX(price) AS MaxPrice FROM Orders;
SELECT MIN(price) AS MinPrice FROM Orders;

-- Group By
SELECT customerName, category, SUM(price) AS Total_Spending
FROM Orders
GROUP BY customerName, category;

-- Filtered Query
SELECT * FROM Orders
WHERE price > 1500 AND category = 'Electronics';
```

---

## 13. How to Download and Use
1. **Copy the Code**: Copy everything above (from `# MySQL Tutorial` to the end).
2. **Paste in Editor**: Open a text editor (Notepad, VS Code, etc.).
3. **Save as `README.md`**: Use the `.md` extension.
4. **View**: Open in a Markdown viewer (e.g., VS Code, GitHub, or online editors like Dillinger).
5. **Practice SQL**: Copy SQL code into MySQL Workbench or an online tool like DB-Fiddle.
6. **Run in Order**: Execute commands sequentially to avoid errors (e.g., create tables before inserting).

---

## 14. Keep Learning
- Experiment with new queries (e.g., `ORDER BY`, `LIKE` for searches).
- Read MySQL docs (https://dev.mysql.com/doc/).
- Practice daily with small datasets.
- Ask for more advanced topics (e.g., triggers, stored procedures) when ready!

Happy learning, aur koi doubt ho toh pooch lena! 🚀