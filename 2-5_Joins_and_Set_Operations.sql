-- 4. Types of Joins: A Demonstration
-- inner join
select Ord_id, Product_Category, Product_Sub_Category, Profit
from prod_dimen p inner join market_fact_full m
on p.Prod_id = m.Prod_id;

select m.prod_id, m.Profit, p.product_category, s.ship_mode
from market_fact_full m inner join prod_dimen p on m.prod_id = p.prod_id
inner join shipping_dimen s on m.ship_id = s.ship_id;

select Customer_Name, sum(Order_Quantity) as Total_Orders
from cust_dimen c
inner join market_fact_full m
on c.Cust_id = m.Cust_id
group by Customer_Name
order by Total_Orders desc;

-- using
select Customer_Name, sum(Order_Quantity) as Total_Orders
from cust_dimen c
inner join market_fact_full m
using(Cust_id)
group by Customer_Name
order by Total_Orders desc;

select p.prod_id, Profit, Product_Category, City, sum(Profit) as City_Wise_Profit
from prod_dimen p
inner join market_fact_full m
on p.prod_id = m.Prod_id
inner join cust_dimen c
on m.Cust_id = c.Cust_id
where Product_Category = 'Office Supplies' and City in ('Delhi', 'Patna')
group by City;

select Customer_Name, count(Customer_Name) as No_of_Orders
from cust_dimen c
inner join market_fact_full m
on c.cust_id = m.cust_id
group by Customer_Name
order by No_Of_Orders desc
limit 1;

select Product_Category, Product_Sub_Category, Order_Quantity
from prod_dimen p
inner join market_fact_full m
on p.Prod_id = m.Prod_id
group by Product_Sub_Category
order by Order_Quantity desc
limit 3;

-- 5. Outer Joins: A Demonstration
select * from manu;

select distinct manu_id from prod_dimen;

Select m.manu_name, p.prod_id
from manu m INNER JOIN prod_dimen p on m.manu_id = p.manu_id;

-- left join
Select m.manu_name, p.prod_id
from manu m LEFT JOIN prod_dimen p on m.manu_id = p.manu_id;

select m.manu_name, count(prod_id)
from manu m INNER JOIN prod_dimen p 
using(manu_id)
group by m.manu_name;

select m.manu_name, count(prod_id)
from manu m LEFT JOIN prod_dimen p 
using(manu_id)
group by m.manu_name;

-- 6. Views with Joins
create view order_details
as select Customer_Name, Customer_Segment, Sales, Order_Quantity, Product_Category, Product_Sub_Category
from cust_dimen c
inner join market_fact_full m
on c.Cust_id = m.Cust_id
inner join prod_dimen p
on m.Prod_id = p.prod_id;

select * from order_details;

-- 7. Set Operations with SQL
-- union
-- Two most profitable and two least profitable products
(select Prod_id, sum(Profit)
from market_Fact_full
group by Prod_id
order by sum(Profit) desc
limit 2)
union
(select Prod_id, sum(Profit)
from market_fact_full
group by Prod_id
order by sum(Profit)
limit 2);