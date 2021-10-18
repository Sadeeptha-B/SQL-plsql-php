/*
Databases Week 10 Tutorial
week10_classdiscussion.sql

student id: 30769140
student name: Sadeeptha Bandara
last modified date: 18/10/2021

*/

/*1 */
SELECT
    MAX(mark)
FROM
    uni.enrolment
WHERE
        unitcode = 'FIT9136'
    AND semester = 2
    AND to_char(ofyear, 'yyyy') = '2019';
    
    
/*2*/
SELECT
    to_char(ofyear, 'yyyy')      AS year,
    semester,
    unitcode,
    COUNT(*)                     AS enrolments
FROM
    uni.enrolment
WHERE
    to_char(ofyear, 'yyyy') = '2019'
GROUP BY
    to_char(ofyear, 'yyyy'),
    semester,
    unitcode
ORDER BY
    enrolments;
    
/*3*/
SELECT
    studfname
    || ' '
    || studlname AS fullname,
    to_char(studdob, 'dd-Mon-yyyy') AS dob
FROM
         uni.student
    NATURAL JOIN uni.enrolment
WHERE
    unitcode = 'FIT9132'
GROUP BY studdob, studfname 
ORDER BY
    studid;