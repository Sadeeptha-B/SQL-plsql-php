/*
Databases Week 10 Tutorial
week10_plsql.sql

student id: 30769140
student name: Sadeeptha Bandara
last modified date: 18/10/2021

*/

--1
CREATE OR REPLACE TRIGGER unit_upd_cascade
AFTER UPDATE OF unit_code ON unit
FOR EACH ROW
BEGIN
    UPDATE enrolment
    SET unit_code = :new.unit_code
    WHERE unit_code = :old.unit_code;
    DBMS_OUTPUT.PUT_LINE('Unitcode change updated in enrolment table');
END;
/

--test harness
--display before value
set pagesize 30;
set serveroutput on;
set echo on;

SELECT * FROM unit;
SELECT * FROM enrolment;

UPDATE unit SET unit_code = 'FIT9999' WHERE unit_code = 'FIT5057';

-- dispaly after value
SELECT * FROM unit;
SELECT * FROM enrolment;

ROLLBACK;
set echo off;


--2
CREATE OR REPLACE TRIGGER unit_stu_count 
AFTER INSERT OR DELETE ON enrolment
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE unit
        SET unit_no_student = unit_no_student + 1
        WHERE unit_code = :new.unit_code;
    END IF; 
    IF DELETING THEN
        UPDATE unit
        SET unit_no_student = unit_no_student - 1
        WHERE unit_code = :old.unit_code;
        
        INSERT INTO audit_log VALUES (audit_seq.nextval, SYSDATE, USER, :old.stu_nbr, :old.unit_code);
    END IF;
END;
/

