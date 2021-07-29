clear screen;

--delete existing table
drop table tennis1;

--Create tennis1 database
create table tennis1(
	id integer, 
	outlook varchar2(30), 
	temp varchar2(30),
	humidity varchar2(30),
	wind varchar2(30),
	play varchar2(30),
	PRIMARY KEY (id)
);

--Insert data into tennis1 database
Insert into tennis1 values(1,'Sunny','Hot','High','Weak','No');
Insert into tennis1 values(2,'Sunny','Hot','High','Strong','No');
Insert into tennis1 values(3,'Overcast','Hot','High','Weak','Yes');
Insert into tennis1 values(4,'Rain','Mild','High','Weak','Yes');
Insert into tennis1 values(5,'Rain','Cool','Normal','Weak','Yes');
Insert into tennis1 values(6,'Rain','Cool','Normal','Strong','No');
Insert into tennis1 values(7,'Overcast','Cool','Normal','Strong','Yes');
Insert into tennis1 values(8,'Sunny','Mild','High','Weak','No');

commit;

CREATE OR REPLACE TRIGGER ON_INSERT
AFTER INSERT 
ON tennis1
FOR EACH ROW
BEGIN
	DBMS_OUTPUT.PUT_LINE('TRIGGER: NEW ROW ADDED IN "tennis1" TABLE');
END;
/

select * from tennis1;