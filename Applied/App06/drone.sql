/*
Databases Week 6 Forum
drone_schema_start.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/


/* drop all tables*/
DROP TABLE customer CASCADE CONSTRAINTS PURGE;

DROP TABLE cust_train CASCADE CONSTRAINTS PURGE;

DROP TABLE drone CASCADE CONSTRAINTS PURGE;

DROP TABLE rental CASCADE CONSTRAINTS PURGE;

DROP TABLE training_course CASCADE CONSTRAINTS PURGE;

/* Purple tables on slide 35*/
CREATE TABLE drone (
    drone_id           NUMBER(5) NOT NULL,
    drone_pur_date     DATE NOT NULL,
    drone_pur_price    NUMBER(7, 2) NOT NULL,
    drone_flight_time  NUMBER(6, 1) NOT NULL,
    drone_cost_hr      NUMBER(6, 2) NOT NULL,
    dt_code            CHAR(4) NOT NULL
);

COMMENT ON COLUMN drone.drone_id IS
    'drone id (unique for each drone)';

COMMENT ON COLUMN drone.drone_pur_date IS
    'drone purchase date';

COMMENT ON COLUMN drone.drone_pur_price IS
    'drone purchase price';

COMMENT ON COLUMN drone.drone_flight_time IS
    'drone flight time completed since purchase';

COMMENT ON COLUMN drone.drone_cost_hr IS
    'drone rate per hour';

COMMENT ON COLUMN drone.dt_code IS
    'drone type code';

ALTER TABLE drone ADD CONSTRAINT drone_pk PRIMARY KEY ( drone_id );


CREATE TABLE training_course (
    train_code        CHAR(5) NOT NULL,
    traincourse_date  DATE NOT NULL,
    trainer_id        NUMBER(3) NOT NULL
);

COMMENT ON COLUMN training_course.train_code IS
    'training code (unique for each training)';

COMMENT ON COLUMN training_course.traincourse_date IS
    'training course date';

COMMENT ON COLUMN training_course.trainer_id IS
    'trainer unique id';

ALTER TABLE training_course ADD CONSTRAINT training_course_pk PRIMARY KEY ( train_code,
                                                                            traincourse_date );
/* Student work starts here customer:*/
CREATE TABLE customer (
    cust_id           NUMBER(4) NOT NULL,
    cust_fname     VARCHAR2(25) NOT NULL,
    cust_lname    VARCHAR2(25) NOT NULL,
    cust_phone  CHAR(12) NOT NULL
);

COMMENT ON COLUMN customer.cust_id IS
    'customer id (unique for each customer)';

COMMENT ON COLUMN customer.cust_fname IS
    'customer first name';

COMMENT ON COLUMN customer.cust_lname IS
    'customer last name';

COMMENT ON COLUMN customer.cust_phone IS
    'customer phone no';


/* Student work starts here rental:*/
CREATE TABLE rental (
    rent_no   NUMBER(8) NOT NULL,
    rent_bond NUMBER(6,2) NOT NULL,
    rent_out  DATE NOT NULL,
    rent_in   DATE,
    drone_id  NUMBER(5) NOT NULL,
    ct_id     NUMBER(7) NOT NULL
);

COMMENT ON COLUMN rental.rent_no IS
    'rental number (unique for each rental)';

COMMENT ON COLUMN rental.rent_bond IS
    'rental first name';

COMMENT ON COLUMN rental.rent_out IS
    'rental out';

COMMENT ON COLUMN rental.rent_in IS
    'rental in';
    
COMMENT ON COLUMN rental.drone_id IS
    'rental drone id';
    
COMMENT ON COLUMN rental.ct_id  IS
    'rental customer train id';
    
/* Student work starts here customer train:*/
CREATE TABLE cust_train (
    ct_id             NUMBER(7),
    cust_id           NUMBER(4),
    train_code        CHAR(5),
    traincourse_date  DATE,
    ct_exam_date      DATE,
    ct_date_expire    DATE
);

COMMENT ON COLUMN cust_train.ct_id  IS
    'customer train id (unique for each customer training)';

COMMENT ON COLUMN cust_train.cust_id   IS
    'customer id';

COMMENT ON COLUMN cust_train.train_code IS
    'training code';

COMMENT ON COLUMN cust_train.traincourse_date IS
    'training course date';
    
COMMENT ON COLUMN cust_train.ct_exam_date IS
    'customer training exam date';
    
COMMENT ON COLUMN cust_train.ct_date_expire  IS
    'customer training expired date';

/* Primary Keys*/
ALTER TABLE customer ADD CONSTRAINT cust_pk PRIMARY KEY ( cust_id );
ALTER TABLE rental ADD CONSTRAINT rental_pk PRIMARY KEY ( rent_no );
ALTER TABLE cust_train ADD CONSTRAINT cust_train_pk PRIMARY KEY ( ct_id );

/* Foreign key*/
ALTER TABLE rental ADD CONSTRAINT drone_rental FOREIGN KEY ( drone_id ) REFERENCES drone ( drone_id );
ALTER TABLE rental ADD CONSTRAINT custtrain_rental FOREIGN KEY ( rent_no ) REFERENCES cust_train ( ct_id );

ALTER TABLE cust_train ADD CONSTRAINT customer_custtrain FOREIGN KEY ( cust_id ) REFERENCES customer ( cust_id );
ALTER TABLE cust_train ADD CONSTRAINT traincourse_custtrain FOREIGN KEY ( train_code, traincourse_date ) REFERENCES training_course ( train_code, traincourse_date );
ALTER TABLE cust_train ADD CONSTRAINT cust_train_uq UNIQUE ( cust_id, train_code,traincourse_date );
