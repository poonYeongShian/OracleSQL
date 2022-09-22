SET ECHO ON

SPOOL week7_insert.txt

insert into student values
(11111111, 'Bloggs', 'Fred', to_date('1-Jan-2003', 'dd-Mon-yyyy'));
insert into student values
(11111112 , 'Nice', 'Nick', to_date('10-Oct-2004', 'dd-Mon-yyyy'));
insert into student values
(11111113 , 'Wheat', 'Wendy', to_date('5-May-2005', 'dd-Mon-yyyy'));
insert into student values
(11111114 , 'Sheen', 'Cindy', to_date('25-Dec-2004', 'dd-Mon-yyyy'));

insert into unit values
('FIT9999', 'FIT Last Unit');
insert into unit values
('FIT9132', 'Introduction to Databases');
insert into unit values
('FIT9161', 'Project');
insert into unit values
('FIT5111', 'Student''s Life');

insert into enrolment values
(11111111,    'FIT9132',     2020,        1,               35,          N);
insert into enrolment values
(11111111,    'FIT9161',     2020,        1,               61,          'C');
insert into enrolment values
(11111111,   'FIT9132',     2020,        2,               42,          'N');
insert into enrolment values
(11111111,    'FIT5111',     2020,        2,               76,          'D');
insert into enrolment values
(11111111,    'FIT9132',     2021,        1,              NULL,       NULL ) ;  
insert into enrolment values
(11111112,    'FIT9132',     2020,        2,               83,          'HD');
insert into enrolment values
(11111112,    'FIT9161',     2020,        2,               79,          'D');
insert into enrolment values
(11111113,    'FIT9132',     2021,        1,               NULL,       NULL);
insert into enrolment values
(11111113,    'FIT5111',     2021,        1,               NULL,       NULL);
insert into enrolment values
(11111114,    'FIT9132',     2021,        1,               NULL,       NULL);
insert into enrolment values
(11111114,    'FIT5111',     2021,        1,               NULL,      NULL);

select * from student;
select * from unit;
select * from enrolment;


create sequence STUDENT_SEQ start with 11111115 increment by 1;
drop sequence student_seq;
select * from CAT;
-- dont commit after after create sequence but commit after insert
insert into student values (student_seq.nextval, 'Mouse', 'Mickey', to_date('25-Dec-2004', 'dd-Mon-yyyy'));
select * from student;
--------------------------------------------------------------------------------------------------------------------------
insert into student values(student_seq.nextval, 'Mouse', 'Minnie', to_date('25-Dec-2004', 'dd-Mon-yyyy'));
select * from student;

insert into enrolment values(student_seq.currval,(select unit_code from unit where unit_name ='Introduction to Databases'), 2021,1,null,null);
select * from enrolment;

commit;
SPOOL off
set echo off