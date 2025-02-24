DESC Department;

-- select-- 
select * 
from department;

select * 
from employee;

--  filitering -- 
select name, floor
from department;

select firstname, lastname, departmentid
from employee;

select *
from department
where floor = 2;

select *
from department
where name like 'M%';

select firstname, lastname, departmentid, salary
from employee
where salary < 55000;

--  multiple conditions -- 
select *
from department
where name like 'M%'
and managerID = 1;

select *
from department
where name like 'M%'
or managerID = 1;

desc department;
desc employee;

-- math condition--  
select * 
from department
where floor >1;

select name, floor
from department
where floor != 5;

select name, floor
from department
where floor <> 5;

-- oder by--  
select name,floor
from department
where floor!=5
order by floor;

select * 
from department
order by floor desc;  -- oder by descending order--  

select *
from department
order by floor desc, departmentID asc;

select firstname, lastname, departmentID, salary
from employee
where departmentID = 11
and salary > 55000;

select firstname, lastname, departmentID, salary
from employee
where departmentID = 11
or salary > 55000;

select firstname, lastname, salary,departmentID
from employee
where salary >= 45000
order by salary desc;

select *
from employee
order by departmentID, lastname;

-- limit --  
select name
from department
where floor = 5
order by name asc
limit 2;

select name
from department
where floor = 5
order by name desc
limit 2;

select firstname, lastname, salary
from employee
order by salary desc
limit 5;

-- adding--
select '1435627' as stuID, name, floor
from department;  

select '1435627' as stuID, department. *
from department; 

-- function--  
select count(*)
from department;

select count(name)
from department;

select concat(firstname, ' ', lastname, ' works in the ', department.name, 'department') as info
from employee
natural join department;

select count(*)
from employee;

-- group by-- 
select floor, count(departmentID)
from department
group by floor
order by floor;

-- alias--  
select floor as dept_floor, count(departmentID) as dept_count
from department
group by dept_floor
order by dept_floor;

select departmentid, count(employeeid)
from employee
group by departmentid
order by departmentid;

select departmentid, avg(salary)
from employee
group by departmentid
order by departmentid;

select departmentid, max(salary)
from employee
group by departmentid
order by max(salary) desc
limit 1;


select departmentid, min(salary)
from employee
group by departmentid
order by min(salary)
limit 1;







