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

ALTER TABLE book_copy ADD CONSTRAINT book_copy_pk PRIMARY KEY ( branch_code,
                                                                bc_id );

ALTER TABLE book_copy
    ADD CONSTRAINT chk_counter_reserve CHECK ( bc_counter_reserve IN ( 'Y', 'N' ) );


/* LOAN*/
CREATE TABLE loan (
    branch_code              NUMBER(2) NOT NULL,
    bc_id                    NUMBER(6) NOT NULL,
    loan_date_time           DATE NOT NULL,
    loan_due_date            DATE NOT NULL,
    loan_actual_return_date  DATE,
    bor_no                   NUMBER(6) NOT NULL
);

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

ALTER TABLE reserve ADD CONSTRAINT reserve_pk PRIMARY KEY ( reserve_id );

ALTER TABLE reserve ADD (
    CONSTRAINT uq_branch_code UNIQUE ( branch_code ),
    CONSTRAINT uq_bc_id UNIQUE ( bc_id ),
    CONSTRAINT uq_reserve_date_time UNIQUE ( reserve_date_time_placed )
);

/* Add all missing FK Constraints below here*/