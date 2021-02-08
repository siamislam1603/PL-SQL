SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION mytest
RETURN money.taka%TYPE
IS

A money.id%TYPE;
B money.taka%TYPE;
C money.taka%TYPE;

BEGIN
	C := 0;
	FOR R IN (SELECT * FROM money) LOOP
		A := R.id;
		B := R.taka;
		C := C + B;
	END LOOP;
	return C;
END mytest;
/
