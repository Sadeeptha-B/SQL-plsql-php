/*
Databases Week 8 Tutorial
week8_sqlbasic_part_b.sql

student id: 30769140
student name: Sadeeptha Bandara
last modified date: 5th October 2021
*/

/* B1. List all the unit codes, semesters and name of chief examiners 
for all the units that are offered in 2020. 
Order the output by semester then by unit code.*/
SELECT
    unitcode,
    semester,
    stafffname
    || ' '
    || stafflname AS chiefexaminer
FROM
         uni.offering o
    JOIN uni.staff s
    ON o.chiefexam = s.staffid
WHERE
    to_char(ofyear, 'yyyy') = '2020'
ORDER BY
    semester,
    unitcode;  

/* B2. List all unit codes, unit names and their year and semester of offering. 
Order the output by unit code then by offering year and then semester. */
SELECT
    unitcode,
    unitname,
    to_char(ofyear, 'yyyy') AS offer_year,
    semester
FROM
         uni.offering
    NATURAL JOIN uni.unit
ORDER BY
    unitcode,
    offer_year,
    semester;  
  
/* B3. List the student name (firstname and surname) as one attribute 
and the unit name of all enrolments for semester 1 of 2020. 
Order the output by unit name, within a given unit name, order by student id.*/
SELECT
    studfname
    || ' '
    || studlname AS studname,
    unitname
FROM
         uni.enrolment
    NATURAL JOIN uni.student
    NATURAL JOIN uni.unit
WHERE
        semester = 1
    AND to_char(ofyear, 'yyyy') = '2020'
ORDER BY
    unitname,
    studid;

/* B4. List the unit code, semester, class type (lecture or tutorial), day and time
for all units taught by Windham Ellard in 2020.
Sort the list according to the unit code.*/
SELECT
    unitcode,
    semester,
    cltype,
    clday,
    to_char(cltime, 'hh:mi:ss PM')
FROM
         uni.schedclass
    NATURAL JOIN uni.staff
WHERE
        stafffname = 'Windham'
    AND stafflname = 'Ellard'
    AND to_char(ofyear, 'yyyy') = '2020'
ORDER BY
    unitcode;

/* B5. Create a study statement for Friedrick Geist.
A study statement contains unit code, unit name, semester and year study was attempted,
the mark and grade. If the mark and/or grade is unknown, show the mark and/or grade as ‘N/A’.
Sort the list by year, then by semester and unit code. */
SELECT
    unitcode,
    unitname,
    semester,
    to_char(ofyear, 'yyyy') AS year,
    nvl(to_char(mark, '999'), 'N/A') as mark,
    nvl(grade, 'N/A')
FROM
         uni.enrolment
    NATURAL JOIN uni.unit
    NATURAL JOIN uni.student
WHERE
        studfname = 'Friedrick'
    AND studlname = 'Geist'
ORDER BY
    year,
    semester,
    unitcode;

/* B6. List the unit code and unit name of the prerequisite units
of 'Introduction to data science' unit.
Order the output by prerequisite unit code. */
SELECT
    has_prereq_of AS prereq_code,
    unitname
FROM
         uni.prereq p
    JOIN uni.unit u
    ON u.unitcode = p.has_prereq_of
WHERE
    p.unitcode = (
        SELECT
            unitcode
        FROM
            uni.unit
        WHERE
            unitname = 'Introduction to data science'
    )
ORDER BY
    p.unitcode;

/* B7. Find all students (list their id, firstname and surname)
who have received an HD for FIT2094 unit in semester 2 of 2019.
Sort the list by student id. */
SELECT
    studid,
    studfname,
    studlname
FROM
         uni.student
    NATURAL JOIN uni.enrolment
WHERE
        grade = 'HD'
    AND unitcode = 'FIT2094'
    AND semester = 2
    AND to_char(ofyear, 'yyyy') = '2019'
ORDER BY
    studid;


/* B8.	List the student full name, and unit code for those students
who have no mark in any unit in semester 1 of 2020.
Sort the list by student full name. */
SELECT
    studfname
    || ' '
    || studlname AS stud_fullname,
    unitcode
FROM
         uni.enrolment
    NATURAL JOIN uni.student
WHERE
        mark IS NULL
    AND semester = 1
    AND to_char(ofyear, 'yyyy') = '2020'
ORDER BY
    stud_fullname;