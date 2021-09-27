/* Sadeeptha Bandara*/
/* 27th September 2021*/

/* Q1 Show the ids, names of students as a single column called NAME and their*/
/* DOBs. Order the output in date of birth order*/
SELECT
    studid,
    studfname
    || ' '
    || studlname                         AS name,
    to_char(studdob, 'DD-MON-YYYY')      AS dob
FROM
    uni.student
ORDER BY
    studdob;
    
/*Q2 Show the ids, names of students in a single column called Name, unit code, */
/* and year and semester of enrollment where mark is NULL. Order the output by*/
/* student id, within unit code order.*/
SELECT
    studid,
    studfname
    || ' '
    || studlname                 AS name,
    unitcode,
    to_char(ofyear, 'YYYY')      AS year,
    semester
FROM
         uni.enrolment
    NATURAL JOIN uni.student
WHERE
    mark IS NULL
ORDER BY
    unitcode,
    studid;