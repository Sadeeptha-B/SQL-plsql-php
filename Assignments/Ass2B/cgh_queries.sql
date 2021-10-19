/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*cgh_queries.sql*/

/*Student ID: Sadeeptha Bandara*/
/*Student Name: 30769140*/
/*Tutorial No: */

/* Comments for your marker:




*/


/*
    Q1
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/
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
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
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
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    patient_id,
    patient_fname
    || ' '
    || patient_lname                                    AS "Patient Name",
    to_char(adm_date_time, 'hh:mi PM dd-Mon-yyyy')      AS "Admission Date and Time",
    doctor_title
    || '.'
    || doctor_fname
    || ' '
    || doctor_lname                                     AS "Doctor Name"
FROM
         cgh.admission
    JOIN cgh.patient
    USING ( patient_id )
    JOIN cgh.doctor
    USING ( doctor_id )
WHERE
        adm_date_time >= TO_DATE('11-Sep-2021 10 AM', 'dd-Mon-yyyy hh PM')
    AND adm_date_time <= TO_DATE('14-Sep-2021 04 PM', 'dd-Mon-yyyy hh PM')
ORDER BY
    adm_date_time;
    
    
/*
    Q4
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    proc_code,
    proc_name,
    proc_description,
    to_char(proc_std_cost, '$990.00') AS standard_cost
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
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
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
    number_of_admissions,
    patient_dob;


/*
    Q6
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    adm_no,
    patient_id,
    patient_fname,
    patient_lname,
    CASE ( ( adm_discharge - adm_date_time ) - floor(adm_discharge - adm_date_time) )
        WHEN 0 THEN
            floor(adm_discharge - adm_date_time)
            || ' days'
        ELSE
            floor(adm_discharge - adm_date_time)
            || ' days'
            || to_char(((adm_discharge - adm_date_time) - floor(adm_discharge - adm_date_time)) * 24, '99.0')
            || ' hrs'
    END AS length_of_stay
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
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    p.proc_code,
    proc_name,
    proc_description,
    proc_time,
    proc_std_cost,
    avg_proc_cost - proc_std_cost AS "Procedure Price Differential"
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
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
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
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    adprc_no,
    proc_code,
    adm_no,
    patient_id,
    to_char(adprc_date_time, 'dd-Mon-yyyy HH24:mi')      AS procedure_time,
    adprc_pat_cost + adprc_items_cost                    AS total_cost
FROM
       cgh.adm_prc ap1
        JOIN cgh.admission
        USING ( adm_no )
WHERE ( SELECT
          COUNT(adprc_no)
        FROM cgh.adm_prc ap2
        WHERE (ap1.adprc_pat_cost + ap1.adprc_items_cost) < (ap2.adprc_pat_cost + ap2.adprc_items_cost)) = 8 
ORDER BY adprc_no;





