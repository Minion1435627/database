create table customer
(customerID smallint auto_increment,
firstname varchar(25),
lastname varchar(30) not null,
phone varchar(16) not null,
BirthDate Date not null,
primary key (customerID)
);

select *
from customer;

desc customer;

insert into customer values
(default, 'Jon', 'Smith', 22522255, '1985-12-15'),
(default, 'Ann', 'Hone', 22454852, '1956-1-22'),
(default, 'Jun', 'De', 26854582, '1984-6-6'),
(default, 'Kent', 'King', 12556842, '1971-5-9'),
(default, 'Barb', 'Smith', 33665252, '1969-6-12'),
(default, null, 'Senti', 75584252, '2000-2-25');

update customer
set firstname = 'Yoshi'
where lastname = 'Senti';


delete from customer
where firstname = 'Kent'
and lastname = 'King';

select firstname, lastname
from customer
where firstname='Yoshi' and lastname = 'Senti'
or
firstname = 'Kent' and lastname = 'King';

select * from customer;

insert into customer values
(default, 'Mary', 'Jane', 22222222, '1990-01-01');

delete from customer; -- delete all column in customer table;





