/*
Databases Week 10 Tutorial
week10_sql_intermediate.sql

student id: 30769140
student name: Sadeeptha Bandara
last modified date: 18/10/2021

*/

/* 1. Find the average mark of FIT2094 in semester 2, 2019. 
Show the average mark with two decimal places. 
Name the output column as â€œAverage Markâ€?. */
SELECT
    round(AVG(mark), 2) AS "Average Mark" /* to_char(avg(mark), '990.00')*/
FROM
    uni.enrolment
WHERE
        unitcode = 'FIT2094'
    AND semester = 2
    AND to_char(ofyear, 'yyyy') = '2019';


/* 2. List the average mark for each offering of FIT9136. 
In the listing, include the year and semester number. 
Sort the result according to the year then the semester.*/
SELECT
    to_char(ofyear, 'yyyy')      AS offer_year,
    semester,
    round(AVG(mark), 1)          AS average_mark
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT9136'
GROUP BY
    ofyear,
    semester
ORDER BY
    ofyear,
    semester;
      
      
/* 3. Find the number of students enrolled in FIT1045 in the year 2019, 
under the following conditions (note two separate selects are required):
      a. Repeat students are counted each time
      b. Repeat students are only counted once
*/

/* a. Repeat students are counted each time*/
SELECT
    COUNT(*) AS enrol_count
FROM
    uni.enrolment
WHERE
        unitcode = 'FIT1045'
    AND to_char(ofyear, 'yyyy') = '2019';

  
/* b. Repeat students are only counted once*/
SELECT
    COUNT(DISTINCT studid) AS enrol_count
FROM
    uni.enrolment
WHERE
        unitcode = 'FIT1045'
    AND to_char(ofyear, 'yyyy') = '2019';


/* 4. Find the total number of prerequisite units for FIT5145. */
SELECT
    COUNT(has_prereq_of) AS prereqs
FROM
    uni.prereq
WHERE
    unitcode = 'FIT5145';
/*group by*/
/*    unitcode;*/

  
/* 5. Find the total number of prerequisite units for each unit. 
In the list, include the unitcode for which the count is applicable. 
Order the list by unit code.*/
SELECT
    unitcode,
    COUNT(has_prereq_of) AS prereq_count
FROM
    uni.prereq
GROUP BY
    unitcode
ORDER BY
    unitcode;  


/*6. Find the total number of students 
whose marks are being withheld (grade is recorded as 'WH') 
for each unit offered in semester 1 2020. 
In the listing include the unit code for which the count is applicable. 
Sort the list by descending order of the total number of students 
whose marks are being withheld, then by the unit code.*/
SELECT
    unitcode,
    COUNT(*) AS withheld_total
FROM
    uni.enrolment
WHERE
        grade = 'WH'
    AND semester = 2
    AND to_char(ofyear, 'yyyy') = '2020'
GROUP BY
    unitcode
ORDER BY
    withheld_total DESC,
    unitcode;


/* 7. For each prerequisite unit, calculate how many times 
it has been used as a prerequisite (number of times used). 
In the listing include the prerequisite unit code, 
the prerequisite unit name and the number of times used. 
Sort the output by unit name. */
SELECT
    has_prereq_of            AS prereq_code,
    unitname,
    COUNT(has_prereq_of)     AS no_times_used
FROM
         uni.prereq p
    JOIN uni.unit u
    ON p.has_prereq_of = u.unitcode
GROUP BY
    has_prereq_of,
    unitname
ORDER BY
    unitname;


/*8. Display unit code and unit name of units 
which had at least 1 student who was granted deferred exam 
(grade is recorded as 'DEF') in semester 1 2020. 
Order the list by unit code.*/
SELECT
    unitcode,
    unitname
FROM
         uni.enrolment
    NATURAL JOIN uni.unit
GROUP BY
    unitcode,
    unitname
HAVING
    (
        SELECT
            COUNT(studid)
        FROM
            uni.enrolment
        WHERE
                grade = 'DEF'
            AND semester = 1
            AND to_char(ofyear, 'yyyy') = '2020'
    ) >= 1
ORDER BY
    unitname;


/* 9. Find the unit/s with the highest number of enrolments 
for each offering in the year 2019. 
Sort the list by semester then by unit code. */
SELECT
    unitcode,
    semester,
    COUNT(studid) AS student_count
FROM
    uni.enrolment
WHERE
    to_char(ofyear, 'yyyy') = '2019'
GROUP BY
    semester,
    unitcode
HAVING
    COUNT(*) = (
        SELECT
            MAX(COUNT(unitcode))
        FROM
            uni.enrolment
        WHERE
            to_char(ofyear, 'yyyy') = '2019'
        GROUP BY
            semester,
            unitcode
    )
ORDER BY
    semester,
    unitcode;



/* 10. Find all students enrolled in FIT3157 in semester 1, 2020 
who have scored more than the average mark for FIT3157 in the same offering? 
Display the students' name and the mark. 
Sort the list in the order of the mark from the highest to the lowest 
then in increasing order of student name.*/
SELECT
    studfname
    || ' '
    || studlname AS fullname,
    mark
FROM
         uni.enrolment
    NATURAL JOIN uni.student
WHERE
        unitcode = 'FIT3157'
    AND semester = 1
    AND to_char(ofyear, 'yyyy') = '2020'
    AND mark > (
        SELECT
            AVG(mark)
        FROM
            uni.enrolment
        WHERE
                unitcode = 'FIT3157'
            AND semester = 1
            AND to_char(ofyear, 'yyyy') = '2020'
    )
ORDER BY mark DESC, fullname;















