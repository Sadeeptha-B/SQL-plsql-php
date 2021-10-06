/*T2-ml-insert.sql*/

/*Student ID: 30769140*/
/*Student Name: Sadeeptha Bandara*/
/*Tutorial No: 6 (Activity 2 as per Allocate+*/

/* Comments for your marker:

The data for the BOOK_COPY table
----------------------------------
   10 records overall
   Represents 4 different book details: 005.74 D691D, 112.6 S874D, 005.432 L761P
   823.914 H219A.
   distributed across 3 different libraries: branch codes 10, 13, 12
   one library holding multiple copies of a book: Branch code 10 has two copies of
   112.6 S874D
   1 copy on counter reserve: Branch 10 bc_id 3

The data for the LOAN table
----------------------------------
    10 records overall
    8 loans have been returned by the dure date. 
        1 is returned late: bc_id 2 from branch 13, loaned on 23rd Jun 2021 
                                at 04:12:41 PM
        1 is still due: bc_id 4 from branch 12 loaned on 21st Aug at 11:13:19 AM
    borrowed from 2 libraries: branch codes 12 and 13
    borrowed by 4 borrowers: bor_no 4,1,5,3

2 RESERVE entries
-----------------------------------
   bc_id 2 in branch 10, bc_id 3 in branch 12

*/

/* 2 (a) Load the BOOK_COPY, LOAN and RESERVE tables with your own*/
/* test data following the data requirements expressed in the brief*/

/*book_copy table*/
INSERT INTO book_copy VALUES (
    10,
    1,
    100,
    'N',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    10,
    2,
    100,
    'N',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    10,
    3,
    120,
    'Y',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    13,
    1,
    90,
    'N',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    13,
    2,
    110,
    'N',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    13,
    3,
    180,
    'N',
    '823.914 H219A'
);

INSERT INTO book_copy VALUES (
    12,
    1,
    95,
    'N',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    12,
    2,
    100,
    'N',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    12,
    3,
    120,
    'N',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    12,
    4,
    180,
    'N',
    '823.914 H219A'
);

/*loan table*/
INSERT INTO loan VALUES (
    12,
    1,
    TO_DATE('03-Jun-2021 01:32:24 PM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('17-Jun-2021', 'dd-Mon-yyyy'),
    TO_DATE('05-Jun-2021', 'dd-Mon-yyyy'),
    4
);

INSERT INTO loan VALUES (
    12,
    2,
    TO_DATE('04-Jul-2021 03:23:16 PM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('18-Jul-2021', 'dd-Mon-yyyy'),
    TO_DATE('08-Jul-2021', 'dd-Mon-yyyy'),
    1
);

INSERT INTO loan VALUES (
    12,
    3,
    TO_DATE('02-Aug-2021 10:06:01 AM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('16-Aug-2021', 'dd-Mon-yyyy'),
    TO_DATE('08-Aug-2021', 'dd-Mon-yyyy'),
    4
);

INSERT INTO loan VALUES (
    12,
    4,
    TO_DATE('21-Aug-2021 11:13:19 AM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('04-Sep-2021', 'dd-Mon-yyyy'),
    NULL,
    5
);

INSERT INTO loan VALUES (
    12,
    2,
    TO_DATE('25-Jul-2021 03:20:29 PM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('08-Aug-2021', 'dd-Mon-yyyy'),
    TO_DATE('06-Aug-2021', 'dd-Mon-yyyy'),
    1
);

INSERT INTO loan VALUES (
    13,
    1,
    TO_DATE('21-Jul-2021 09:41:28 AM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('04-Aug-2021', 'dd-Mon-yyyy'),
    TO_DATE('28-Jul-2021', 'dd-Mon-yyyy'),
    5
);

INSERT INTO loan VALUES (
    13,
    2,
    TO_DATE('23-Jun-2021 04:12:41 PM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('07-Jul-2021', 'dd-Mon-yyyy'),
    TO_DATE('09-Jul-2021', 'dd-Mon-yyyy'),
    4
);

INSERT INTO loan VALUES (
    13,
    3,
    TO_DATE('14-Aug-2021 05:25:13 PM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('28-Aug-2021', 'dd-Mon-yyyy'),
    TO_DATE('16-Jul-2021', 'dd-Mon-yyyy'),
    3
);

INSERT INTO loan VALUES (
    13,
    2,
    TO_DATE('06-Jun-2021 03:14:14 AM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('20-Jun-2021', 'dd-Mon-yyyy'),
    TO_DATE('20-Jun-2021', 'dd-Mon-yyyy'),
    1
);

INSERT INTO loan VALUES (
    13,
    1,
    TO_DATE('09-Jul-2021 11:27:56 AM', 'dd-Mon-yyyy hh:mi:ss PM'),
    TO_DATE('23-Jul-2021', 'dd-Mon-yyyy'),
    TO_DATE('21-Jul-2021', 'dd-Mon-yyyy'),
    3
);



/* reserve table*/
INSERT INTO reserve VALUES (
    1,
    10,
    2,
    TO_DATE('05-Jul-2021 5:31:01 PM', 'dd-Mon-yyyy hh:mi:ss PM'),
    1
);

INSERT INTO reserve VALUES (
    2,
    12,
    3,
    TO_DATE('10-Aug-2021 4:05:33 PM', 'dd-Mon-yyyy hh:mi:ss PM'),
    4
);

COMMIT;