-- Types of Joins: A Demonstration
use upgrad;
# Write your code below
select c.customerName
from customers c inner join
orders o
using(customerNumber)
group by customerName
having count(o.orderNumber) > 0;
