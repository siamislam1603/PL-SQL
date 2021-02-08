SET VERIFY OFF;
SET SERVEROUTPUT ON;
DECLARE
choice varchar2(20):='&Choice';
count_row money.id%TYPE;
tk money.taka%TYPE := 0;
sum_tk money.taka%TYPE := 0;

BEGIN
	select count(id) into count_row from money;
	IF choice='INSERT' THEN
		IF count_row>7 THEN
			insert into money values(count_row+1,'C',200);
		END IF;
		IF count_row<=7 THEN
			insert into money values(count_row+1,'C',100);
		END IF;
	END IF;
	IF choice='SHOW' THEN
		for i in 1..count_row LOOP
			select taka into tk from money where id=i;
			sum_tk := sum_tk+tk;
		END LOOP;
		DBMS_OUTPUT.PUT_LINE(sum_tk);
	END IF;
END;
/
commit;
select * from money;