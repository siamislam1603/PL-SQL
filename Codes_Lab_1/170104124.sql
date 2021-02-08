clear screen;
/* Multiline
	comment*/
drop table flights;
drop table aircraft;
drop table certified;
drop table employees;

--Task a

create table flights(
fno BINARY_FLOAT PRIMARY KEY, 
from_ varchar2(40),
to_ varchar2(40),
distance number(38),
departs TIMESTAMP(0),
arrives TIMESTAMP(0),
price number(38,2)
);

create table aircraft(
aid number PRIMARY KEY,
aname varchar2(40),
cruisingrange number(38)
);

create table certified(
eid number(38),
aid number(38)
);

create table employees(
eid number PRIMARY KEY,
ename varchar2(40),
salary number(38)
);

describe flights;
describe aircraft;
describe employees;

INSERT INTO flights VALUES(1.1,'Los Angeles','Honolulu',100,TIMESTAMP '2015-12-11 10:30:00',TIMESTAMP '2015-12-14 10:30:00',22000.50);
INSERT INTO flights VALUES(2.1,'Honolulu','California',100,TIMESTAMP '2015-12-10 10:30:00',TIMESTAMP '2015-12-11 10:30:00',21000.50);
INSERT INTO flights VALUES(3.1,'Los Angeles','Honolulu',100,TIMESTAMP '2015-12-11 10:30:00',TIMESTAMP '2015-12-12 10:30:00',26000.50);
INSERT INTO flights VALUES(4.1,'Honolulu','California',100,TIMESTAMP '2015-12-12 10:30:00',TIMESTAMP '2015-12-13 10:30:00',28000.50);
INSERT INTO flights VALUES(5.1,'Los Angeles','Honolulu',100,TIMESTAMP '2015-12-11 10:30:00',TIMESTAMP '2015-12-14 10:30:00',20000.50);
INSERT INTO flights VALUES(6.1,'Los Angeles','Honolulu',100,TIMESTAMP '2015-12-11 10:30:00',TIMESTAMP '2015-12-14 10:30:00',22500.50);
INSERT INTO flights VALUES(7.1,'Honolulu','California',100,TIMESTAMP '2015-12-11 10:30:00',TIMESTAMP '2015-12-14 10:30:00',23000.50);
INSERT INTO flights VALUES(8.1,'Los Angeles','Honolulu',100,TIMESTAMP '2015-12-11 10:30:00',TIMESTAMP '2015-12-14 10:30:00',28000.50);
INSERT INTO flights VALUES(9.1,'Honolulu','California',100,TIMESTAMP '2015-12-11 10:30:00',TIMESTAMP '2015-12-14 10:30:00',27000.50);

INSERT INTO employees VALUES(1,'Hamid',11000);
INSERT INTO employees VALUES(2,'Akbar', 20800);
INSERT INTO employees VALUES(3,'Tom',35000);
INSERT INTO employees VALUES(4,'Leonardo',50000);
INSERT INTO employees VALUES(5,'Huge',90000);
INSERT INTO employees VALUES(6,'John',77000);
INSERT INTO employees VALUES(7,'Jennifer',100000);
INSERT INTO employees VALUES(8,'Michae1l',18000);
INSERT INTO employees VALUES(9,'Steven', 65000);

INSERT INTO aircraft VALUES(1,'Boeing F-22',880);
INSERT INTO aircraft VALUES(2,'Chengdu J-20',890);
INSERT INTO aircraft VALUES(3,'Boeing F-34',1100);
INSERT INTO aircraft VALUES(4,'Eurofighter Typhoon',910);
INSERT INTO aircraft VALUES(5,'Flanker-H',1200);
INSERT INTO aircraft VALUES(6,'Lockheed Martin',885);
INSERT INTO aircraft VALUES(7,'Sukhoi Su-35',1897);
INSERT INTO aircraft VALUES(8,'Super Hornet',912);
INSERT INTO aircraft VALUES(9,'Strike Eagle',1926);

INSERT INTO certified VALUES(1,9);
INSERT INTO certified VALUES(2,8);
INSERT INTO certified VALUES(3,7);
INSERT INTO certified VALUES(4,5);
INSERT INTO certified VALUES(5,6);
INSERT INTO certified VALUES(6,4);
INSERT INTO certified VALUES(7,3);
INSERT INTO certified VALUES(8,2);
INSERT INTO certified VALUES(9,1);

select * from employees;
select * from aircraft;
select * from flights;

-- Task b
/* 1.Find the names of pilots whose salary is less than the price of the
cheapest route from Los Angeles to Honolulu. */

select distinct ename from employees where 
salary<(select min(price) from flights where
		from_='Los Angeles' and to_='Honolulu');

/* 2. Find the names of pilots certified for some Boeing aircraft. */

select distinct ename from employees e,certified c,aircraft a where
	e.eid=c.eid and c.aid=a.aid and a.aname like 'Boeing%';  
	
/* 3. Print the names of employees who are certified only on aircrafts with
cruising range longer than 1000 miles, but on at least two such aircrafts. */

select e.ename from employees e
Inner Join certified c
on e.eid=c.eid
Inner Join aircraft a
on c.aid=a.aid where a.cruisingrange>1000;


commit;