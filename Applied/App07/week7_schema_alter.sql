SET ECHO ON

SPOOL week7_schema_alter_output.txt

/*
Databases Week 7 Tutorial
week7_schema_alter.sql

Author: Poon Yeong Shian

*/

-- 7.1
-- DDL for Student-Unit-Enrolment model (using ALTER TABLE)
--

--
-- Place DROP commands at head of schema file
--
DROP TABLE student CASCADE CONSTRAINTS;
DROP TABLE unit CASCADE CONSTRAINTS;
DROP TABLE enrolment CASCADE CONSTRAINTS;




-- Create Tables
-- Here using both table and column constraints
--

CREATE TABLE student (
    stu_nbr     NUMBER(8) NOT NULL,
    stu_lname   VARCHAR2(50) NOT NULL,
    stu_fname   VARCHAR2(50) NOT NULL,
    stu_dob     DATE NOT NULL
);

COMMENT ON COLUMN student.stu_nbr IS
    'Student number';

COMMENT ON COLUMN student.stu_lname IS
    'Student last name';

COMMENT ON COLUMN student.stu_fname IS
    'Student first name';

COMMENT ON COLUMN student.stu_dob IS
    'Student date of birth';

/* Add STUDENT constraints here */
ALTER TABLE student ADD CONSTRAINT stu_pk PRIMARY KEY ( stu_nbr );
ALTER TABLE student ADD CONSTRAINT stu_chk CHECK (stu_nbr > 10000000);
--SELECT * FROM user_constraints WHERE TABLE_NAME = 'STUDENT';
--DESC student;

/* Add UNIT data types here */
CREATE TABLE unit (
    unit_code CHAR(7) NOT NULL ,
    unit_name VARCHAR2(50)  NOT NULL
);

COMMENT ON COLUMN unit.unit_code IS
    'Unit code';

COMMENT ON COLUMN unit.unit_name IS
    'Unit name';

/* Add UNIT constraints here */
ALTER TABLE unit ADD CONSTRAINT unit_pk PRIMARY KEY ( unit_code );
ALTER TABLE unit ADD CONSTRAINT unit_uni UNIQUE ( unit_name);

/* Add ENROLMENT attributes and data types here */
CREATE TABLE enrolment (
    stu_nbr NUMBER(8),
    unit_code CHAR(7),
    enrol_year NUMBER(4),
    enrol_semester CHAR(1),
    enrol_mark NUMBER(3),
    enrol_grade CHAR(2)
);

COMMENT ON COLUMN enrolment.stu_nbr IS
    'Student number';

COMMENT ON COLUMN enrolment.unit_code IS
    'Unit code';

COMMENT ON COLUMN enrolment.enrol_year IS
    'Enrolment year';

COMMENT ON COLUMN enrolment.enrol_semester IS
    'Enrolment semester';

COMMENT ON COLUMN enrolment.enrol_mark IS
    'Enrolment mark (real)';

COMMENT ON COLUMN enrolment.enrol_grade IS
    'Enrolment grade (letter)';

/* Add ENROLMENT constraints here */
ALTER TABLE enrolment ADD CONSTRAINT enrolment_pk PRIMARY KEY ( stu_nbr, unit_code, enrol_year, enrol_semester );
ALTER TABLE enrolment ADD CONSTRAINT enrolment_chk CHECK ( enrol_semester >= 1 and enrol_semester <= 3 );

ALTER TABLE enrolment ADD CONSTRAINT enrolment_unit FOREIGN KEY ( unit_code ) REFERENCES unit ( unit_code );
ALTER TABLE enrolment ADD CONSTRAINT enrolment_student FOREIGN KEY ( stu_nbr ) REFERENCES student ( stu_nbr );

SPOOL OFF

SET ECHO OFF