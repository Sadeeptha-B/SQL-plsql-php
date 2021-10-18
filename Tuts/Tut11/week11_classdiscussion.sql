/*
Databases Week 11 Tutorial
week11_classdiscussion.sql

student id: 30769140
student name: Sadeeptha Bandara
last modified date: 18/10/2021

*/

/*1*/
SELECT
    unitcode,
    unitname,
    EXTRACT(YEAR FROM ofyear)     AS year,
    semester,
    mark,
    decode(grade, 'N', 'Fail', 'P', 'Pass',
           'C', 'Credit', 'D', 'Distinction', 'HD',
           'High Distinction')    AS "EXPLAINED_GRADE"
FROM
         uni.enrolment
    NATURAL JOIN uni.unit
WHERE
    studid = (
        SELECT
            studid
        FROM
            uni.student
        WHERE
                upper(studfname) = upper('Claudette')
            AND upper(studlname) = upper('Serman')
    )
ORDER BY
    year,
    semester,
    unitcode;


/*2*/
SELECT
    u.unitcode,
    COUNT(has_prereq_of) AS no_of_prereq
FROM
    uni.unit      u
    LEFT OUTER JOIN uni.prereq    p
    ON p.unitcode = u.unitcode
GROUP BY
    u.unitcode
ORDER BY
    no_of_prereq DESC,
    unitcode;
    