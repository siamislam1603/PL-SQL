clear screen;
drop table test;
CREATE TABLE test
(id NUMBER PRIMARY KEY,
name VARCHAR2(30));
CREATE SEQUENCE test_sequence
START WITH 1
INCREMENT BY 1;

INSERT INTO test (name) VALUES ('Jon');
INSERT INTO test (name) VALUES (’Bork’);
INSERT INTO test (name) VALUES (’Matt’);
SELECT * FROM test;
/*
INSERT INTO CUSTOMER VALUES (1000, 'Rahman', 'Karim', 1203, 'Dhaka','01912584949');
INSERT INTO CUSTOMER VALUES ('Rahman', 'Karim', 1203, 'Dhaka','01912584949');

INSERT INTO CUSTOMER (LastName, FirstName, AreaCode, Address, Phone)
VALUES ('Khan', 'Rahim', 1307, 'Gulshan', '01677515829');

INSERT INTO CUSTOMER (LastName, FirstName)
VALUES ('Ahmed', 'Hashim');

ALTER TABLE CUSTOMER
ADD CustomerSince date;

ALTER TABLE CUSTOMER
DROP COLUMN CustomerSince;

ALTER TABLE CUSTOMER
ALTER COLUMN CustomerSince datetime;

INSERT INTO CUSTOMER (LastName, FirstName, AreaCode, Address, Phone, CustomerSince) 
VALUES ('Ema', 'Mahzabeen', 1209, 'Dhanmondi', '01677515829', '1994-05-18'); 

INSERT INTO CUSTOMER (LastName, FirstName, AreaCode, Address, Phone, CustomerSince) 
VALUES ('Ema', 'Mahzabeen', 1307, 'Gulshan', '01677515829', '1994-05-18 23:59:59');
*/