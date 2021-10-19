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
    adm_procedure_cost  NUMBER;
    last_proc_date      DATE;
BEGIN
    /* Not allowing discharge time to be updated*/
    IF :old.adm_discharge IS NOT NULL THEN
        raise_application_error(-20000, 'Discharge date and time cannot be changed');
    END IF;

    /* Finding date of last procedure*/
    SELECT
        MAX(adprc_date_time)
    INTO last_proc_date
    FROM
        adm_prc
    WHERE
        adm_no = :new.adm_no;

    /* Checking if discharge date is valid*/
    IF :new.adm_discharge - :new.adm_date_time < 0 THEN
        raise_application_error(-20000, 'Discharge date cannot be before admission date');
    ELSIF :new.adm_discharge - last_proc_date < 0 THEN
        raise_application_error(-20000, 'Discharge date cannot be before the date of the last procedure');
    END IF;

    /* Computing total cost for procedures including item costs*/
    SELECT
        SUM(adprc_pat_cost + adprc_items_cost)
    INTO adm_procedure_cost
    FROM
        adm_prc
    WHERE
            adm_no = :new.adm_no
        AND adprc_date_time > :new.adm_date_time;

    /* Total admission cost*/
    :new.adm_total_cost := adm_procedure_cost + 50;
    dbms_output.put_line('Discharge successful. Admission total cost calculated and updated');
END;
/

/*Test Harness for Trigger2*/

-- Admission with an already filled discharge date
-- ====================================================
-- Initial State
SELECT adm_no, adm_date_time, adm_discharge FROM admission WHERE adm_no = 100010;

-- Attempting to update
UPDATE admission SET adm_discharge = to_date('21-Oct-2021', 'dd-Mon-yyyy') WHERE adm_no = 100010; 

-- After attempt
SELECT adm_no, adm_date_time, adm_discharge FROM admission WHERE adm_no = 100010;


-- Attempt to add a discharge date earlier than admission date
-- ======================================================
-- Initial State (Admission with no discharge date)
SELECT adm_no, adm_date_time, adm_discharge FROM admission WHERE adm_no = 100280;

-- Attempting to update
UPDATE admission SET adm_discharge = to_date('01-Apr-2021', 'dd-Mon-yyyy') WHERE adm_no = 100280; 

-- After attempt
SELECT adm_no, adm_date_time, adm_discharge FROM admission WHERE adm_no = 100280;


-- Attempt to add a discharge date earlier than the last procedure
-- ======================================================================
-- Creating test procedures for admission no 100280
INSERT INTO adm_prc VALUES(1030, to_date('15-Oct-2021', 'dd-Mon-yyyy'), 210,  0, 100280, 15511);
INSERT INTO adm_prc VALUES(1040, to_date('16-Oct-2021', 'dd-Mon-yyyy'), 210,  0, 100280, 15511);

-- Initial State: the last procedure date and the admission value (Admission with no discharge date)
SELECT adm_no, MAX(adprc_date_time) FROM adm_prc WHERE adm_no = 100280 GROUP BY adm_no;

-- Attempting to update
UPDATE admission SET adm_discharge = to_date('14-Oct-2021', 'dd-Mon-yyyy') WHERE adm_no = 100280; 

-- After attempt
SELECT adm_no, adm_date_time, adm_discharge FROM admission WHERE adm_no = 100280;


-- Add valid discharge date
-- ===================================
-- Initial State
SELECT adm_no, adm_date_time, adm_discharge FROM admission WHERE adm_no = 100280;

-- Attempting to update
UPDATE admission SET adm_discharge = to_date('21-Oct-2021', 'dd-Mon-yyyy') WHERE adm_no = 100280; 

-- After attempt
SELECT adm_no, adm_date_time, adm_discharge FROM admission WHERE adm_no = 100280;

ROLLBACK;

-- Calculating admission total cost
-- =======================================================================

-- For a patient who has done procedures
-- ++++++++++++++++++++++++++++++++++++++

-- Creating test procedures for admission no 100280
-- Total cost for procedures = 210 + 210 + 20 + 10 = 450
INSERT INTO adm_prc VALUES(1030, to_date('15-Oct-2021', 'dd-Mon-yyyy'), 210,  20, 100280, 15511);
INSERT INTO adm_prc VALUES(1040, to_date('16-Oct-2021', 'dd-Mon-yyyy'), 210,  10, 100280, 15511);

-- Initial state
SELECT adm_no, COUNT(adprc_date_time) FROM adm_prc WHERE adm_no = 100280 GROUP BY adm_no;
SELECT adm_no, adm_total_cost FROM admission WHERE adm_no = 100280;

-- Updating admission with valid discharge date
UPDATE admission SET adm_discharge = to_date('21-Oct-2021', 'dd-Mon-yyyy') WHERE adm_no = 100280; 

-- After update
-- Total final cost = total procedure cost + admin cost = 450 + 50 = 500
SELECT adm_no, adm_total_cost FROM admission WHERE adm_no = 100280;

ROLLBACK;

-- For a patient that did not undergo any procedure
SELECT adm_no, COUNT(adprc_date_time) FROM adm_prc WHERE adm_no = 100280 GROUP BY adm_no;

-- Initial total cost (null)
SELECT adm_no, adm_total_cost FROM admission WHERE adm_no = 100280;

-- Updating admission with valid discharge date
UPDATE admission SET adm_discharge = to_date('21-Oct-2021', 'dd-Mon-yyyy') WHERE adm_no = 100280; 

-- After update
SELECT adm_no, adm_total_cost FROM admission WHERE adm_no = 100280;

ROLLBACK;