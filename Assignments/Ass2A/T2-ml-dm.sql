/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T2-ml-dm.sql*/

/*Student ID: 30769140*/
/*Student Name: Sadeeptha Bandara*/
/*Tutorial No: 6 (Activity 2 as per Allocate+)*/

/* Comments for your marker:
Notable assumptions
- LOVELACE is considered as capitalized due to how the value is presented in the specification
- For part iii, since the specification does not mention that it can be assumed that there is only one Ada LOVELACE
in the database, this assumption is not made, so the only way to query the branch_code in this section was through the
branch_contact_no
- As per the specification, it is assumed that only one copy of book call number 005.74 C824C exists in the database
  (This assumption is used in the queries for bc_id in part iii and iv)
- Since Part iv in the spec tells to assume that only one Ada LOVELACE exists in the database, the home branch is queried from
the borrower table using Ada's name
- Since a particular person can make multiple reservations for a single copy as per the data model, in querying the reserve day,
it is assumed that the initial reserve day is known.

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
    TO_DATE('14-Sep-2021 03:30  PM', 'dd-Mon-yyyy hh:mi PM'),
    borrower_seq.CURRVAL
);

COMMIT;

/* 2 (b) (iv)*/
INSERT INTO loan VALUES (
    (
        SELECT
            branch_code
        FROM
            borrower
        WHERE
                bor_fname = 'Ada'
            AND bor_lname = 'LOVELACE'
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
                    borrower
                WHERE
                        bor_fname = 'Ada'
                    AND bor_lname = 'LOVELACE'
            )
    ),
    ( TO_DATE('14-Sep-2021', 'dd-Mon-yyyy') + 7 + ( 12 + 0.5 ) * 1 / 24 ),
    ( TO_DATE('14-Sep-2021', 'dd-Mon-yyyy') + 7 + 14 ),
    NULL,
    (
        SELECT
            bor_no
        FROM
            borrower
        WHERE
                bor_fname = 'Ada'
            AND bor_lname = 'LOVELACE'
    )
);

DELETE FROM reserve
WHERE
        branch_code = (
            SELECT
                branch_code
            FROM
                borrower
            WHERE
                    bor_fname = 'Ada'
                AND bor_lname = 'LOVELACE'
        )
    AND bc_id = (
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
                    borrower
                WHERE
                        bor_fname = 'Ada'
                    AND bor_lname = 'LOVELACE'
            )
    )
    AND to_char(reserve_date_time_placed, 'dd-Mon-yyyy') = '14-Sep-2021';

COMMIT;