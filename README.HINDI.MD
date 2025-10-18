# MySQL Sikho: Basic se Advanced Tak

Ye `README.md` file ek complete guide hai MySQL aur SQL sikhne ke liye, bilkul basic se lekar advanced tak. Sab kuch simple language mein (Hindi aur English mix) likha hai taki aapko asani se samajh aaye. Har section mein:
- **Explanation**: Kya hai ye concept, bilkul simple words mein.
- **SQL Code**: Aapke diye hue code ko clean karke diya hai.
- **Kaam Kya Karta Hai**: Code kya karta hai, step-by-step.
- **Tips**: Galti se bachne ke tips.

Aap isse practice kar sakte ho MySQL Workbench, DB-Fiddle, ya kisi aur MySQL tool mein. Chalo shuru karte hain!

---

## 1. SQL aur MySQL Kya Hai?
### Explanation
SQL (Structured Query Language) ek language hai jo database mein data ko manage aur query karne ke liye use hoti hai. MySQL ek free database software hai jo SQL samajhta hai. Database mein data tables mein store hota hai (jaise Excel sheet). Table mein **rows** (ek record, jaise ek customer) aur **columns** (fields, jaise Name, Email) hote hain.

**Important Words**:
- **Table**: Data ka collection (rows aur columns).
- **Primary Key**: Har row ka unique ID (koi duplicate nahi).
- **Foreign Key**: Do tables ko jodta hai (jaise Product ka CustomerId).
- **Database**: Tables ka ghar.

### Database Banane ka Code
Pehle database banana padta hai. Aapke code mein ye nahi tha, toh yaha shuru karte hain.

**SQL Code Example**:
```sql
CREATE DATABASE MyDatabase;
USE MyDatabase;
```

**Kaam Kya Karta Hai**:
- `CREATE DATABASE MyDatabase;`: Ek naya database banata hai, naam `MyDatabase`.
- `USE MyDatabase;`: Is database ko select karta hai taki saare agle commands isme chal sake.

**Tips**:
- Hamesha pehle database banao aur `USE` karo.
- Agar error aaye “database not found”, toh check karo `USE` kiya ya nahi.

---

## 2. Tables Kaise Banaaye
### Explanation
Tables data store karte hain. `CREATE TABLE` se table banate hain, jisme columns define karte hain (jaise Name, Age) aur unke data types (INTEGER, VARCHAR). Constraints bhi daal sakte hain:
- `NOT NULL`: Ye field khali nahi reh sakta.
- `PRIMARY KEY`: Unique ID.
- `FOREIGN KEY`: Dusre table se link.

Aapke code mein tables hain: Customer, Product, Department, Employee, Orders, STUDENT, COURSES, OrderDetails.

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
  - `CustomerId`: Unique ID (number, koi dobara nahi hoga).
  - `CustomerFirstName`: Text (100 characters tak, zaruri hai).
  - Baaki columns optional hain (NULL allowed).

**Tips**:
- Data types: `INTEGER` (numbers), `VARCHAR(n)` (text, n characters tak), `TEXT` (lamba text).
- `NOT NULL` matlab field khali nahi chod sakte.

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
- `CustomerId` ek foreign key hai jo `Customer` table ke `CustomerId` se link karta hai.
- Sirf wahi `CustomerId` daal sakte ho jo `Customer` table mein hai.

### Aur Tables
- **Department**:
```sql
CREATE TABLE Department (
  deptId INTEGER PRIMARY KEY,
  deptName VARCHAR(100) UNIQUE,
  location VARCHAR(100)
);
```
- `UNIQUE` se `deptName` dobara nahi aa sakta.

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

- **OrderDetails** (Orders aur Product ke beech many-to-many):
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
- `CHECK`: `quantity` 0 se bada hona chahiye.
- `ON DELETE CASCADE`: Agar order delete ho, toh uske details bhi delete ho jayenge.

**Tips**:
- Pehle socho kaunsa table kisse connect hoga.
- Foreign key ke liye pehle parent table (jaise Customer) banao.

---

## 3. Data Kaise Daale (Insert)
### Explanation
`INSERT INTO` se table mein rows daalte hain. Columns aur unke values likho, ya column order mein values daal do.

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
- Ek saath multiple rows daal sakte ho.

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
- `NULL` ka matlab koi customer nahi linked (last row).

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

**Tips**:
- Columns aur values ka count same hona chahiye.
- Foreign key ke values pehle parent table mein hone chahiye.
- Text ke liye single quotes (`'`) use karo, numbers ke liye nahi.

---

## 4. Data Kaise Dekhein (SELECT)
### Explanation
`SELECT` se data dekhte hain. `*` matlab saare columns. `FROM` se table choose karte hain.

### Simple SELECT
**SQL Code Example**:
```sql
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Department;
SELECT * FROM EMPLOYEE;
SELECT * FROM Orders;
```

**Kaam Kya Karta Hai**:
- Table ke saare rows aur columns dikhaata hai.

### Table ka Structure Dekhna (DESC)
**SQL Code Example**:
```sql
DESC Customer;
DESC Product;
```

**Kaam Kya Karta Hai**:
- Table ke columns, unke data types, aur constraints dikhaata hai.

**Tips**:
- `SELECT` data ke liye, `DESC` table info ke liye.
- Specific columns chahiye? `SELECT CustomerId, CustomerFirstName FROM Customer;` likho.

---

## 5. Table Change Karna (ALTER)
### Explanation
`ALTER TABLE` se table ka structure badalte hain: columns add, drop, ya rename kar sakte ho.

### Column Add Karna
**SQL Code Example**:
```sql
ALTER TABLE Customer ADD phoneNumber VARCHAR(100);
ALTER TABLE Product ADD barcode VARCHAR(100);
ALTER TABLE Product ADD MRP INT;
```

**Kaam Kya Karta Hai**:
- Naya column add karta hai (`phoneNumber`, `barcode`, `MRP`).
- Purani rows mein naya column `NULL` hota hai.

### Column Rename Karna
**SQL Code Example**:
```sql
ALTER TABLE Product RENAME COLUMN barcode TO Barcode;
ALTER TABLE Customer RENAME COLUMN phoneNumber TO PhoneNumber;
```

**Kaam Kya Karta Hai**:
- Column ka naam badalta hai (`barcode` → `Barcode`).

### Column Delete Karna (Aapke Code mein Commented)
**SQL Code Example**:
```sql
-- ALTER TABLE Product DROP Barcode;
-- ALTER TABLE Customer DROP PhoneNumber;
```

**Kaam Kya Karta Hai**:
- Column aur uska data hata deta hai. Uncomment karke chala sakte ho.

**Tips**:
- `ALTER` se data kharab ho sakta hai, soch samajh ke use karo.
- Badlav check karne ke liye `DESC` chala do.

---

## 6. Data Update Karna (UPDATE)
### Explanation
`UPDATE` se existing data badalte hain. `SET` se naya value dete hain, `WHERE` se specific rows choose karte hain.

### Update Example
**SQL Code Example**:
```sql
ALTER TABLE Product ADD MRP INT;  -- Agar MRP nahi hai toh
UPDATE Product SET Price = MRP;
UPDATE Customer SET PhoneNumber = '123-456-7890' WHERE CustomerId = 1;
```

**Kaam Kya Karta Hai**:
- `UPDATE Product`: Saare products ka `Price` ko `MRP` ke barabar karta hai (agar `WHERE` nahi, toh sab rows).
- `UPDATE Customer`: `CustomerId = 1` wale customer ka `PhoneNumber` set karta hai.

**Tips**:
- `WHERE` nahi daala toh saara data change ho jayega—dhyan se!
- Aapka code mein `UPDATE ... set pro` incomplete tha, yaha fix kiya.
- Update ke baad `SELECT` se check karo.

---

## 7. Tables ko Jodna (Joins)
### Explanation
Joins se do ya zyada tables ka data ek saath laate hain. Common columns ke basis pe jodte hain.

### Natural Join
Same name wale columns pe join karta hai.

**SQL Code Example** (Employee aur Department):
```sql
SELECT e.emp_id, e.name, d.dept_name
FROM EMPLOYEE e
NATURAL JOIN Department d;
```

**Kaam Kya Karta Hai**:
- `dept_id` pe join karta hai (dono tables mein same naam).
- Employee ka ID, name, aur department ka naam dikhaata hai.

### Inner Join
Aap khud condition dete ho `ON` ke saath.

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
- `WHERE`: Results filter karta hai (e.g., age > 20 ya course_id = 2).

**Tips**:
- Aliases (e.g., `s` for `STUDENT`) code ko chhota karte hain.
- `NATURAL JOIN` automatic hai, par `INNER JOIN` zyada control deta hai.
- Error? Check karo foreign key values hain ya nahi.

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
**SQL Code Example** (Orders Table):
```sql
SELECT SUM(price) AS TotalPrice FROM Orders;
SELECT COUNT(customerName) AS CustomerCount FROM Orders;
SELECT AVG(price) AS AvgPrice FROM Orders;
SELECT MAX(price) AS MaxPrice FROM Orders;
SELECT MIN(price) AS MinPrice FROM Orders;
```

**Kaam Kya Karta Hai**:
- `SUM`: Saare orders ka total price.
- `COUNT`: Kitne customers hain.
- `AVG`: Average price.
- `MAX`/`MIN`: Sabse zyada/chhota price.

**Tips**:
- `AS` se column ka naam samajh aata hai.
- `COUNT(*)` saare rows count karta hai, `COUNT(column)` sirf non-NULL.

---

## 9. Group By aur Advanced Queries
### Explanation
`GROUP BY` se data ko groups mein baant ke summary karte hain (e.g., har customer ka total). `WHERE` se pehle filter, `HAVING` se aggregate filter.

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
- **Subqueries**: SELECT ke andar SELECT.
- **Indexes**: Queries ko fast karne ke liye (`CREATE INDEX`).
- **Views**: Virtual tables (`CREATE VIEW`).
- **Triggers**: Data change pe auto-action (`CREATE TRIGGER`).
- **Stored Procedures**: SQL functions save karna (`CREATE PROCEDURE`).

### Practice Tips
- MySQL Workbench ya DB-Fiddle pe try karo.
- Zyada data daalo (10+ rows) aur test karo.
- Errors try karke seekho (e.g., galat foreign key daal ke dekho).
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