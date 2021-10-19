--****PLEASE ENTER YOUR DETAILS BELOW****
--cgh_triggers.sql

--Student ID: 30769140
--Student Name: Sadeeptha Bandara
--Tutorial No:

/* Comments for your marker:

Trigger 2:
It is assumed that the discharge date time will not be added when initially entering the
admission. As per the spec, it is not allowed to change a discharge date once entered



*/


/*
    Trigger1
*/
CREATE OR REPLACE TRIGGER check_cost_gap BEFORE
    INSERT OR UPDATE OF adprc_pat_cost ON adm_prc
    FOR EACH ROW
DECLARE
    std_cost NUMBER;
BEGIN
    SELECT
        proc_std_cost
    INTO std_cost
    FROM
        procedure
    WHERE
        proc_code = :new.proc_code;

    IF std_cost * 1.2 < :new.adprc_pat_cost OR std_cost * 0.8 > :new.adprc_pat_cost THEN
        raise_application_error(-20000, 'The cost charged must be within a range of 20% from the standard procedure cost');
    END IF;

END;
/

/*Test Harness for Trigger1*/

-- Testing update
-- ===============================================

-- Initial State
SELECT
    adprc_no,
    adprc_pat_cost
FROM
    adm_prc
WHERE
    adprc_no = 1000;

--Updating cost greater than 20% of standard cost
UPDATE adm_prc
SET
    adprc_pat_cost = 100
WHERE
    adprc_no = 1000;

--After attempt
SELECT
    adprc_no,
    adprc_pat_cost
FROM
    adm_prc;

-- Updating cost lesser than 20% of standard cost
UPDATE adm_prc SET adprc_pat_cost = 50 WHERE adprc_no = 1000;
SELECT adprc_no, adprc_pat_cost FROM adm_prc;

-- Valid cost update: within 20%
UPDATE adm_prc SET adprc_pat_cost = 85 WHERE adprc_no = 1000;

--Final state
SELECT adprc_no, adprc_pat_cost FROM adm_prc;

ROLLBACK;

--Testing insert
-- ===============================================

--Initial state
SELECT * FROM adm_prc;

-- Inserting cost greater than 20% of standard cost
INSERT INTO adm_prc VALUES(1030, to_date('05-Aug-2021', 'dd-Mon-yyyy'), 250,  0, 100010, 15511);
SELECT * FROM adm_prc;

-- Inserting cost lesser than 20% of standard cost
INSERT INTO adm_prc VALUES(1030, to_date('05-Aug-2021', 'dd-Mon-yyyy'), 150,  0, 100010, 15511);
SELECT * FROM adm_prc;

-- Inserting valid cost: within 20%
INSERT INTO adm_prc VALUES(1030, to_date('05-Aug-2021', 'dd-Mon-yyyy'), 210,  0, 100010, 15511);
SELECT * FROM adm_prc;

ROLLBACK;


/*
    Trigger2
*/
CREATE OR REPLACE TRIGGER discharge_trigger BEFORE
    UPDATE OF adm_discharge ON admission
    FOR EACH ROW
DECLARE
    adm_procedure_cost NUMBER;
    last_proc_date DATE;
BEGIN
    IF :old.adm_discharge IS NOT NULL THEN
        raise_application_error(-20000, 'Discharge date and time cannot be changed');
    END IF;
    
    SELECT max(adprc_date_time) INTO last_proc_date FROM adm_prc WHERE adm_no = :new.adm_no;

    IF :new.adm_discharge - :new.adm_date_time < 0 THEN
        raise_application_error(-20000, 'Discharge date cannot be before admission date');
    ELSIF
     :new.adm_discharge - last_proc_date < 0 THEN
        raise_application_error(-20000, 'Discharge date cannot be before the date of the last procedure');
    END IF;
    
    SELECT
        SUM(adprc_pat_cost + adprc_items_cost) 
    INTO adm_procedure_cost
    FROM
        adm_prc
    WHERE
        adm_no = :new.adm_no AND adprc_date_time > :new.adm_date_time;
        
    :new.adm_total_cost := adm_procedure_cost + 50;

    DBMS_OUTPUT.PUT_LINE('Discharge successful. Admission total cost calculated and updated');
END;
/

/*Test Harness for Trigger2*/








