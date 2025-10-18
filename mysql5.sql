CREATE TABLE DEPARTMENT(
  dept_id INTEGER PRIMARY KEY,
  dept_name varchar(200),
  location varchar(100)
);



INSERT INTO DEPARTMENT VALUES (1, 'MCA', 'New Delhi');
INSERT INTO DEPARTMENT VALUES (2, 'BCA', 'Rajasthan');
INSERT INTO DEPARTMENT VALUES (3, 'MSc', 'UP');


select * from DEPARTMENT;



-- create
CREATE TABLE EMPLOYEE (
  emp_id INTEGER PRIMARY KEY,
  name varchar(100) NOT NULL,
  dept_id INTEGER,
  FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
);

-- insert
INSERT INTO EMPLOYEE VALUES (0001, 'Arbaaz khan', 1);
INSERT INTO EMPLOYEE VALUES (0002, 'Vanshu', 2);
INSERT INTO EMPLOYEE VALUES (0003, 'Viv', 1);

-- fetch 
SELECT * FROM EMPLOYEE ;






SELECT e.emp_id,e.name,dept_name from EMPLOYEE e natural join DEPARTMENT d;





-- Perform natural join on two tables 

-- Natural Join :- a Natural join is a sql operation that joins two table based on all columns with the same name and same datatype in both tables
-- It only returns rows where the values in these common columns match


SELECT e.emp_id, e.name, d.dept_name
FROM EMPLOYEE e
NATURAL JOIN DEPARTMENT d;