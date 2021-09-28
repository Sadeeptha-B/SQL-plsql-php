SET ECHO ON

SPOOL week7_insert_output.txt

/*
Databases Week 7 Tutorial
week7_insert.sql

Author:
    Sadeeptha Bandara
Created : 28th September 2021    
*/

/*7.3.1: Basic Insert*/

/*- student table*/
INSERT INTO student VALUES (
    11111111,
    'Bloggs',
    'Fred',
    TO_DATE('01-Jan-2003', 'dd-Mon-yyyy')
);

INSERT INTO student VALUES (
    11111112,
    'Nice',
    'Nick',
    TO_DATE('10-Oct-2004', 'dd-Mon-yyyy')
);

INSERT INTO student VALUES (
    11111113,
    'Wheat',
    'Wendy',
    TO_DATE('05-May-2005', 'dd-Mon-yyyy')
);

INSERT INTO student VALUES (
    11111114,
    'Sheen',
    'Cindy',
    TO_DATE('25-Dec-2004', 'dd-Mon-yyyy')
);


/* unit table */
INSERT INTO unit VALUES (
    'FIT9999',
    'FIT Last Unit'
);

INSERT INTO unit VALUES (
    'FIT9132',
    'Introduction to Databases'
);

INSERT INTO unit VALUES (
    'FIT9161',
    'Project'
);

INSERT INTO unit VALUES (
    'FIT5111',
    'Student''s Life'
);


/*enrolment table */
INSERT INTO enrolment VALUES (
    11111111,
    'FIT9132',
    2020,
    '1',
    35,
    'N'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT9161',
    2020,
    '1',
    61,
    'C'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT9132',
    2020,
    '2',
    42,
    'N'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT5111',
    2020,
    '2',
    76,
    'D'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT9132',
    2021,
    '1',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111112,
    'FIT9132',
    2020,
    '2',
    83,
    'HD'
);

INSERT INTO enrolment VALUES (
    11111112,
    'FIT9161',
    2020,
    '2',
    79,
    'D'
);

INSERT INTO enrolment VALUES (
    11111113,
    'FIT9132',
    2021,
    '1',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111113,
    'FIT5111',
    2021,
    '1',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111114,
    'FIT9132',
    2021,
    '1',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111114,
    'FIT5111',
    2021,
    '1',
    NULL,
    NULL
);

COMMIT;

/*7.3.2: Using Sequence
*/
DROP SEQUENCE student_seq;

CREATE SEQUENCE student_seq START WITH 11111115 INCREMENT BY 1;

SELECT
    *
FROM
    cat;

/* Add student*/
INSERT INTO student VALUES (
    student_seq.NEXTVAL,
    'Mouse',
    'Mickey',
    TO_DATE('21-Oct-1999', 'dd-Mon-yyyy')
);

SELECT
    *
FROM
    student;

/*Add enrolment*/
INSERT INTO enrolment VALUES (
    student_seq.CURRVAL,
    'FIT9132',
    2021,
    '1',
    NULL,
    NULL
);

COMMIT;

SELECT * FROM enrolment;

SPOOL OFF

SET ECHO OFF