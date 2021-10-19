/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*cgh_queries.sql*/

/*Student ID: Sadeeptha Bandara*/
/*Student Name: 30769140*/
/*Tutorial No: */

/* Comments for your marker:
Q6: As it is specified in the ed forum (https://edstem.org/au/courses/6068/discussion/639482)
to display hours even if the hours field is zero, it is done so.

Q7: Since the procedure price differnential is obtained by a subtraction of currencies, it is 
formatted as a currency. As it is not sensible for a currency to have a lot of decimal places, 
the value is rounded to two decimal places.

*/


/*
    Q1
*/
SELECT
    doctor_title,
    doctor_fname,
    doctor_lname,
    doctor_phone
FROM
         cgh.doctor
    NATURAL JOIN cgh.doctor_speciality
WHERE
    spec_code = (
        SELECT
            spec_code
        FROM
            cgh.speciality
        WHERE
            upper(spec_description) = 'ORTHOPEDIC SURGERY'
    )
ORDER BY
    doctor_lname,
    doctor_fname;
    
/*
    Q2
*/
SELECT
    item_code,
    item_description,
    item_stock,
    cc_title
FROM
         cgh.item
    NATURAL JOIN cgh.costcentre
WHERE
        item_stock > 50
    AND lower(item_description) LIKE '%disposable%'
ORDER BY
    item_code;
    
/*
    Q3
*/
SELECT
    patient_id,
    ltrim(patient_fname
          || ' '
          || patient_lname)                             AS "Patient Name",
    to_char(adm_date_time, 'dd-Mon-yyyy hh:mi PM ')     AS "Admission Date and Time",
    ltrim(doctor_title
          || ' '
          || ltrim(doctor_fname
                   || ' '
                   || doctor_lname))                    AS "Doctor Name"
FROM
         cgh.admission
    NATURAL JOIN cgh.patient
    NATURAL JOIN cgh.doctor
WHERE
        adm_date_time >= TO_DATE('11-Sep-2021 10 AM', 'dd-Mon-yyyy hh PM')
    AND adm_date_time <= TO_DATE('14-Sep-2021 06 PM', 'dd-Mon-yyyy hh PM')
ORDER BY
    adm_date_time;
    
    
/*
    Q4
*/
SELECT
    proc_code,
    proc_name,
    proc_description,
    lpad(to_char(proc_std_cost, '$990.00'),16,' ') AS standard_cost
FROM
    cgh.procedure
WHERE
    proc_std_cost < (
        SELECT
            AVG(proc_std_cost)
        FROM
            cgh.procedure
    )
ORDER BY
    proc_std_cost DESC;
    
    
/*
    Q5
*/
SELECT
    patient_id,
    patient_lname,
    patient_fname,
    to_char(patient_dob, 'dd-Mon-yyyy') AS dob,
    number_of_admissions
FROM
         cgh.patient
    JOIN (
        SELECT
            patient_id,
            COUNT(adm_no) AS number_of_admissions
        FROM
            cgh.admission
        GROUP BY
            patient_id
        HAVING
            COUNT(adm_no) > 2
    )
    USING ( patient_id )
ORDER BY
    number_of_admissions DESC,
    patient_dob;


/*
    Q6
*/
SELECT
    adm_no,
    patient_id,
    patient_fname,
    patient_lname,
    ltrim(to_char(floor(adm_discharge - adm_date_time), 99))
            || ' days '
            || ltrim(to_char(((adm_discharge - adm_date_time) - floor(adm_discharge - adm_date_time)) * 24, '90.0'))
            || ' hrs'
    AS length_of_stay
FROM
         cgh.admission
    NATURAL JOIN cgh.patient
WHERE
    adm_discharge IS NOT NULL
    AND ( adm_discharge - adm_date_time ) > (
        SELECT
            AVG(adm_discharge - adm_date_time)
        FROM
            cgh.admission
    )
ORDER BY
    adm_no;

/*
    Q7
*/
SELECT
    p.proc_code,
    proc_name,
    proc_description,
    proc_time,
    lpad(to_char(proc_std_cost, '$999.00'),14) AS standard_cost,
    lpad(to_char(round(avg_proc_cost - proc_std_cost, 2), '$90.00'),21) AS "Procedure Price Differential"
FROM
         cgh.procedure p
    JOIN (
        SELECT
            proc_code,
            AVG(adprc_pat_cost) AS avg_proc_cost
        FROM
            cgh.adm_prc
        GROUP BY
            proc_code
    ) a
    ON p.proc_code = a.proc_code
ORDER BY
    proc_code;

    
/*
    Q8
*/
SELECT
    proc_code,
    proc_name,
    nvl(item_code, '---')                                   AS "Item code",
    nvl(to_char(MAX(it_qty_used), '99'), '---')             AS max_qty_used
FROM
    cgh.procedure
    LEFT OUTER JOIN cgh.adm_prc
    USING ( proc_code )
    LEFT OUTER JOIN cgh.item_treatment
    USING ( adprc_no )
GROUP BY
    proc_code,
    proc_name,
    item_code
ORDER BY
    proc_name,
    item_code;


/*
    Q9a (FIT2094 only) or Q9b (FIT3171 only)
*/
SELECT
    adprc_no,
    proc_code,
    adm_no,
    patient_id,
    to_char(adprc_date_time, 'dd-Mon-yyyy HH24:mi')      AS procedure_time,
    lpad(to_char(adprc_pat_cost + adprc_items_cost, '$990.00'),12)   AS total_cost
FROM
       cgh.adm_prc ap1
        JOIN cgh.admission
        USING ( adm_no )
WHERE ( SELECT
          COUNT(adprc_no)
        FROM cgh.adm_prc ap2
        WHERE (ap1.adprc_pat_cost + ap1.adprc_items_cost) < (ap2.adprc_pat_cost + ap2.adprc_items_cost)) = 8 
ORDER BY adprc_no;





