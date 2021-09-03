-- SQL Statements and Operators
use upgrad;
# Write your code below
select firstName
from employees;

-- Aggregate Functions
use upgrad;
# Write your code below
select count(*) as totalEmployees
from employees;

-- Ordering
use upgrad;
# Write your code below
select firstname
from employees
order by firstname;

-- String and Date-Time Functions
use upgrad;
# Write your code below
select employeeNumber,
concat(firstname, " ", lastname)
from employees;

-- Regular Expressions
use upgrad;
# Write your code below
select employeeNumber, firstname
from employees
where firstname regexp 'on';

-- Nested Queries
use upgrad;
# Write your code below
select customerName
from customers
where creditLimit > (
select creditLimit
from customers
where customerName = 'La Rochelle Gifts'
);