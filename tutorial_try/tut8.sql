-- 1 
select item.Name, sum(saleitem.quantity) as Unitsold
from item
inner join saleitem
on item.itemId = saleitem.itemID
group by item.name
order by item.name;

-- 
select item.name, sum(saleitem.quantity) as Unitsold
from saleitem
right outer join item
on saleitem.itemID = item.itemID
group by item.name
order by item.name;

-- 2
select supplier.name, count(deliveryitem.itemId) as unique_item_count
from supplier
inner join delivery
inner join deliveryitem
on supplier.supplierID = delivery.supplierID
and delivery.deliveryID = deliveryitem.deliveryID
group by supplier.name
having count(deliveryitem.itemId) <= 2
order by supplier.name;

-- 3
select distinct supplier.name
from supplier
-- inner join delivery
-- inner join deliveryitem
-- inner join item
-- on delivery.supplierID = supplier.supplierID
-- and delivery.deliveryID = deliveryitem.deliveryID
-- and item.itemID = deliveryitem.itemID
where supplier.supplierID not in 
	(select supplierID
    from delivery
    inner join deliveryitem
	inner join item
    on delivery.deliveryID = deliveryitem.deliveryID
	and item.itemID = deliveryitem.itemID
    where item.name like 'compass%');
    
-- 4
select boss.firstname as manager, emp.firstname as employee
from employee as emp
inner join employee as boss
on emp.BossID = boss.employeeID
order by boss.firstname, emp.firstname;

-- 5 
select boss.firstname as manager, emp.firstname as employee
from employee as emp
left outer join employee as boss
on emp.BossID = boss.employeeID
order by boss.firstname, emp.firstname;

-- 6
select boss.employeeID, concat(boss.firstname, ' ', boss.lastname) as ename, count(emp.employeeID) as emp_count
from employee as emp
inner join employee as boss
on emp.bossID = boss.employeeID
group by boss.employeeID, boss.firstname
order by emp_count desc;

-- view
create view vdepartment_wages as 
select d.departmentID, d.name, sum(salary) as totalwages
from department d
inner join employee e
on d.departmentID = e.departmentID
group by d.departmentID, d.name
order by d.departmentID; 

select *
from vdepartment_wages
where totalwages > 150000;

SELECT * 
FROM     
	(SELECT d.departmentID, d.Name, SUM(Salary) AS TotalWages      
	FROM department d
    INNER JOIN employee e
    ON d.departmentID = e.departmentID      
    GROUP BY departmentID, Name      
    ORDER BY departmentID) as vdepartment_Wages 
WHERE TotalWages > 150000;

SELECT table_name, view_definition 
FROM Information_schema.views ;
-- WHERE Table_SCHEMA= 'labs2018'  remove comment for BYOD devices ;


-- 7 
create view vdepartmentsalary (departmentID, dptavgsal) as 
select departmentID, avg(salary)
from employee
group by departmentId;

select firstname, lastname, format((salary - dptavgsal), 2) as salary_deptavgsalary
from vdepartmentsalary 
inner join employee
inner join department
on vdepartmentsalary.departmentID = employee.departmentID
and department.departmentID = employee.departmentID
where department.name = 'accounting';

-- 8
select firstname, lastname, salary, format(dptavgsal, 2) as deptavsal, format((salary - dptavgsal), 2) as diffavgdsal
from vdepartmentsalary
inner join employee
on vdepartmentsalary.departmentID = employee.departmentID;

-- 9
create view vsupplierdepartment as(
select distinct supplierID, departmentID
from delivery
inner join deliveryitem
inner join item
on delivery.deliveryID = deliveryitem.deliveryID
and deliveryitem.itemID = item.itemID
where item.type = 'E' );

select count(*)
from vsupplierdepartment;

-- 10
create view vdepartmentsales as
select d.departmentID, d.name as departmentname, count(*) as numsales
from department d
inner join sale s
on d.departmentID = s.departmentID
group by d.departmentID, d.name;

-- 11 
select *
from vdepartmentsales
where numsales >= 5;

-- 12
create view vemployeesalary as
select d.departmentID, d.name, max(emp.salary) as maxsal,  avg(emp.salary) as avgsal, 
		min(emp.salary) as minsal, sum(emp.salary) as totalsal, count(emp.employeeID) as headcount
from employee as emp
inner join department as d
on d.departmentID = emp.departmentID
group by d.departmentID, d.name;

-- 13
select departmentID, Name, minsal
from vemployeesalary
where headcount in 
	(select max(headcount)
    from vemployeesalary);
    
-- 14
SELECT DISTINCT departmentID 
FROM deliveryitem del1 
WHERE not EXISTS      
		(SELECT *       
		FROM deliveryitem del2       
		WHERE del2.departmentID = del1.departmentID
        and not exists
        (select *
        from saleitem
        inner join sale
        on saleitem.saleID = sale.saleID
        where del2.itemID = saleitem.itemID
        and del1.departmentID = sale.departmentID));
        
SELECT distinct(departmentid), itemid 
FROM deliveryitem 
ORDER BY departmentid, itemid;

SELECT DISTINCT(departmentid), saleitem.itemid 
FROM saleitem 
INNER JOIN sale 
ON sale.saleid = saleitem.saleid 
ORDER BY departmentid, itemid;

-- 15
select saleitem.itemID
from saleitem
inner join sale
inner join department
on saleitem.saleID = sale.saleID
and sale.departmentID = department.departmentID
where department.floor = 2
group by saleitem.itemID
having count(distinct department.departmentID) =
		(select count(distinct departmentID)
        from department
        where department.floor = 2)
order by saleitem.itemID;





 






    












