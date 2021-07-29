clear screen;

--delete existing table
drop table tennis2;

--Create tennis1 database
create table tennis2(
	id integer, 
	outlook varchar2(30), 
	temp varchar2(30),
	humidity varchar2(30),
	wind varchar2(30),
	play varchar2(30),
	PRIMARY KEY (id)
);

--Insert data into tennis1 database
Insert into tennis2 values(9,'Sunny','Cool','Normal','Weak','Yes');
Insert into tennis2 values(10,'Rain','Mild','Normal','Weak','Yes');
Insert into tennis2 values(11,'Sunny','Mild','Normal','Strong','Yes');
Insert into tennis2 values(12,'Overcast','Mild','High','Strong','Yes');
Insert into tennis2 values(13,'Overcast','Hot','Normal','Weak','Yes');
Insert into tennis2 values(14,'Rain','Mild','High','Strong','No');

commit;

CREATE OR REPLACE TRIGGER ON_INSERT
AFTER INSERT
ON tennis2
FOR EACH ROW
BEGIN
	DBMS_OUTPUT.PUT_LINE('TRIGGER: NEW ROW ADDED IN "tennis2" TABLE');
END;
/
select * from tennis2;