/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T2-ml-dm.sql*/

/*Student ID: 30769140*/
/*Student Name: Sadeeptha Bandara*/
/*Tutorial No: 6 (Activity 2 as per Allocate+)*/

/* Comments for your marker:




*/

/* 2 (b) (i)*/

INSERT INTO book_detail VALUES (
    '005.74 C824C',
    'Database Systems: Design, Implementation, and Management',
    'R',
    793,
    TO_DATE('2019', 'yyyy'),
    13
);

INSERT INTO book_copy VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    (
        SELECT
            branch_count_books + 1
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    120,
    'N',
    '005.74 C824C'
);

INSERT INTO book_copy VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    ),
    (
        SELECT
            branch_count_books + 1
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    ),
    120,
    'N',
    '005.74 C824C'
);

INSERT INTO book_copy VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395461253'
    ),
    (
        SELECT
            branch_count_books + 1
        FROM
            branch
        WHERE
            branch_contact_no = '0395461253'
    ),
    120,
    'N',
    '005.74 C824C'
);

COMMIT;

/* 2 (b) (ii)*/
DROP SEQUENCE borrower_seq;

DROP SEQUENCE reserve_seq;

CREATE SEQUENCE borrower_seq START WITH 100 INCREMENT BY 1;

CREATE SEQUENCE reserve_seq START WITH 100 INCREMENT BY 1;



/* 2 (b) (iii)*/






/* 2 (b) (iv)*/