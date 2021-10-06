/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T3-ml-alter.sql*/

/*Student ID: 30769140*/
/*Student Name: Sadeeptha Bandara*/
/*Tutorial No: 6 (Activity 2 as per Allocate+*/

/* Comments for your marker:




*/

/* 3 (a)*/
ALTER TABLE book_copy ADD (
    bc_status CHAR(1) DEFAULT 'G' NOT NULL,
    CONSTRAINT chk_bc_status CHECK ( bc_status IN ( 'D', 'L', 'G' ) )
);

UPDATE book_copy
SET
    bc_status = 'L'
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    ) AND bc_id = (SELECT bc_id FROM book_copy WHERE book_call_no='005.74 C824C')

-- 3 (b)





-- 3 (c)



