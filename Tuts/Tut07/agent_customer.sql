/* Sadeeptha Bandara*/
/* 27th September 2021*/

/* Key points*/

/* 
Foreign key attributes must be included along with the other 
    attributes. The constraint definition only has the constraint
    and will not define the attr itself.
All constraints other than the non null constraint must be given 
    a name.
Specify foreign key attributes with an alter statement
Specify primary key attributes as table constraints
Define delete rule for foreign key attribute
*/

CREATE TABLE agent (
    agent_code      NUMBER(3) NOT NULL,
    agent_areacode  NUMBER(3) NOT NULL,
    agent_phone     CHAR(8) NOT NULL,
    agent_lname     VARCHAR2(50) NOT NULL,
    agent_ytd_sls   NUMBER(8, 2) NOT NULL,
    CONSTRAINT agent_pk PRIMARY KEY ( agent_code )
);

--ALTER TABLE agent ADD CONSTRAINT agent_pk PRIMARY KEY (agent_code)

CREATE TABLE customer (
    cus_code        NUMBER(5) NOT NULL,
    cus_lname       VARCHAR2(50) NOT NULL,
    cus_fname       VARCHAR2(50) NOT NULL,
    cus_initial     CHAR(1),
    cus_renew_date  DATE NOT NULL,
    agent_code      NUMBER(3),
    CONSTRAINT customer_pk PRIMARY KEY ( cus_code )
);

ALTER TABLE customer ADD (
    CONSTRAINT fk_customer_agent FOREIGN KEY ( agent_code )
        REFERENCES agent ( agent_code )
            ON DELETE SET NULL
);