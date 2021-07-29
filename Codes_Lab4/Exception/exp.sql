SET SERVEROUTPUT ON;
SET VERIFY OFF;

DECLARE
	A money.taka%TYPE;
	B number := &x;
	res number;
	shibli EXCEPTION;
BEGIN
	
	SELECT taka into A from money where ID=1;
	
	IF B < 0 THEN
		RAISE shibli;
	END IF;
	
	res := A/B;
	
	
EXCEPTION
	WHEN shibli THEN
		DBMS_OUTPUT.PUT_LINE('cannot be -ve');
		B := B*(-1);
		res := A/B;
		DBMS_OUTPUT.PUT_LINE(res);
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('Many rows detected');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Data not found');
	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE('cannot divide by zero');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other errors');
END;
/