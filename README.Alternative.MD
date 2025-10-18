# MySQL Sikho: Basic se Advanced Tak (Complete Guide)

Ye `README.md` file MySQL aur SQL sikhne ka ek pura guide hai, jo basic se lekar advanced tak sab cover karta hai. Sab kuch simple language mein (Hindi aur English mix) likha hai taki aap asani se samajh sako. Har section mein:
- **Explanation**: Concept kya hai, bilkul aasan shabdon mein.
- **SQL Code**: Aapke diye hue code ko clean aur organized kiya hai.
- **Kaam Kya Karta Hai**: Code kya karta hai, step-by-step.
- **Tips**: Galti se kaise bachna hai aur extra info.

Aap isse MySQL Workbench, DB-Fiddle, ya kisi aur MySQL tool mein practice kar sakte ho. Chalo shuru karte hain!

---

## 1. SQL aur MySQL Kya Hai?
### Explanation
SQL (Structured Query Language) ek language hai jo database mein data ko manage aur query karne ke liye use hoti hai. MySQL ek free database software hai jo SQL samajhta hai. Database mein data **tables** mein store hota hai, jaise Excel sheet. Table mein:
- **Rows**: Ek record (jaise ek customer ka data).
- **Columns**: Fields (jaise Name, Email).
- **Primary Key**: Har row ka unique ID.
- **Foreign Key**: Tables ko jodta hai (jaise Product ka CustomerId).

### Database Banane ka Code
Pehle database banana zaroori hai, warna tables nahi bana sakte.

**SQL Code Example**:
```sql
CREATE DATABASE MyDatabase;
USE MyDatabase;
```

**Kaam Kya Karta Hai**:
- `CREATE DATABASE MyDatabase;`: Ek naya database banata hai, naam `MyDatabase`.
- `USE MyDatabase;`: Is database ko select karta hai taki saare commands isme chal sake.

**Tips**:
- Hamesha pehle database banao aur `USE` karo.
- Error “database not found”? `USE` command chala do.

---

## 2. Tables Kaise Banaaye
### Explanation
Tables data store karte hain. `CREATE TABLE` se table banate hain, jisme columns aur unke data types (jaise INTEGER, VARCHAR) define karte hain. Constraints bhi add kar sakte hain:
- `NOT NULL`: Field khali nahi reh sakta.
- `PRIMARY KEY`: Unique ID.
- `FOREIGN KEY`: Dusre table se link.
- `UNIQUE`: Value dobara nahi aa sakta.

Aapke code mein tables hain: Customer, Product, Department, Employee, Orders, STUDENT, COURSES, aur OrderDetails.

### Simple Table (Customer)
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

**Kaam Kya Karta Hai**:
- `Customer` table banata hai.
- Columns:
  - `CustomerId`: Unique ID (number, no duplicates).
  - `CustomerFirstName`: Text (100 characters tak, zaroori hai).
  - Baaki columns optional hain (NULL allowed).

### Foreign Key wala Table (Product)
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

**Kaam Kya Karta Hai**:
- `Product` table banata hai.
- `CustomerId` foreign key hai, jo `Customer` table ke `CustomerId` se jodta hai.

### Aur Tables
- **Department**:
```sql
CREATE TABLE Department (
  deptId INTEGER PRIMARY KEY,
  deptName VARCHAR(100) UNIQUE,
  location VARCHAR(100)
);
```
- `UNIQUE`: `deptName` dobara nahi aa sakta.

- **Employee** (Department se link):
```sql
CREATE TABLE EMPLOYEE (
  emp_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  dept_id INTEGER,
  FOREIGN KEY (dept_id) REFERENCES Department(deptId)
);
```

- **Orders**:
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

- **STUDENT aur COURSES**:
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

- **OrderDetails** (many-to-many Orders aur Product):
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
- `CHECK`: `quantity` > 0 hona chahiye.
- `ON DELETE CASCADE`: Order delete hone pe details bhi delete.

**Tips**:
- Pehle socho kaunse tables connect honge.
- Foreign key ke liye parent table pehle banao (jaise Customer for Product).

---

## 3. Data Kaise Daale (INSERT)
### Explanation
`INSERT INTO` se table mein rows daalte hain. Columns aur values likho, ya column order mein values daal do.

### Customer mein Data
**SQL Code Example**:
```sql
INSERT INTO Customer (CustomerId, CustomerFirstName, LastName, Email, City, Country) VALUES
(1, 'John', 'Doe', 'john@example.com', 'New York', 'USA'),
(2, 'Jane', 'Smith', 'jane@example.com', 'London', 'UK'),
(3, 'Ali', 'Khan', 'ali@example.com', 'Lahore', 'Pakistan');
```

**Kaam Kya Karta Hai**:
- `Customer` table mein 3 rows daalta hai.
- Multiple rows ek saath daal sakte ho.

### Product mein Data (NULL ke saath)
**SQL Code Example**:
```sql
INSERT INTO Product (ProductId, ProductName, Price, Stocks, CustomerId) VALUES
(101, 'Laptop', 1000, 10, 1),
(102, 'Phone', 500, 25, 2),
(103, 'Tablet', 300, 15, 3),
(104, 'Monitor', 200, 5, NULL);
```

**Kaam Kya Karta Hai**:
- `Product` mein 4 rows daalta hai.
- `NULL` ka matlab koi customer nahi linked.

### Aur Inserts
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

- **STUDENT aur COURSES**:
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

**Tips**:
- Columns aur values ka count same rakho.
- Foreign key ke values parent table mein hone chahiye.
- Text ke liye single quotes (`'`) use karo.

---

## 4. Data Kaise Dekhein (SELECT)
### Explanation
`SELECT` se data dekhte hain. `*` ka matlab saare columns. `FROM` se table choose karte hain.

### Simple SELECT
**SQL Code Example**:
```sql
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Department;
SELECT * FROM EMPLOYEE;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM STUDENT;
SELECT * FROM COURSES;
```

**Kaam Kya Karta Hai**:
- Table ke saare rows aur columns dikhaata hai.

### Table Structure Dekhna (DESC)
**SQL Code Example**:
```sql
DESC Customer;
DESC Product;
```

**Kaam Kya Karta Hai**:
- Table ke columns, data types, aur constraints dikhaata hai.

**Tips**:
- `SELECT` data ke liye, `DESC` table ke structure ke liye.
- Specific columns chahiye? `SELECT CustomerId, CustomerFirstName FROM Customer;` likho.

---

## 5. Table Change Karna (ALTER)
### Explanation
`ALTER TABLE` se table ka structure badalte hain: columns add, drop, ya rename.

### Column Add Karna
**SQL Code Example**:
```sql
ALTER TABLE Customer ADD phoneNumber VARCHAR(100);
ALTER TABLE Product ADD barcode VARCHAR(100);
ALTER TABLE Product ADD MRP INT;
```

**Kaam Kya Karta Hai**:
- Naye columns add karta hai (`phoneNumber`, `barcode`, `MRP`).
- Purani rows mein naya column `NULL` hota hai.

### Column Rename Karna
**SQL Code Example**:
```sql
ALTER TABLE Product RENAME COLUMN barcode TO Barcode;
ALTER TABLE Customer RENAME COLUMN phoneNumber TO PhoneNumber;
```

**Kaam Kya Karta Hai**:
- Column ka naam badalta hai (`barcode` → `Barcode`).

### Column Delete Karna
**SQL Code Example**:
```sql
-- ALTER TABLE Product DROP Barcode;
-- ALTER TABLE Customer DROP PhoneNumber;
```

**Kaam Kya Karta Hai**:
- Column aur uska data hata deta hai (uncomment karke chala sakte ho).

**Tips**:
- `ALTER` se data kharab ho sakta hai, dhyan se use karo.
- Badlav ke baad `DESC` chala ke check karo.

---

## 6. Data Update Karna (UPDATE)
### Explanation
`UPDATE` se existing data badalte hain. `SET` se naya value dete hain, `WHERE` se specific rows choose karte hain.

### Update Example
**SQL Code Example**:
```sql
ALTER TABLE Product ADD MRP INT;  -- Agar MRP nahi hai
UPDATE Product SET Price = MRP;
UPDATE Customer SET PhoneNumber = '123-456-7890' WHERE CustomerId = 1;
```

**Kaam Kya Karta Hai**:
- `UPDATE Product`: Saare products ka `Price` ko `MRP` ke barabar karta hai (no `WHERE` = sab rows).
- `UPDATE Customer`: `CustomerId = 1` wale customer ka `PhoneNumber` set karta hai.

**Tips**:
- `WHERE` na daalo toh saara data change ho jayega—sambhal ke!
- Update ke baad `SELECT` se check karo.

---

## 7. Tables ko Jodna (Joins)
### Explanation
Joins se do ya zyada tables ka data ek saath laate hain, common columns ke basis pe.

### Natural Join
Same name wale columns pe join karta hai.

**SQL Code Example** (Employee aur Department):
```sql
SELECT e.emp_id, e.name, d.dept_name
FROM EMPLOYEE e
NATURAL JOIN Department d;
```

**Kaam Kya Karta Hai**:
- `dept_id` pe join karta hai.
- Employee ka ID, name, aur department ka naam dikhaata hai.

### Inner Join
`ON` ke saath condition dete ho.

**SQL Code Example** (Student aur Courses):
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

**Kaam Kya Karta Hai**:
- `INNER JOIN`: Sirf matching rows dikhaata hai.
- `ON`: Join ka rule (e.g., `s.student_id = c.student_id`).
- `WHERE`: Results filter karta hai.

**Tips**:
- Aliases (e.g., `s` for `STUDENT`) code ko chhota karte hain.
- `NATURAL JOIN` automatic hai, `INNER JOIN` zyada control deta hai.
- Error? Foreign key values check karo.

---

## 8. Aggregate Functions (Summary Karna)
### Explanation
Aggregates data ka summary dete hain:
- `SUM`: Total.
- `COUNT`: Rows ki ginti.
- `AVG`: Average.
- `MAX`: Sabse bada value.
- `MIN`: Sabse chhota value.

### Aggregate Examples
**SQL Code Example** (Orders):
```sql
SELECT SUM(price) AS TotalPrice FROM Orders;
SELECT COUNT(customerName) AS CustomerCount FROM Orders;
SELECT AVG(price) AS AvgPrice FROM Orders;
SELECT MAX(price) AS MaxPrice FROM Orders;
SELECT MIN(price) AS MinPrice FROM Orders;
```

**Kaam Kya Karta Hai**:
- `SUM`: Saare orders ka total price.
- `COUNT`: Kitne customers.
- `AVG`: Average price.
- `MAX`/`MIN`: Highest/lowest price.

**Tips**:
- `AS` se column ka naam clear hota hai.
- `COUNT(*)` saare rows, `COUNT(column)` sirf non-NULL count karta hai.

---

## 9. Group By aur Advanced Queries
### Explanation
`GROUP BY` se data ko groups mein baant ke summary karte hain. `WHERE` se pehle filter, `HAVING` se aggregate filter.

### Group By Example
**SQL Code Example**:
```sql
SELECT customerName, category, SUM(price) AS Total_Spending
FROM Orders
GROUP BY customerName, category;
```

**Kaam Kya Karta Hai**:
- `customerName` aur `category` ke hisaab se groups banata hai.
- Har group ka total `price` dikhaata hai.

### Filtered Query
**SQL Code Example**:
```sql
SELECT * FROM Orders
WHERE price > 1500 AND category = 'Electronics';
```

**Kaam Kya Karta Hai**:
- `price` > 1500 aur `category = Electronics` wale orders dikhaata hai.

**Tips**:
- Query ka order: `FROM` → `WHERE` → `GROUP BY` → `SELECT` → `ORDER BY`.
- Aggregate filter ke liye `HAVING` use karo (e.g., `HAVING SUM(price) > 1000`).

---

## 10. Common Mistakes aur Fixes
- **“Unknown database”**: `CREATE DATABASE` aur `USE` chala do.
- **“Unknown column”**: Column naam check karo ya `ALTER TABLE` se add karo.
- **Foreign key error**: Parent table mein value honi chahiye.
- **Syntax error**: Commas, quotes, ya MySQL version check karo.

---

## 11. Agla Kya Seekhein
Ab tak tumne basic (CREATE, INSERT, SELECT) aur intermediate (JOIN, GROUP BY) seekh liya. Advanced ke liye:
- **Subqueries**: SELECT ke andar SELECT (e.g., `SELECT name FROM Customer WHERE id IN (SELECT customerId FROM Orders)`).
- **Indexes**: Queries ko fast karne ke liye (`CREATE INDEX`).
- **Views**: Virtual tables (`CREATE VIEW`).
- **Triggers**: Data change pe auto-action (`CREATE TRIGGER`).
- **Stored Procedures**: SQL functions save karna (`CREATE PROCEDURE`).

### Practice Tips
- MySQL Workbench ya DB-Fiddle pe try karo.
- Zyada data daalo (10+ rows) aur test karo.
- Errors try karke seekho (e.g., galat foreign key daal ke).
- Har step ke baad `SELECT` se check karo.

---

## 12. Poora Database Setup
Ye ek complete code hai sab kuch set karne ke liye:

```sql
CREATE DATABASE MyDatabase;
USE MyDatabase;

-- Tables Banaao
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

-- Data Daalo
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

INSERT INTO OrderDetails VALUES (101, 1, 2);
INSERT INTO OrderDetails VALUES (102, 2, 1);

-- Table Change Karo
ALTER TABLE Customer ADD phoneNumber VARCHAR(100);
ALTER TABLE Product ADD barcode VARCHAR(100);
ALTER TABLE Product ADD MRP INT;
ALTER TABLE Product RENAME COLUMN barcode TO Barcode;
ALTER TABLE Customer RENAME COLUMN phoneNumber TO PhoneNumber;

-- Data Update Karo
UPDATE Customer SET PhoneNumber = '123-456-7890' WHERE CustomerId = 1;
-- UPDATE Product SET Price = MRP;  -- MRP set karne ke baad chalaana

-- Queries Chalao
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

-- Filter
SELECT * FROM Orders
WHERE price > 1500 AND category = 'Electronics';
```

---

## 13. File Kaise Download Karo
1. **Code Copy Karo**: Upar ka pura text (# MySQL Sikho se end tak).
2. **Text Editor mein Paste Karo**: Notepad, VS Code, ya koi aur editor kholo.
3. **Save as `README.md`**: File ko `.md` extension ke saath save karo.
4. **Padho**: VS Code, GitHub, ya online Markdown viewer (jaise Dillinger) mein kholo.
5. **SQL Practice Karo**: SQL code ko MySQL Workbench ya DB-Fiddle mein copy-paste karke chalaao.
6. **Order mein Chalaao**: Pehle database, phir tables, phir inserts, warna error aayega.

---

## 14. Aur Kya Seekhein
- Naye queries try karo (e.g., `ORDER BY price DESC` se sorting).
- MySQL docs padho (https://dev.mysql.com/doc/).
- Roz thodi practice karo, chhote datasets ke saath.
- Advanced topics (subqueries, triggers) ke liye mujhe pooch lena!

Koi doubt ho toh batana, aur seekhte raho! 🚀
