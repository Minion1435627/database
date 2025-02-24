-- 3.1
alter table emp
add constraint FK_DEPT
foreign key (deptno) references DEPT(deptno)
on delete cascade
on update cascade;

-- 3.2
-- query the infromation_schema to see the table constraints on the EMP & DEPT table
SELECT *
FROM information_schema.table_constraints
WHERE table_name IN ('emp', 'dept');

select * from emp;

-- 3.3 
INSERT INTO emp
VALUES (8182, 'SODERBERGH', 'DIRECTOR', 7839, '2012-08-25', 8000, null, null);

select * from emp;

-- 3.4 
update emp
set deptno = 50
where name = 'SODERBERGH';
-- because there is no deptno 50
-- so we have to insert deptno 50 in the dept table first

-- 3.5 
insert into dept values
(50, 'movie', 'HOLLYWOOD');

select *
from dept;

-- 3.6
-- run again the 3.4, this time we can find that SODERBERGH is now belong to deptno 50  
update emp
set deptno = 50
where name = 'SODERBERGH';

select * from emp;

-- 3.7 
alter table emp
add constraint FK_BOSS
foreign key (boss) references emp(empno)
on delete restrict
on update restrict;

SELECT *
FROM information_schema.table_constraints
WHERE table_name IN ('emp', 'dept');

-- 3.8 
insert into emp values
(8385, 'LAWRENCE', 'ACTOR', 8182, '2012-08-28', 8500, null, 50);

select * from emp;

-- 3.9 
select empno, emp.name, boss, emp.deptno, dept.name
from emp
inner join dept
on emp.deptno = dept.deptno
where dept.deptno =50;

-- 3.10 
update dept
set deptno = 60
where deptno = 50;

select * from dept;

-- 3.11
-- run the 3.9 again, we will find that there is no row return
-- because the constraint has update the foreign key records in the EMP table 
select empno, emp.name, boss, emp.deptno, dept.name
from emp
inner join dept
on emp.deptno = dept.deptno
where dept.deptno =50;

-- 3.12 
select empno, emp.name, boss, emp.deptno, dept.name
from emp
inner join dept
on emp.deptno = dept.deptno
where dept.deptno =60;

-- 3.13
-- this will give an error, because SODERBERGH is the manager of LAWRENCE 
delete from emp
where name = 'SODERBERGH';

select * from emp;

-- 3.14
-- continous from 3.13, now we need to change the manager for LAWRENCE 
update emp
set boss = 7839
where name = 'LAWRENCE';

delete from emp
where name = 'SODERBERGH';

-- 3.15
drop table dept;
drop table emp;
drop table  salgrade;
drop table bonus;



















