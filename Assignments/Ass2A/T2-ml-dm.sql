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

UPDATE branch
SET
    branch_count_books = branch_count_books + 1
WHERE
    branch_contact_no = '0395413120';

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

UPDATE branch
SET
    branch_count_books = branch_count_books + 1
WHERE
    branch_contact_no = '0395601655';

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

UPDATE branch
SET
    branch_count_books = branch_count_books + 1
WHERE
    branch_contact_no = '0395461253';

COMMIT;

/* 2 (b) (ii)*/
DROP SEQUENCE borrower_seq;

DROP SEQUENCE reserve_seq;

CREATE SEQUENCE borrower_seq START WITH 100 INCREMENT BY 1;

CREATE SEQUENCE reserve_seq START WITH 100 INCREMENT BY 1;



/* 2 (b) (iii)*/
INSERT INTO borrower VALUES (
    borrower_seq.NEXTVAL,
    'Ada',
    'LOVELACE',
    '3 Programmer Street',
    'Babbageville',
    '5000',
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    )
);

INSERT INTO reserve VALUES (
    reserve_seq.NEXTVAL,
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
            bc_id
        FROM
            book_copy
        WHERE
                book_call_no = '005.74 C824C'
            AND branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
    ),
    TO_DATE('14-Sep-2021 03:30 PM', 'dd-Mon-yyyy hh:mi PM'),
    borrower_seq.CURRVAL
);


COMMIT;



/* 2 (b) (iv)*/