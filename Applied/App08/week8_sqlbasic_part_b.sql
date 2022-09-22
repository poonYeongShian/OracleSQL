/*
Databases Week 8 Tutorial
week8_sqlbasic_part_b.sql

student id: 30696003
student name: Poon Yeong Shian
last modified date: 28/4/2022
*/

/* B1. List all the unit codes, semesters and name of chief examiners 
(ie. the staff who is responsible for the unit) for all the units 
that are offered in 2021. Order the output by semester then by unit code..*/
select unitcode, ofsemester, stafffname ||' '|| stafflname as stafffullname
from uni.offering o join uni.staff s on o.staffid = s.staffid
where to_char(ofyear, 'yyyy') = 2021
order by ofsemester, unitcode;

/* B2. List all the unit codes and the unit names and their year and semester offerings.
Order the output by unit code then by offering year and semester. */
SELECT u.unitcode, u.unitname, TO_CHAR(o.ofyear, 'yyyy'),o.ofsemester
FROM uni.unit u JOIN uni.offering o
ON u.unitcode = o.unitcode
ORDER BY unitcode, ofyear, ofsemester;

/*
B3. List the student id, student name (firstname and surname) as one attribute 
and the unit name of all enrolments for semester 1 of 2021. 
Order the output by unit name, within a given unit name, order by student id.
*/
SELECT s.stuid, stulname|| ' ' || stufname as fullname, u.unitname
FROM uni.student s JOIN uni.enrolment e ON s.stuid = e.stuid JOIN uni.unit u ON u.unitcode = e.unitcode
WHERE to_char(e.ofyear,'yyyy') = '2021' and e.ofsemester = 1
ORDER BY u.unitname, s.stuid;

/* B4. List the unit code, semester, class type (lecture or tutorial), day, time 
and duration (in minutes) for all units taught by Windham Ellard in 2021.
Sort the list according to the unit code, within a given unit code, order by offering semester*/
SELECT
unitcode, ofsemester as semester, cltype as class_type, clday as day,
to_char(cltime,'HH12:MI AM') as time, clduration*60 as duration
FROM
UNI.schedclass c
JOIN UNI.staff s ON s.staffid = c.staffid
WHERE
stafflname = 'Ellard'
and stafffname = 'Windham'
and to_char(ofyear,'yyyy') = 2021
ORDER BY
unitcode, semester;

/* B5. Create a study statement for Brier Kilgour.
A study statement contains unit code, unit name, semester and year study was attempted,
the mark and grade. If the mark and/or grade is unknown, show the mark and/or grade as ‘N/A’.
Sort the list by year, then by semester and unit code. */


/* B6. List the unit code and unit name of the prerequisite units
of 'Introduction to data science' unit.
Order the output by prerequisite unit code. */
SELECT
req.prerequnitcode, u2.unitname
FROM
uni.unit u
JOIN uni.prereq req ON u.unitcode = req.unitcode
JOIN uni.unit u2 ON u2.unitcode = req.prerequnitcode
WHERE
u.unitname = 'Introduction to data science'
ORDER BY
req.unitcode

/* B7. Find all students (list their id, firstname and surname)
who have received an HD for FIT2094 unit in semester 2 of 2021.
Sort the list by student id. */
SELECT
s.stuid,
s.stufname,
s.stulname
FROM
uni.STUDENT s JOIN uni.ENROLMENT e ON s.stuid = e.stuid
WHERE
e.enrolgrade = 'HD' AND
o.unitcode = 'FIT2094' AND
o.ofsemester = 2 AND
TO_CHAR(o.ofyear, 'yyyy') = 2021
ORDER BY
s.stuid
SELECT
s.stuid, stulname, stufname
FROM
uni.student s
JOIN uni.enrolment e ON s.stuid = e.stuid
WHERE
to_char(e.ofyear,'yyyy') = '2021' and
e.ofsemester = 2 and
e.enrolgrade = 'HD' and
e.unitcode = 'FIT2094'
ORDER BY
s.stuid

/* B8.	List the student full name, and unit code for those students
who have no mark in any unit in semester 1 of 2021.
Sort the list by student full name. */
select
stufname ||' '|| stulname as fullname,
unitcode
from
uni.student s
join uni.enrolment e on s.stuid = e.stuid
where
enrolmark is null
and ofsemester = 1
and to_char(ofyear, 'yyyy') = 2021
order by
fullname



