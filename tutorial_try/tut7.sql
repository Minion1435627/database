select itemID, name
from item
where colour = 'Green';

select item.name
from item
inner join deliveryitem
inner join delivery
inner join supplier
on item.itemID = deliveryitem.itemID
and deliveryitem.deliveryID = delivery.deliveryID
and delivery.supplierID = supplier.supplierID
group by item.name
having count(distinct(supplier.supplierID))>=2
order by item.name;

select firstname, lastname, salary
from employee
inner join department
on department.departmentID = employee.departmentID
where department.name = 'marketing'
order by salary desc
limit 1;

select distinct supplier.supplierID, supplier.name, item.name
from supplier
inner join delivery
inner join deliveryitem
inner join item
on delivery.supplierID = supplier.supplierID
and delivery.deliveryID = deliveryitem.deliveryID
and deliveryitem.itemID = item.itemID
where item.name like 'compass%' 
-- group by supplier.supplierID, supplier.name, item.name
-- having count(item.name = 'compass-silva') > 0
order by supplier.supplierID;


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

-- task 9




























