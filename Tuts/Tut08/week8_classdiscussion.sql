/*
Databases Week 8 Tutorial
week8_classdiscussion.sql

Author: Sadeeptha Bandara
Created: 28th September 2021
*/

/*Question 1*/
SELECT
    *
FROM
    uni.student
ORDER BY
    studid;

/*Question 2*/
SELECT
    studid,
    studfname  AS firstname,
    studlname  AS lastname,
    studdob,
    studaddress,
    studphone,
    studemail
FROM
    uni.student
WHERE
    studlname LIKE 'S%'  /* Important: Alias won't work here*/
ORDER BY
    firstname;    /* Alias works here.*/
    
/*Question 3*/
SELECT
    studfname
    || ' '
    || studlname AS fullname
FROM
         uni.student
    NATURAL JOIN uni.enrolment
WHERE
    mark BETWEEN 80 AND 100
    AND unitcode = 'FIT9132'
    AND semester = 2
    AND to_char(ofyear, 'yyyy') = '2019'  
        /* to char to convert the date to character for comparison*/
ORDER BY
    fullname;
    
/*Question 4*/
SELECT
    u1.unitcode,
    u1.unitname,
    has_prereq_of  AS prereq_unitcode,
    u2.unitname    AS prereq_unitname
FROM
         uni.unit u1
    JOIN uni.prereq    p
    ON u1.unitcode = p.unitcode
    JOIN uni.unit      u2
    ON u2.unitcode = p.has_prereq_of
ORDER BY
    unitcode,
    prereq_unitcode;

/*SELECT unit_code, unit_name, pre.has_prereq_of, pre.unit_name FROM uni.unit NATURAL JOIN */
/*(SELECT p.unit_code, has_prereq_of, unit_name FROM uni.prereq p JOIN uni.unit u ON (u.unit_code = p.has_prereq_of)) */