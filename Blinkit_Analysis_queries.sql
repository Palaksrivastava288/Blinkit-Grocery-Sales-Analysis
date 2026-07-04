
create table blinkit_sales(
item_fat_content varchar(50),
item_identifier varchar(50),
item_type decimal(10,6),
outlet_establishment_year int,
outlet_identifier varchar(50),
outlet_location_type varchar(50),
outlet_size varchar(50),
outlet_type varchar(50),
item_visibility decimal(10,2),
item_weight decimal (5,2),
sales decimal(10,2),
rating decimal(3,1)
);

select * from blinkit_sales;

COPY blinkit_sales
(item_fat_content,
item_identifier ,
item_type ,
outlet_establishment_year ,
outlet_identifier,
outlet_location_type ,
outlet_size ,
outlet_type ,
item_visibility ,
item_weight ,
sales,
rating)

---IMPORT DATA FROM CSV FILE--
from 'F:\OneDrive\Desktop\DATA ANALYST\BlinkIT Grocery Data.csv'
delimiter','
csv header;
select count(*) from blinkit_sales;

---SALES ANALYSIS---
--Total Sales--
select sum(sales) as total_sales
from blinkit_sales;

--Average sales--
select round(avg(sales),2) as total_average
from blinkit_sales;

--Highest & Lowest Sales 
select Max(sales) as Highest_sales,
 Min(sales) as Lowest_sales
from blinkit_sales;

--Total Products--
select count(*) as total_products
from blinkit_sales;

--Average Rating--
select round(avg(rating),2) as average_rating
from blinkit_sales;

--OUTLET ANALYSIS--
--Sales by Outlet Size--
select outlet_size,
round(sum(sales),2) as total_sales
from blinkit_sales
group by outlet_size
order by total_sales desc;

--Sales by outlet type--
select outlet_type,
round(sum(sales),2) as total_sales
from blinkit_sales
group by outlet_type
order by total_sales desc;

--Sales by OUTLET_location--
select outlet_location_type,
round(sum(sales),2) as total_sales
from blinkit_sales
group by outlet_location_type
order by total_sales desc;

--Avg sales by outlet type
select outlet_type,
round(avg(sales),2) as average_sales_outlet
from blinkit_sales
group by outlet_type;

--Product count by outlet_type
select outlet_type,count(*) as total_products
from blinkit_sales
group by outlet_type;

--PRODUCT ANALYSIS--
select * from blinkit_sales;

--Sales by item type--
select item_type,
round(sum(sales),2) as total_sales
from blinkit_sales
group by item_type
order by total_sales;

--Average rating by item type
select item_type,
round(avg(sales),2) as average_rating 
from blinkit_sales
group by item_type
order by average_rating;

--Product count by item type
select item_type,
count (*) as total_products
from blinkit_sales
group by item_type
order by total_products;

--Sales by item fat content--
select item_fat_content,
round(sum(sales),2) as total_sales
from blinkit_sales
group by item_fat_content
order by total_sales;

--Average Sales by item fat content--
select item_fat_content,
round(avg(sales),2) as total_sales
from blinkit_sales
group by item_fat_content
order by total_sales;

----Filtering and Ranking---
--Top 10 Highest selling Products--
select * from blinkit_sales;

select item_type,sales
from blinkit_sales
order by sales desc
limit 10;

--Bottom 10 selling Products--
select item_type,sales
from blinkit_sales
order by sales asc
limit 10;

--Product with rating above 4--
select item_type,rating
from blinkit_sales
where rating>4;

--Product with sales above average--
select item_type,sales
from blinkit_sales
where sales >
(select avg(sales) from blinkit_sales);

--Medium Outlet Products--
select outlet_size, item_type
from blinkit_sales
where outlet_size='Medium';

---CASE STATEMENTS---

--Categorize Sales--
select item_identifier,sales,
CASE
when sales<100 then 'low'
when sales between 100 and 200 then 'Medium'
else 'High'
end as sales_category
from blinkit_sales;

--Categorize Rating--
select item_identifier,rating,
CASE
when sales>=5 then 'Excellent'
when sales between 5 and 4 then 'good'
else 'poor'
end as sales_rating
from blinkit_sales;

select * from blinkit_sales;

--WINDOW FUNCTIONS--

--Rank by sales products--
select item_identifier,sales,
Rank() Over(Order by sales desc) as sales_rank 
from blinkit_sales;

--Dense Rank--
select item_identifier,sales,
Dense_Rank() Over(Order by sales desc) as dense_rank 
from blinkit_sales;

--row number--
select item_identifier,sales,
Row_Number() Over(Order by sales desc) as row_num
from blinkit_sales;

---Running total_sales--
select item_identifier,sales,
Sum(sales) Over(Order by sales desc) as running_total 
from blinkit_sales;

--CTE--
--Total Sales by outlet using cte--
with outlet_sales as (
select outlet_type, sum(sales) as total_sales
from blinkit_sales
group by outlet_type
)
select * from outlet_sales
order by total_sales desc;

--Average ranking by item using CTE--
with item_rating as(
select item_type,
avg(rating) as avg_rating
from blinkit_sales
group by item_type
)

select * from item_rating
order by avg_rating desc;
