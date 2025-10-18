CREATE TABLE STUDENT(
  student_id INTEGER PRIMARY KEY,
  name varchar(200),
  age INTEGER,
  address varchar(200),
  location varchar(100),
  phone_number varchar(100)
);



INSERT INTO STUDENT VALUES (1, 'ABC',20 , 'ABC', 'New Delhi','8287823966');
INSERT INTO STUDENT VALUES (2, 'BVA',24, 'ABC', 'Rajasthan','8287823966');
INSERT INTO STUDENT VALUES (3, 'Aman',21, 'ABC', 'UP','8287823966');


select * from STUDENT;



-- create
CREATE TABLE COURSES (
  course_id INTEGER PRIMARY KEY,
  name varchar(100) NOT NULL,
  student_id INTEGER,
  FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

-- insert
INSERT INTO COURSES VALUES (0001, 'DSA', 1);
INSERT INTO COURSES VALUES (0002, 'Python', 2);
INSERT INTO COURSES VALUES (0003, 'DS', 1);

-- fetch 
SELECT * FROM COURSES ;



SELECT s.student_id,c.course_id from STUDENT s inner join COURSES c on s.student_id=c.student_id where s.age>20;



SELECT s.student_id,s.name,age,c.course_id from STUDENT s inner join COURSES c on s.student_id=c.student_id where s.age<25;



SELECT s.name,c.course_id,c.name from STUDENT s inner join COURSES c on s.student_id=c.student_id;


SELECT s.name from STUDENT s inner join COURSES c on s.student_id=c.student_id where age>15 and c.course_id=2;