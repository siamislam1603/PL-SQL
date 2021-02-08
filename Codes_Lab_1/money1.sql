--clear screen;
/* Multiline
	comment*/

drop table money1;

create table money1(id number, name varchar2(20), phone number);

insert into money1 values(1,'A',100);
insert into money1 values(2,'B',110);
insert into money1 values(3,'CD',120);

commit;