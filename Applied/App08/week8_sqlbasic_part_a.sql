/*
Databases Week 8 Tutorial
week8_sqlbasic_part_a.sql

student id: 30696003
student name: Poon Yeong Shian
last modified date: 28/4/2022

*/

/* A1. List all units and their details. Order the output by unit code. */
SELECT * FROM uni.unit
ORDER BY unitcode ASC;

/* A2. List all students’ details who live in Caulfield. 
Order the output by student first name.*/
SELECT * FROM uni.student
WHERE stuaddress LIKE '%Caulfield'
ORDER BY stufname ASC;
    
    
/* A3. List the student's surname, firstname and address for those students 
who have a surname starting with the letter 'S' and firstname contains the letter 'i'. 
Order the output by student id*/
SELECT stufname, stulname, stuaddress
FROM uni.student s
WHERE s.stulname LIKE 'S%' AND s.stufname LIKE'%i%';
  
/* A4. Assuming that a unit code is created based on the following rules:
a. The first three letters represent faculty abbreviation, 
   eg. FIT for the Faculty of Information Technology.
b. The first digit of the number following the letter represents the year level. 
   For example, FIT2094 is a unit code from Faculty of IT (FIT) 
   and the number 2 refers to a second year unit.

List the unit details of all first year units in the Faculty of Information Technology. 
Order the output by unit code.*/
SELECT unitcode, unitname
FROM uni.unit
WHERE unitcode LIKE 'FIT1%'
ORDER BY unitcode;

/*A5. List the unit code and semester of all units that are offered in 2021. 
Order the output by unit code, and within a given unit code order by semester. 
To complete this question you need to use the Oracle function to_char to convert 
the data type for the year component of the offering date into text. 
For example, to_char(ofyear,'yyyy') - here we are only using the year part of the date.
*/
SELECT o.unitcode, o.ofsemester
FROM uni.offering o
WHERE to_char(o.ofyear,'yyyy') ='2021'
ORDER BY o.unitcode, o.ofsemester;

/* A6. List the year, semester, and unit code for all units that were offered 
in either semester 2 of 2019 or semester 2 of 2020. 
Order the output by year and semester then by unit code.*/
SELECT to_char(ofyear,'yyyy'), ofsemester, unitcode
FROM uni.offering
WHERE (ofsemester = 2 AND to_char(ofyear,'yyyy')='2020') OR (ofsemester = 2 AND to_char(ofyear,'yyyy')='2019')
ORDER BY unitcode, ofsemester, ofyear;


/* A7. List the student id, unit code and mark 
for those students who have failed any unit in semester 2 of 2021. 
Order the output by student id then order by unit code. */
select s.stuid, unitcode, enrolmark
from uni.student s join uni.enrolment e on s.stuid = e.stuid
where enrolgrade = 'N' and ofsemester = 2 and to_char(ofyear,'yyyy')= 2021
order by stuid, unitcode



