drop table custbalance;
create table custbalance(
cust_id number(2) not null,
cust_bal number(4) not null,
constraint custbalance_pk primary key (cust_id)
);

insert into custbalance values(1,100);
insert into custbalance values(2,200);
commit;

select * from custbalance;

--task 3
update custbalance set cust_bal = 110 where cust_id = 1;
select * from custbalance;
commit;

--task 4
update custbalance set cust_bal = 150 where cust_id = 2;
select * from custbalance;
commit;

--task 5
update custbalance set cust_bal = 175 where cust_id = 2;
commit;

--task 6
update custbalance set cust_bal = 200 where cust_id = 1;