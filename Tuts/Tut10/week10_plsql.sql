/*
Databases Week 10 Tutorial
week10_plsql.sql

student id: 30769140
student name: Sadeeptha Bandara
last modified date: 18/10/2021

*/

/* 1
Updates matching rows in the enrolment table whenever a unit code is updated in the 
unit table
*/
CREATE OR REPLACE TRIGGER unit_upd_cascade AFTER
    UPDATE OF unit_code ON unit
    FOR EACH ROW
BEGIN
    UPDATE enrolment
    SET
        unit_code = :new.unit_code
    WHERE
        unit_code = :old.unit_code;

    dbms_output.put_line('Unitcode change updated in enrolment table');
END;
/

/*test harness*/
/*display before value*/
SET PAGESIZE 30;

SET SERVEROUTPUT ON;

SET ECHO ON;

SELECT
    *
FROM
    unit;

SELECT
    *
FROM
    enrolment;

UPDATE unit
SET
    unit_code = 'FIT9999'
WHERE
    unit_code = 'FIT5057';

/* display after value*/
SELECT
    *
FROM
    unit;

SELECT
    *
FROM
    enrolment;

ROLLBACK;

SET ECHO OFF;


/*
2: Maintain integrity on the total number of students in a given unit
*/
CREATE OR REPLACE TRIGGER unit_stu_count AFTER
    INSERT OR DELETE ON enrolment
    FOR EACH ROW
BEGIN
    IF inserting THEN
        UPDATE unit
        SET
            unit_no_student = unit_no_student + 1
        WHERE
            unit_code = :new.unit_code;

    END IF;

    IF deleting THEN
        UPDATE unit
        SET
            unit_no_student = unit_no_student - 1
        WHERE
            unit_code = :old.unit_code;

        INSERT INTO audit_log VALUES (
            audit_seq.NEXTVAL,
            sysdate,
            user,
            :old.stu_nbr,
            :old.unit_code
        );

    END IF;

END;
/

/* Test harness*/
/* display before*/
SELECT
    *
FROM
    enrolment
WHERE
    unitcode = 'FIT9135';

SELECT
    *
FROM
    unit;

/**/
INSERT INTO enrolment VALUES (
    11111123,
    'FIT9135',
    '2020',
    '1',
    NULL,
    NULL
);

SELECT
    *
FROM
    enrolment
WHERE
    unitcode = 'FIT9135';

SELECT
    *
FROM
    unit;

DELETE FROM enrolment
WHERE
        stu_nbr = 11111123
    AND unit_code = 'FIT9135'
    AND enrol_year = '2020'
    AND enrol_semester = 1;

SELECT
    *
FROM
    enrolment
WHERE
    unitcode = 'FIT9135';

SELECT
    *
FROM
    unit;

SELECT
    *
FROM
    audit_log;

ROLLBACK;


/* Trigger to maintain student's average mark */
CREATE OR REPLACE TRIGGER maintain_average
AFTER UPDATE OR INSERT OF enrol_mark on enrolment
BEGIN
    UPDATE student SET 
    stu_avg_mark = (SELECT AVG(enrol_mark) FROM enrolment WHERE stu_nbr=student.stu_nbr ) 
END;
/


/* 3*/
CREATE OR REPLACE TRIGGER calculate_grade
BEFORE UPDATE OR INSERT OF enrol_mark ON enrolment 
FOR EACH ROW DECLARE
    final_grade enrolment.enrol_grade%TYPE;
BEGIN IF : NEW . ENROL_MARK > = 80 THEN FINAL_GRADE : = 'HD' ; ELSIF : NEW . ENROL_MARK > = 70 AND : NEW . ENROL_MARK < 80 THEN FINAL_GRADE : =
'D' ; ELSIF : NEW . ENROL_MARK > = 60 AND : NEW . ENROL_MARK < 70 THEN FINAL_GRADE : = 'C' ; ELSIF : NEW . ENROL_MARK > = 50 AND :
NEW . ENROL_MARK < 60 THEN FINAL_GRADE : = 'P' ; ELSIF : NEW . ENROL_MARK < 50 THEN FINAL_GRADE : = 'N' ; END IF ; : NEW . ENROL_GRADE : =
FINAL_GRADE ; END ;
/

--Todo: Test harness