--****PLEASE ENTER YOUR DETAILS BELOW****
--cgh_triggers.sql

--Student ID: 30769140
--Student Name: Sadeeptha Bandara
--Tutorial No:

/* Comments for your marker:




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
/*Please copy your trigger code with a slash(/) followed by an empty line after this line*/









/*Test Harness for Trigger2*/
/*Please copy SQL statements for Test Harness after this line*/