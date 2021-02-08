SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
t_taka money.taka%TYPE;
count_id money.id%TYPE;
NUM int := 0;
BEGIN
	select max(taka) into t_taka from money;
	select count(id) into count_id from money;
	IF MOD(t_taka,3)=0 THEN
		DBMS_OUTPUT.PUT_LINE(t_taka || '%3=0');
	ELSIF MOD(t_taka,3)=1 THEN
		DBMS_OUTPUT.PUT_LINE(t_taka || '%3=1');
	ELSE
		DBMS_OUTPUT.PUT_LINE(t_taka || '%3=2');
	END IF;
	update money set taka=t_taka where id=2;
	NUM:=5;
	for i IN 1..NUM LOOP
		INSERT INTO MONEY values(count_id+i,'D',t_taka+i*5);
	END LOOP;
END;
/
commit;
select * from money;

DECLARE
name varchar2(10):='&NAME';
address varchar2(10):='&ADDRESS';
BEGIN
	DBMS_OUTPUT.PUT_LINE(name || ' ' || address);
END;
/

--TASK 1
DECLARE
A MONEY.TAKA%TYPE:=&A;
B MONEY.TAKA%TYPE:=&B;
C MONEY.TAKA%TYPE:=A+B;
BEGIN
	IF C<170 THEN
		INSERT INTO MONEY VALUES(7,'A',C+10);
	ELSIF (C>170 AND C<210) THEN
		INSERT INTO MONEY VALUES(7,'B',C+30);
	ELSE
		INSERT INTO MONEY VALUES(7,'C',C);
	END IF;
END;
/
SELECT * FROM MONEY;