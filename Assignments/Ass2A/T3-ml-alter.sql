/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T3-ml-alter.sql*/

/*Student ID: 30769140*/
/*Student Name: Sadeeptha Bandara*/
/*Tutorial No: 6 (Activity 2 as per Allocate+*/

/* Comments for your marker:
It is assumed that the bc_status can only take 'D', 'L', 'G'
As specified in the assignment brief, it is assumed that the Glen Waverly Branch has only a single copy of
the specified book.

Since the assignment brief does not explicitly specify that no more than two managers can exist for a branch, 
this constraint is not enforced.

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
                    branch
                WHERE
                    branch_contact_no = '0395601655'
            )
    );

COMMIT;

/* 3 (b)*/
ALTER TABLE loan ADD (
    loan_return_branch_code NUMBER(2)
);

UPDATE loan
SET
    loan_return_branch_code = branch_code
WHERE
    loan_actual_return_date IS NOT NULL;

COMMIT;


/* 3 (c)*/
DROP TABLE manager_assignment;

/*Creating manager assignment*/
CREATE TABLE manager_assignment
    AS
        SELECT
            branch_code,
            man_id
        FROM
            branch;

ALTER TABLE manager_assignment ADD (
    man_assign_collection CHAR(1) DEFAULT 'B' NOT NULL,
    CONSTRAINT chk_collection_values CHECK ( man_assign_collection IN ( 'F', 'R', 'B' ) )
);

COMMENT ON COLUMN manager_assignment.branch_code IS
    'Branch number';

COMMENT ON COLUMN manager_assignment.man_id IS
    'manager id';

COMMENT ON COLUMN manager_assignment.man_assign_collection IS
    'The collection assigned to the manager';

ALTER TABLE manager_assignment ADD CONSTRAINT man_assign_pk PRIMARY KEY ( branch_code,
                                                                          man_id );

ALTER TABLE manager_assignment ADD (
    CONSTRAINT branch_man_assign_fk FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code ),
    CONSTRAINT man_assign_man_fk FOREIGN KEY ( man_id )
        REFERENCES manager ( man_id )
);

ALTER TABLE branch DROP CONSTRAINT manager_branch;

ALTER TABLE branch DROP COLUMN man_id;

/*Updating manager assignment records*/
UPDATE manager_assignment
SET
    man_assign_collection = 'R'
WHERE
        branch_code = (
            SELECT
                branch_code
            FROM
                branch
            WHERE
                branch_contact_no = '0395413120'
        )
    AND man_id = 10;

INSERT INTO manager_assignment VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    12,
    'F'
);

COMMIT;