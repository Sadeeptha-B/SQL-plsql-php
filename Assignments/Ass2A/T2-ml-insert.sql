/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T2-ml-insert.sql*/

/*Student ID: 30769140*/
/*Student Name: Sadeeptha Bandara*/
/*Tutorial No: 6 (Activity 2 as per Allocate+*/

/* Comments for your marker:




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
    'N',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    13,
    1,
    90,
    'Y',
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
    'Y',
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