/*
Databases Week 10 Applied Class
week10_sql_inter_adv.sql

student id: 30696003
student name: Poon Yeong Shian
last modified date: 9/5/2022

*/

/* 1. Find the maximum mark for FIT9136 in semester 2, 2019. */
select max(enrolmark) as max_enrol_mark 
from UNI.enrolment
where ofsemester = 2 and to_char(ofyear, 'YYYY') = '2019' and upper(unitcode) = upper('FIT9136');


/* 2. Find the average mark of FIT2094 in semester 2, 2020.
Show the average mark with two decimal places.
Name the output column as average_mark. */
select to_char(avg(enrolmark),99.99) as average_mark
from UNI.enrolment
where ofsemester = 2 and to_char(ofyear, 'YYYY') = '2020' and upper(unitcode) = upper('FIT2094');


/* 3. List the average mark for each offering of FIT9136.
In the listing, include the year and semester number.
Sort the result according to the year then the semester.*/

select to_char(ofyear,'yyyy'), ofsemester, to_char(avg(enrolmark), 99.99)as average_mark
from UNI.enrolment
where upper(unitcode) = upper('FIT9136')
group by ofyear, ofsemester
order by ofyear, ofsemester;




/* 4. Find the number of students enrolled in FIT1045 in the year 2019,
under the following conditions:
      a. Repeat students are counted multiple times in each semester of 2019
      b. Repeat students are only counted once across 2019
*/
--select distinct stuid 
--from uni.enrolment 
--where to_char(ofyear, 'YYYY') = '2019' and upper(unitcode) = upper('FIT1045')
--order by stuid;
-- a. Repeat students are counted multiple times in each semester of 2019
select count(stuid) as total_number_stu
from UNI.enrolment
where to_char(ofyear, 'YYYY') = '2019' and upper(unitcode) = upper('FIT1045'); 

-- b. Repeat students are only counted once across 2019
select count(distinct stuid)
from UNI.enrolment
where to_char(ofyear, 'YYYY') = '2019' and upper(unitcode) = upper('FIT1045');

/* 5. Find the total number of prerequisite units for FIT5145. */
select count(unitcode) as num_of_preq 
from uni.prereq
where upper(unitcode) = upper('FIT5145');


/* 6. Find the total number of prerequisite units for each unit.
In the list, include the unitcode for which the count is applicable.
Order the list by unit code.*/
select unitcode,count(unitcode) as num_of_preq 
from uni.prereq
group by unitcode
order by unitcode;



/*7. Find the total number of students
whose marks are being withheld (grade is recorded as 'WH')
for each unit offered in semester 2 2020.
In the listing include the unit code for which the count is applicable.
Sort the list by descending order of the total number of students
whose marks are being withheld, then by the unitcode*/

select unitcode, count(*) as total_number_of_students
from uni.enrolment 
where upper(enrolgrade) = upper('WH') and to_char(ofyear, 'YYYY') = '2020' and ofsemester = 2
group by unitcode
order by total_number_of_students desc;


/* 8. For each prerequisite unit, calculate how many times
it has been used as a prerequisite (number of times used).
In the listing include the prerequisite unit code,
the prerequisite unit name and the number of times used.
Sort the output by prerequisite unit code. */
select p.prerequnitcode, count(p.prerequnitcode)
from uni.unit u join uni.prereq p on u.unitcode = p.unitcode
group by p.prerequnitcode; 


/*9. Display unit code and unit name of units
which had at least 2 students who were granted deferred exam
(grade is recorded as 'DEF') in semester 2 2021.
Order the list by unit code.*/

select e.unitcode, u.unitname
from uni.enrolment e join uni.unit u on e.unitcode = u.unitcode
where enrolgrade = 'DEF' and to_char(ofyear, 'YYYY') = '2021' and ofsemester = 2
group by e.unitcode, u.unitname
having count(enrolgrade) >= 2
order by unitcode;



/* 10. Find the unit/s with the highest number of enrolments
for each offering in the year 2019.
Sort the list by semester then by unit code. */


select unitcode from uni.enrolment 
where to_char(ofyear, 'YYYY') = '2019'
group by unitcode
having count(stuid) = (
    select max(count(s.stuid)) as total_enrol
    from uni.student s join uni.enrolment e on s.stuid = e.stuid
    where to_char(ofyear, 'YYYY') = '2019'
    group by e.unitcode
);




/* 11. Find all students enrolled in FIT3157 in semester 1, 2020
who have scored more than the average mark for FIT3157 in the same offering.
Display the students' name and the mark.
Sort the list in the order of the mark from the highest to the lowest
then in increasing order of student name.*/


select s.stuid, s.stufname || ' ' || s.stulname as fullname, to_char(studob, 'dd/mm/yyyy') AS date_of_birth
from uni.enrolment e join uni.student s on e.stuid = s.stuid
where enrolmark >= (
    select to_char(avg(enrolmark),99.99) as average_mark
    from uni.enrolment
    where to_char(ofyear,'yyyy') = 2020 and ofsemester = 1 and upper(unitcode) = upper('FIT3157')
    group by unitcode
) and upper(unitcode) = upper('FIT3157') and ofsemester = 1
order by fullname;
    
/* 12.  Find the number of scheduled classes assigned to each staff member 
for each semester in 2019. If the number of classes is 2 then this 
should be labelled as a correct load, more than 2 as an overload 
and less than 2 as an underload. Include the staff id, staff first name, 
staff last name, semester, number of scheduled classes and load in the listing. 
Sort the list by decreasing order of the number of scheduled classes 
and when the number of classes is the same, sort by increasing order 
of staff id then by the semester. */
select sc.staffid, s.stafffname, s.stafflname, sc.ofsemester, count(sc.staffid) as number_of_class, 
    case 
    when count(sc.staffid) = 2 then 'correctload'
    when count(sc.staffid) > 2 then 'overload'
    when count(sc.staffid) < 2 then 'underload' 
    end as loading
from uni.schedclass sc join uni.staff s on sc.staffid = s.staffid
where to_char(ofyear, 'yyyy') = 2019
group by sc.staffid, s.stafffname, s.stafflname, sc.ofsemester
order by number_of_class desc,sc.staffid, sc.ofsemester;



/* 13. Display the unit code and unit name for units that do not have a prerequisite. 
Order the list in increasing order of unit code. 

There are many approaches that you can take in writing an SQL statement to answer this query. 
You can use the SET OPERATORS, OUTER JOIN and a SUBQUERY. 
Write SQL statements based on all three approaches.*/

/* Using outer join */
select u.unitcode, p.prerequnitcode
from uni.unit u left outer join uni.prereq p on p.unitcode = u.unitcode
where p.prerequnitcode is null
order by u.unitcode;


/* Using set operator MINUS */
select unitcode
from uni.unit
where unitcode in (
    select unitcode from uni.unit
    minus
    select unitcode from uni.prereq
)
order by unitcode;


/* Using subquery */
SELECT
    unitcode,
    unitname
FROM
    uni.unit
WHERE
    ( unitcode ) NOT IN (
        SELECT
            unitcode
        FROM
            uni.prereq
    )
ORDER BY
    unitcode;



/* 14. List the unit code,  semester, number of enrolments 
and the average mark for each unit offering in 2019. 
Include offerings without any enrolment in the list. 
Round the average to 2 digits after the decimal point. 
If the average result is 'null', display the average as 0.00. 
All values must be shown with two decimal digits. 
Order the list in increasing order of average mark, 
and when the average mark is the same, 
sort by increasing order of semester then by the unit code. */
select unitcode, enrolmark
from(
    select u.unitcode, e.enrolmark, to_char(e.ofyear, 'yyyy')
    from uni.unit u left outer join uni.enrolment e on u.unitcode = e.unitcode
);



/* 15. List all units offered in semester 2 2019 which do not have any enrolment. 
Include the unit code, unit name, and the chief examiner's name in the list. 
Order the list based on the unit code. */



/* 16. List the id and full name of students who are enrolled in both 'Introduction to databases' 
and 'Introduction to computer architecture and networks' (note: both unit names are unique)
in semester 1 2020. Order the list by the student id.*/



/* 17. Given that the payment rate for a tutorial is $42.85 per hour 
and the payment rate for a lecture is $75.60 per hour, 
calculate the weekly payment per type of class for each staff member in semester 1 2020. 
In the display, include staff id, staff name, type of class (lecture or tutorial), 
number of classes, number of hours (total duration), 
and weekly payment (number of hours * payment rate). 
Order the list by increasing order of staff id and for a given staff id by type of class.*/
select s.staffid, staffname 
from uni.staff s join uni.schedclass e on s.staffid = e.staffid;
    
/* 18. Given that the payment rate for a tutorial is $42.85 per hour 
and the payment rate for a lecture is $75.60 per hour, 
calculate the total weekly payment (the sum of both tutorial and lecture payments) 
for each staff member in semester 1 2020. 
In the display, include staff id, staff name, total weekly payment for tutorials, 
total weekly payment for lectures and the total weekly payment. 
If the payment is null, show it as $0.00. 
Order the list by increasing order of staff id.*/


    
/* 19. Assume that all units are worth 6 credit points each, 
calculate each student's Weighted Average Mark (WAM) and GPA. 
Please refer to these Monash websites: https://www.monash.edu/exams/results/wam 
and https://www.monash.edu/exams/results/gpa for more information about WAM and GPA respectively. 
Do not include NULL, WH or DEF grade in the calculation.

Include student id, student full name (in a 40 characters wide column headed student_fullname), 
WAM and GPA in the display. Order the list by descending order of WAM then descending order of GPA.
If two students have the same WAM and GPA, order them by their respective id.
*/




