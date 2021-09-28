SET ECHO ON

SPOOL week7_altertable_output.txt

/*
Databases Week 7 Tutorial
week7_altertable.sql

Author:
    Sadeeptha Bandara
Created : 28th September 2021    
*/

ALTER TABLE unit ADD unit_credit NUMBER(2, 0) DEFAULT 6 NOT NULL;

INSERT INTO unit VALUES (
    'FIT2102',
    'Programming Paradigms',
    12
);

COMMIT;

SELECT
    *
FROM
    unit;

SPOOL OFF

SET ECHO OFF