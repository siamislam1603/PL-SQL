SET SERVEROUTPUT ON;
SET VERIFY OFF;

DROP TABLE ENTROPY;
DROP TABLE EDGE;
CREATE TABLE ENTROPY(ID VARCHAR2(32),ENT NUMBER);
CREATE TABLE EDGE(SRC VARCHAR2(32),DEST VARCHAR2(32),WT VARCHAR2(32));
CREATE OR REPLACE PACKAGE DECISION_TREE AS
	FUNCTION ENTROPY_CLASS(LEN_TRAINING_SET IN NUMBER,P_YES IN OUT NUMBER)
	RETURN NUMBER;
	
	PROCEDURE FIT;
END DECISION_TREE;
/
CREATE OR REPLACE PACKAGE BODY DECISION_TREE AS
	PROCEDURE FIT
	AS
		LEN_TRAINING_SET NUMBER;
		E_D NUMBER;
		OUTLOOK_VISITED INT:=0;
		TEMP_VISITED INT:=0;
		HUMIDITY_VISITED INT:=0;
		WIND_VISITED INT:=0;
		LEN_ATR NUMBER;
		MIN_ENTROPY NUMBER:=10;
		S NUMBER:=0;
		E NUMBER:=0;
		P_YES NUMBER;
		ROOT_NODE VARCHAR2(32);
	BEGIN
		SELECT COUNT(ID) INTO LEN_TRAINING_SET FROM TRAINING_SET;
		SELECT COUNT(ID) INTO P_YES FROM TRAINING_SET where PLAY='Yes';
		E_D:=ENTROPY_CLASS(LEN_TRAINING_SET,P_YES);
		IF OUTLOOK_VISITED=0 THEN
			FOR VAL IN (SELECT DISTINCT(OUTLOOK) FROM TRAINING_SET) LOOP
				SELECT COUNT(ID) INTO LEN_ATR FROM TRAINING_SET WHERE OUTLOOK=VAL.OUTLOOK;
				SELECT COUNT(ID) INTO P_YES FROM TRAINING_SET
				where PLAY='Yes' AND OUTLOOK=VAL.OUTLOOK;
				E:=E+(LEN_ATR/LEN_TRAINING_SET)*ENTROPY_CLASS(LEN_ATR,P_YES);
			END LOOP;
			INSERT INTO ENTROPY VALUES('OUTLOOK',E);
			E:=0;
		END IF;
		IF TEMP_VISITED=0 THEN
			FOR VAL IN (SELECT DISTINCT(TEMP) FROM TRAINING_SET) LOOP
				SELECT COUNT(ID) INTO LEN_ATR FROM TRAINING_SET WHERE TEMP=VAL.TEMP;
				SELECT COUNT(ID) INTO P_YES FROM TRAINING_SET
				where PLAY='Yes' AND TEMP=VAL.TEMP;
				E:=E+(LEN_ATR/LEN_TRAINING_SET)*ENTROPY_CLASS(LEN_ATR,P_YES);
			END LOOP;
			INSERT INTO ENTROPY VALUES('TEMP',E);
			E:=0;
		END IF;
		IF HUMIDITY_VISITED=0 THEN
			FOR VAL IN (SELECT DISTINCT(HUMIDITY) FROM TRAINING_SET) LOOP
				SELECT COUNT(ID) INTO LEN_ATR FROM TRAINING_SET WHERE HUMIDITY=VAL.HUMIDITY;
				SELECT COUNT(ID) INTO P_YES FROM TRAINING_SET
				where PLAY='Yes' AND HUMIDITY=VAL.HUMIDITY;
				E:=E+(LEN_ATR/LEN_TRAINING_SET)*ENTROPY_CLASS(LEN_ATR,P_YES);
			END LOOP;
			INSERT INTO ENTROPY VALUES('HUMIDITY',E);
			E:=0;
		END IF;
		IF WIND_VISITED=0 THEN
			FOR VAL IN (SELECT DISTINCT(WIND) FROM TRAINING_SET) LOOP
				SELECT COUNT(ID) INTO LEN_ATR FROM TRAINING_SET WHERE WIND=VAL.WIND;
				SELECT COUNT(ID) INTO P_YES FROM TRAINING_SET
				where PLAY='Yes' AND WIND=VAL.WIND;
				E:=E+(LEN_ATR/LEN_TRAINING_SET)*ENTROPY_CLASS(LEN_ATR,P_YES);
			END LOOP;
			INSERT INTO ENTROPY VALUES('WIND',E);
			E:=0;
		END IF;
		COMMIT;
		FOR I IN (SELECT ID FROM ENTROPY WHERE ENT=(SELECT MIN(ENT) FROM ENTROPY)) LOOP
			IF (I.ID='OUTLOOK') THEN
				OUTLOOK_VISITED:=1;
			ELSIF (I.ID='TEMP') THEN
				TEMP_VISITED:=1;
			ELSIF (I.ID='HUMIDITY') THEN
				HUMIDITY_VISITED:=1;
			ELSIF (I.ID='WIND') THEN
				WIND_VISITED:=1;
			END IF;
			DBMS_OUTPUT.PUT_LINE('ROOT NODE: '||I.ID);
		END LOOP;
	END FIT;
	
	FUNCTION ENTROPY_CLASS(LEN_TRAINING_SET IN NUMBER,P_YES IN OUT NUMBER)
	RETURN NUMBER IS
		E_D NUMBER;
		P_NO NUMBER;
	BEGIN
		P_YES:=P_YES/LEN_TRAINING_SET;
		P_NO:=1-P_YES;
		IF P_YES=1 OR P_NO=1 THEN
			RETURN 0;
		ELSE
			E_D:=-((P_YES*LOG(2,P_YES))+(P_NO*LOG(2,P_NO)));
			RETURN E_D;
		END IF;
	END ENTROPY_CLASS;
	
END DECISION_TREE;
/