select * from custbalance;

--task 4
update custbalance set cust_bal = 150 where cust_id = 2;
commit;

--task 5
update custbalance set cust_bal = 125 where cust_id = 1;
commit;

--task 6
drop table custbalance2;
create table custbalance2(
cust_id number(2) not null,
cust_bal number(4) not null,
constraint custbalance2_pk primary key (cust_id)
);

insert into custbalance2 values(1,100);
insert into custbalance2 values(2,200);
commit;

--demo deadlock

update custbalance2 set cust_bal = 150 where cust_id = 2;

