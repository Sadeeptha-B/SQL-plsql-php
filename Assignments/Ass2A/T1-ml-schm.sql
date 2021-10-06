/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T1-ml-schm.sql*/

/*Student ID: 30769140*/
/*Student Name: Sadeeptha Bandara*/
/*Tutorial No: 6 (Activity 2 as per Allocate+)*/

/* Comments for your marker:





*/

/* 1.1 Add Create table statments for the Missing TABLES below*/
/* Ensure all column comments, and constraints (other than FK's)*/
/* are included. FK constraints are to be added at the end of this script*/

/* BOOK_COPY*/
CREATE TABLE book_copy (
    branch_code         NUMBER(2) NOT NULL,
    bc_id               NUMBER(6) NOT NULL,
    bc_purchase_price   NUMBER(7, 2) NOT NULL,
    bc_counter_reserve  CHAR(1) NOT NULL,
    book_call_no        VARCHAR2(20) NOT NULL
);

ALTER TABLE book_copy
    ADD CONSTRAINT chk_counter_reserve CHECK ( bc_counter_reserve IN ( 'Y', 'N' ) );

COMMENT ON COLUMN book_copy.branch_code IS
    'Branch number';

COMMENT ON COLUMN book_copy.bc_id IS
    'Book copy id unique within a single branch';

COMMENT ON COLUMN book_copy.bc_purchase_price IS
    'Purchase price for the copy';

COMMENT ON COLUMN book_copy.bc_counter_reserve IS
    'Flag to indicate whether copy is in counter reserve';

COMMENT ON COLUMN book_copy.book_call_no IS
    'Identifier for a book';

ALTER TABLE book_copy ADD CONSTRAINT book_copy_pk PRIMARY KEY ( branch_code,
                                                                bc_id );

/* LOAN*/
CREATE TABLE loan (
    branch_code              NUMBER(2) NOT NULL,
    bc_id                    NUMBER(6) NOT NULL,
    loan_date_time           DATE NOT NULL,
    loan_due_date            DATE NOT NULL,
    loan_actual_return_date  DATE,
    bor_no                   NUMBER(6) NOT NULL
);

COMMENT ON COLUMN loan.branch_code IS
    'Branch number';

COMMENT ON COLUMN loan.bc_id IS
    'Book copy id unique within a single branch';

COMMENT ON COLUMN loan.loan_date_time IS
    'Date and time loan taken out';

COMMENT ON COLUMN loan.loan_due_date IS
    'Date loan due';

COMMENT ON COLUMN loan.loan_actual_return_date IS
    'Actual date loan returned';

COMMENT ON COLUMN loan.bor_no IS
    'Identifier for Borrower';

ALTER TABLE loan
    ADD CONSTRAINT loan_pk PRIMARY KEY ( branch_code,
                                         bc_id,
                                         loan_date_time );

/* RESERVE*/
CREATE TABLE reserve (
    reserve_id                NUMBER(6) NOT NULL,
    branch_code               NUMBER(2) NOT NULL,
    bc_id                     NUMBER(6) NOT NULL,
    reserve_date_time_placed  DATE NOT NULL,
    bor_no                    NUMBER(6) NOT NULL
);

COMMENT ON COLUMN reserve.reserve_id IS
    'Reservation id: unique across branches';

COMMENT ON COLUMN reserve.branch_code IS
    'Branch number';

COMMENT ON COLUMN reserve.bc_id IS
    'Book copy id unique within a single branch';

COMMENT ON COLUMN reserve.reserve_date_time_placed IS
    'Date and time of reservation';

COMMENT ON COLUMN reserve.bor_no IS
    'Identifier for Borrower';

ALTER TABLE reserve ADD CONSTRAINT reserve_pk PRIMARY KEY ( reserve_id );

ALTER TABLE reserve ADD (
    CONSTRAINT uq_natural_key UNIQUE ( branch_code, bc_id, reserve_date_time_placed)
);

/* Add all missing FK Constraints below here*/
ALTER TABLE book_copy ADD (
    CONSTRAINT branch_book_copy_fk FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code ),
    CONSTRAINT book_detail_book_copy_fk FOREIGN KEY ( book_call_no )
        REFERENCES book_detail ( book_call_no )
);

ALTER TABLE loan ADD (
    CONSTRAINT loan_book_copy_fk FOREIGN KEY ( branch_code,
                                               bc_id )
        REFERENCES book_copy ( branch_code,
                               bc_id ),
    CONSTRAINT loan_borrower_fk FOREIGN KEY ( bor_no )
        REFERENCES borrower ( bor_no )
);

ALTER TABLE reserve ADD (
    CONSTRAINT reserve_book_copy_fk FOREIGN KEY ( branch_code,
                                                  bc_id )
        REFERENCES book_copy ( branch_code,
                               bc_id ),
    CONSTRAINT reserve_borrower_fk FOREIGN KEY ( bor_no )
        REFERENCES borrower ( bor_no )
);