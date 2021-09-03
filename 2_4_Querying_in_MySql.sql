-- 2. SQL Statements and Operators
-- select
select * from cust_dimen;

select Customer_Name from cust_dimen;

select Customer_Name as "Person Name", City, State  
from cust_dimen;

-- count
select count(*) as Total_Customers
from cust_dimen;

-- where
select Customer_Name, City, State  
from cust_dimen
where State = "West Bengal";

-- and
select Customer_Name, City, State  
from cust_dimen
where State = "West Bengal" and city = "Kolkata";

select count(*) as Total_Customers
from cust_dimen
where State = "West Bengal";

-- or
select count(*)
from cust_dimen
where State = 'Maharashtra' or Customer_Segment = 'Corporate';

-- in
select * from cust_dimen
where state in ("Tamil Nadu", "Karnataka", "Telangana", "Kerala");

-- not
select * from cust_dimen
where Customer_Segment != "Small Business";

-- <
select Ord_id, Profit
from market_fact_full
where profit < 0;


-- between
select Ord_id, Shipping_Cost
from market_fact_full
where Ord_id like "%\_5%" and Shipping_Cost between 10 and 15;

-- like
select * from cust_dimen
where city like "K%";

-- group by
select count(Customer_Name) as city_wise , city
from cust_dimen
group by city;

select count(Customer_Name) as city_wise , city, Customer_Segment
from cust_dimen
group by city, Customer_Segment;

select count(Customer_Name) as segment_wise , Customer_Segment
from cust_dimen
where state = 'Bihar'
group by Customer_Segment;

-- order by
select customer_name
from cust_dimen
order by Customer_Name;

-- distinct
select distinct customer_name
from cust_dimen
order by Customer_Name desc;

select customer_name, state
from cust_dimen
order by state, Customer_Name;

-- limit
select prod_id, sum(Order_Quantity)
from market_fact_full
group by prod_id
order by sum(Order_Quantity) desc
limit 3;

-- having
select prod_id, sum(Order_Quantity)
from market_fact_full
group by prod_id
having sum(Order_Quantity) > 50
order by sum(Order_Quantity) desc;

-- 6. String and Date-Time Functions
-- concat
select product_category, product_sub_category,
concat(product_category, "_", product_sub_category) as Product_Name
from prod_dimen;

-- substring
select product_category, product_sub_category,
substring(concat(product_category, "_", product_sub_category), 2, 3) as Product_Name
from prod_dimen;

-- substring_index
select product_sub_category,
substring_index(product_sub_category, " ", 1)
from prod_dimen
limit 10;

-- lower
select lower(product_category)
from prod_dimen;

-- reverse
select product_category, reverse(product_category)
from prod_dimen;
-- month
select count(Ship_id) as Ship_Count, month(Ship_Date) as Ship_Month
from shipping_dimen
group by Ship_Month
order by Ship_Count desc
limit 1;

-- year
select count(Ord_id) as Order_Count, month(Order_Date) as Order_Month,
year(Order_Date) as Order_Year
from orders_dimen
where Order_Priority = 'Critical'
group by Order_Year, Order_Month
order by Order_Count desc;

-- year
select Ship_Mode, count(Ship_Mode) as Ship_Mode_Count
from shipping_dimen
where year(Ship_Date) = 2011 
group by Ship_Mode
order by Ship_Mode_Count desc;

-- 7. Regular Expressions
-- regexp
select Customer_Name
from cust_dimen
where Customer_Name regexp 'car';

select Customer_Name
from cust_dimen
where Customer_Name regexp '^[abcd].*er$';

-- 8. Nested Queries
select Ord_id, Sales, round(Sales) as Rounded_Sales
from market_fact_full
where Sales = (
select max(Sales)
from market_fact_full
);

-- is null
select Prod_id
from market_fact_full
where Product_Base_Margin is null;

select *
from prod_dimen
Where Prod_id in (
select Prod_id
from market_fact_full
where Product_Base_Margin is null
);

select Customer_Name, Cust_id
from cust_dimen
where Cust_id =(
select Cust_id
from market_fact_full
group by Cust_id
order by count(Cust_id) desc
limit 1
);

Select Product_Category, Product_Sub_Category
from prod_dimen
where Prod_id in (
select Prod_id 
from market_fact_full
group by Prod_id
order by count(Prod_id) desc
) limit 3;

-- 9. CTEs
with least_losses as (
Select Prod_id, Profit, Product_Base_Margin
from market_fact_full
where Profit < 0
order by Profit desc
limit 5
) select *
from least_losses
where Product_Base_Margin = (
select max(Product_Base_Margin)
from least_losses
);

with low_priority_orders as (
select Ord_id, Order_Date, Order_Priority
from orders_dimen
where Order_Priority = 'low' and month (Order_Date) = 4
) select count(Ord_id) as Order_Count, Order_Date
from low_priority_orders
where day (Order_Date) between 1 and 15;

-- 10. Views
create view order_info
as select Ord_id, Sales, Order_Quantity, Profit, Shipping_Cost
from market_fact_full;

select Ord_id, Profit
from order_info
where Profit > 1000;