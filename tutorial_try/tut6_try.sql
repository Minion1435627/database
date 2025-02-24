select avg(salary) as avg_salary
from employee;

-- round will round the argument-- 
-- format will format the argument to D decimal places and include commas-- 
-- round keeps the result as a number-- 
-- format converts the output into a string-- 
 
select format (avg(salary), 2) as avg_salary
from employee;

select round(avg(salary), 2) as avg_salary
from employee;

-- natural join: work when the joining columns names are identical in both tables that are being joined together
select department.name, employee.firstname, employee.lastname
from employee
natural join department; 

select department.name, employee.firstname, employee.lastname
from department
natural join employee; 

select name, firstname, lastname
from employee
natural join department;

-- there is no PK-FK relationship between the item and department table, so the following table return 0
-- it can also be explained as there are no common names in the respective name colimns of the item and department table 
select itemid, departmentid
from item 
natural join department;

-- inner joinL explicitly states what column should join the two tables 
select name, firstname, lastname
from department
inner join employee
on department.departmentID = employee.departmentID;

-- task--  
select name, firstname, lastname
from department
natural join employee
order by name;

select name as Department_name, concat(firstname, ' ', lastname) as employee_name
from department
natural join employee
order by name;

select name as Department_name, concat(firstname, ' ', lastname) as employee_name
from department
inner join employee
on department.departmentID = employee.departmentID
order by name;

-- task 2--
select firstname, lastname
from department
inner join employee
on department.departmentID = employee.departmentID
where name = 'Management';  

-- task 3--
desc supplier;
desc delivery;

select supplier.name, count(delivery.deliveryID) as deliveries
from supplier
inner join delivery
on supplier.supplierID = delivery.supplierID
group by supplier.name
order by name;

-- sub Queries-- 
select min(salary), departmentID
from employee
group by departmentID; 

select min(salary)
from employee;

select departmentID
from employee
where salary = 41000;

-- the query in parenthesis is inner query--  
select departmentID
from employee
where salary = 
	(select min(salary)
    from employee);
    
select departmentID
from department
where floor = 5;

select count(employeeID)
from employee
where departmentid in 
	(select departmentID
    from department
    where floor = 5);
    
-- multiple table join--  
select *
from saleitem;

select name, saledate, quantity
from saleitem
inner join item
inner join sale
on item.itemID = saleitem.itemID
and saleitem.saleID = sale.saleID
where item.name like 'Tent%';


SELECT item.name, sale.saledate, SUM(saleitem.quantity)AS QtyTotal 
FROM item 
INNER JOIN saleitem 
INNER JOIN sale 
ON item.itemid = saleitem.itemid 
AND saleitem.saleid = sale.saleid 
WHERE item.name LIKE 'TENT%' 
GROUP BY item.name, sale.saledate;

-- having clause: acts like a where clause but it identifies groups meeting a criterion. rather than rows-- 
-- having clause usually follow a group by clause--  
select department.name, count(employee.employeeID)
from department
inner join employee
on department.departmentID = employee.departmentID
group by department.name
having count(employee.employeeid) > 2;

select department.name, count(employee.employeeID) as NumEmployees
from department
inner join employee
on department.departmentID = employee.departmentID
group by department.name
having NumEmployees > 2;

-- task -- 
select saleitem.itemID
from sale
inner join saleitem
inner join department
on saleitem.saleId = sale.saleID
and sale.departmentID = department.departmentID
where department.floor = 2
group by saleitem.itemID
having count(distinct(sale.departmentID)) >= 2;

-- task-- 
select departmentID, avg(salary) as AverageSalary
from employee
group by departmentID
having AverageSalary > 55000;


select *
from deliveryitem;

select item.name, deliveryID
from item
inner join deliveryitem
on item.itemid = deliveryitem.itemID;


select item.name, count(deliveryID)
from item
inner join deliveryitem
on item.itemid = deliveryitem.itemID
group by item.name
having count(deliveryID) = 1;

select item.name, count(distinct(supplierID)) as supplierCount
from deliveryitem
inner join delivery
inner join item
on deliveryitem.deliveryID = delivery.DeliveryID
and deliveryitem.itemID = item.itemID
group by item.name
having supplierCount = 1
order by item.name;


-- task10 -- 
select supplier.supplierID, supplier.name
from supplier
inner join delivery
inner join deliveryitem
on supplier.supplierID = delivery.supplierID
and delivery.deliveryID = deliveryitem.deliveryID
group by supplier.supplierID
having count(distinct(deliveryitem.itemID))>=10;

-- task11 -- 
select distinct(item.name), item.type, department.departmentID, department.floor
from item
inner join saleitem
inner join sale
inner join department
on item.itemID = saleitem.itemID
and  saleitem.saleID = sale.saleID
and sale.departmentID = department.departmentID
order by item.name, department.departmentID;

-- task12-- 
select distinct(item.name)
from item
inner join saleitem
inner join sale
inner join department
inner join deliveryitem
inner join delivery
inner join supplier
on item.itemID = saleitem.itemID
and saleitem.saleID = sale.saleID
and sale.departmentID = department.departmentID
and item.itemid = deliveryitem.itemid
and deliveryitem.deliveryID = delivery.deliveryID
and delivery.supplierID = supplier.supplierID
where department.name = 'navigation' or supplier.name = 'Nepalese Corp.';

-- better way for task12-- 
SELECT DISTINCT item.Name 
FROM item 
WHERE ItemID IN
	(SELECT ItemID 
    FROM deliveryitem 
    INNER JOIN delivery 
    INNER JOIN supplier 
    ON deliveryitem.DeliveryID = delivery.DeliveryID 
    AND supplier.supplierID = delivery.supplierID 
    WHERE supplier.Name = 'Nepalese Corp.')
UNION
	(SELECT item.Name 
    FROM saleitem 
    INNER JOIN sale 
    INNER JOIN department 
    INNER JOIN item 
    ON item.ItemID = saleitem.ItemID 
    AND saleitem.SaleID = sale.SaleID 
    AND sale.DepartmentID = department.DepartmentID 
    WHERE department.Name = 'Navigation');









