SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE procedure_insert(A IN integer, B IN varchar2, C IN varchar2)
IS


BEGIN

	insert into supplier values(A, B, C);
	DBMS_OUTPUT.PUT_LINE('ACCOUNT CREATED');

END procedure_insert;
/


CREATE OR REPLACE FUNCTION function_search(A IN integer)
RETURN integer
IS

temp_id integer := 1;

BEGIN

    FOR t IN (SELECT sid FROM supplier) LOOP
      IF t.sid = A THEN
		 temp_id :=0;
      END IF;
    END LOOP;
	IF temp_id = 0 THEN
	   DBMS_OUTPUT.PUT_LINE('ACCOUNT ALREADY EXIST');
	END IF;
 	RETURN temp_id;
	
END function_search;
/

ACCEPT X1 integer PROMPT "ID =  "
ACCEPT Y1 CHAR PROMPT "NAME =  "
ACCEPT Z1 CHAR PROMPT "ADDRESS =  "

DECLARE

    A integer ;
    t integer := 0 ;
	B VARCHAR2(30);
	C varchar2(30);
	
BEGIN

	A :=&X1;
	B :='&Y1';
	C :='&Z1';
	
	
	t := function_search(A);
	IF t = 1 THEN
	  procedure_insert(A, B, C);
	END IF;
   
END;
/