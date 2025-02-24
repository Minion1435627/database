select *
from item;

-- task1
select itemID, name
from item
where colour = 'green' and type = 'C';

-- task 2
select item.name
from item
inner join deliveryitem
inner join delivery
on item.itemID = deliveryitem.itemID
and deliveryitem.deliveryID = delivery.deliveryID
group by item.name
having count(distinct(delivery.supplierID))>=2
order by item.name;

-- task 3
select firstname, lastname, salary
from employee
inner join department
on department.departmentID = employee.departmentID
where department.name = 'marketing'
and employee.salary in
	(select max(salary)
    from employee
    inner join department
	on department.departmentID = employee.departmentID
    where department.name = 'marketing');
    
-- task 4
select supplier.supplierId, supplier.name
from supplier
where supplierID not in 
		(select supplierID
        from delivery
        inner join deliveryitem
        inner join item
        on delivery.deliveryID = deliveryitem.deliveryID
        and deliveryitem.itemID = item.itemID
        where item.name like 'compass%');
        
-- task 5
select department.name, format(avg(employee.salary),2) as AverageSalary
from department
inner join employee
inner join sale
inner join saleitem
inner join item
on department.departmentID = employee.departmentID
and department.departmentID = sale.departmentID
and sale.saleID = saleitem.saleID
and saleitem.itemID = item.itemID
where item.type = 'E'
group by department.name
order by department.name;

-- task 6
select item.name, sum(saleitem.quantity) as Quantity
from item
inner join sale
inner join saleitem
inner join department
on item.itemID = saleitem.itemID 
and saleitem.saleID = sale.saleID 
and department.departmentID = sale.departmentID
where item.type = 'E' and department.floor = 2
group by item.name;

-- task 7
select item.name, sum(saleitem.quantity) as total_sales
from item
inner join sale
inner join saleitem
inner join department
on item.itemID = saleitem.itemID 
and saleitem.saleID = sale.saleID 
and department.departmentID = sale.departmentID
where department.floor = 2
group by item.name
order by total_sales desc, item.name desc;

-- task 8
select distinct saleitem.itemID, department.floor
from sale
inner join saleitem
inner join department
on sale.saleID = saleitem.saleID
and sale.departmentID = department.departmentID
where itemID not in 
	(select distinct itemID
    from sale
    inner join saleitem
    inner join department
	on sale.saleID = saleitem.saleID
	and sale.departmentID = department.departmentID
    where department.floor = 2)
order by itemID, department.floor;

-- task 9
select employee.employeeID, employee.firstname, employee.lastname, employee.salary as empSal, boss.salary as bossSal
from employee
inner join employee boss
on employee.BossId = boss.employeeID
where boss.salary < employee.salary;

-- task 10
select  department.name, format(avg(employee.salary), 2) as AverageSalary
from department
inner join employee
on department. departmentID = employee.departmentID
where department.floor = 2
group by department.name;

-- task 11
SELECT delivery.SupplierID, s.Name , SUM(deliveryitem.Quantity) AS TotalQty 
FROM supplier s 
INNER JOIN delivery 
INNER JOIN deliveryitem 
INNER JOIN item 
ON s.SupplierID = delivery.SupplierID 
AND delivery.DeliveryID = deliveryitem.DeliveryID 
AND deliveryitem.ItemID = item.ItemID 
WHERE item.Type = 'C' OR item.Type = 'N' 
GROUP BY delivery.SupplierID, s.Name 
HAVING TotalQty > 40;

-- task 12
select s.supplierID, s.name, item.type, item.name, format(avg(deliveryitem.quantity),2)
from supplier s
inner join delivery d
inner join deliveryitem
inner join item
on s.supplierID = d.supplierID
and d.deliveryID = deliveryitem.deliveryID
and deliveryitem.itemID = item.itemID
where item.type = 'N'
group by s.supplierID, s.name, item.type, item.name;

-- task 13
select firstname, lastname, salary
from employee
WHERE employeeID IN
     (SELECT BossID
      FROM employee
      GROUP BY BossID
      HAVING COUNT(*) > 2);
      
-- task 14
SELECT DISTINCT item.Name 
FROM item 
WHERE ItemID IN   
(SELECT ItemID    
FROM deliveryitem    
INNER JOIN delivery    
INNER JOIN supplier    
ON delivery.DeliveryID = deliveryitem.DeliveryID    
AND supplier.SupplierID = delivery.SupplierID    
WHERE supplier.Name = 'Nepalese corp.') 
AND 
ItemID IN   
(SELECT ItemID    
FROM saleitem    
INNER JOIN sale    
INNER JOIN department    
ON saleitem.SaleID = sale.SaleID    
AND sale.DepartmentID = department.DepartmentID    
WHERE department.Name = 'Navigation');

-- task 15
select employee.firstname, employee.lastname, employee.salary
from employee
where employeeID in (
	select bossID
    from employee
    where firstname = 'Clare');
    
-- task 16
select distinct departmentID
from employee
where departmentID not in 
		(select employee.departmentID
		from employee
		inner join employee boss
		on employee.BossID = boss.employeeID
		where boss.salary <= employee.salary)
and employee.bossID is not null
order by departmentID;

-- HW1
select count(deliveryID)
from delivery
where month(deliveryDate) = 07;

-- HW2
select item.name
from item
where item.name like '%tent%' ;

-- HW3
select month(sale.saleDate), sum(saleID) as NumSale
from sale
group by month(sale.saleDate)
order by NumSale desc
limit 1;

-- HW4
select departmentID, count(employee.employeeID), sum(employee.salary)
from employee
group by employee.departmentID
order by sum(employee.salary);

-- HW5
select dayname(saleDate), count(saleID)
from sale
where dayname(saleDate) = 'Sunday'
group by dayname(saleDate);

-- HW6
select datediff(max(deliverydate),min(deliverydate)), delivery.supplierID
from delivery
group by delivery.supplierID;

SELECT SupplierID, DATEDIFF(MAX(deliverydate),MIN(deliverydate)) AS Days_Elapsed, 
	COUNT(DISTINCT(deliverydate)) AS Number_of_Deliveries 
FROM Delivery 
GROUP BY SupplierID;

-- HW7
select concat('The ', name, ' deparment is on floor number ', floor) as 'Where is each department?'
from department;

-- HW8
select departmentId, max(salary), max(salary), avg(salary), stddev(salary)
from employee
group by departmentID;

SELECT DepartmentID, MIN(Salary) AS Lowest_Salary,
	MAX(Salary) AS Highest_Salary, AVG(Salary) AS Average_Salary, STDDEV(Salary) AS Standard_Deviation 
FROM Employee 
GROUP BY DepartmentID;

-- HW9
select count(saleID)
from sale
group by year(saledate);

SELECT COUNT(SaleID) AS Number_of_Sales
FROM sale
WHERE YEAR(SaleDate) = 2017;






















      



 




 
    
        
 

 