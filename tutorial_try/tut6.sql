select avg(salary) as avg_salary
from employee;

select format(avg(salary), 2) as avg_salary
from employee;

select round(avg(salary), 2) as avg_salary
from employee;

select department.name, employee.firstname, employee.lastname
from employee
natural join department;

desc department;
desc employee;

select name, firstname, lastname
from employee
natural join department;

select itemID, departmentID
from item
natural join department;

select name, firstname, lastname
from department
inner join employee
on department.departmentID = employee.departmentID;

select name, firstname, lastname
from department
natural join employee
order by name;

select name as department_name, concat(firstname, ' ',lastname) as Employee_name
from department
natural join employee
order by name;

select name as department_name, concat(firstname, ' ',lastname) as Employee_name
from department
inner join employee
on department.departmentID = employee.departmentID
order by name;

select firstname, lastname
from employee
inner join department
on department.departmentID = employee.departmentID
where name = 'Management';


select *
from supplier;

select *
from delivery;

select name, count(*) as deliveries
from delivery
inner join supplier
on supplier.supplierID = delivery.supplierID
group by supplier.supplierID
order by name;














