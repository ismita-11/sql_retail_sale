CREATE TABLE Retail_sales(
           transactions_id INT,
           sale_date DATE,	
           sale_time TIME,
            customer_id	 INT,
            gender	VARCHAR(8),
             age INT,
             category VARCHAR(11),
              quantiy	INT,
             price_per_unit	FLOAT,
              cogs FLOAT,	
            total_sale FLOAT);

sales;

SELECT * FROM Retail_sales;
select count(*) from Retail_sales;
----DATA CLEANING
Select * From Retail_sales
where transactions_id is NULL 
     or
	 sale_date is NULL
	 or
	 sale_time is NULL
	 or
	 gender is NULL
	 or age is NULL
	 or
	 category is NULL
	 or
	 quantity is NULL
	 or 
	 price_per_unit is NULL
	 or cogs is NULL
	 or
	 total_sale is NULL;
----change the name of a column
ALTER TABLE Retail_sales
RENAME quantiy TO quantity;

select * from retail_sales;
----delete
DELETE FROM Retail_sales
where transactions_id is NULL 
     or
	 sale_date is NULL
	 or
	 sale_time is NULL
	 or
	 gender is NULL
	 or age is NULL
	 or
	 category is NULL
	 or
	 quantity is NULL
	 or 
	 price_per_unit is NULL
	 or cogs is NULL
	 or
	 total_sale is NULL;
----Data Exploration
----How many sales we have?
select count(*) as total_sale from Retail_sales
----How many  unique customers do we have?
select count( DISTINCT customer_id) as total_cust from Retail_sales
----How many unique category do we have?
select count(distinct category) as type_cate from retail_sales
---- what are the category?
select distinct category from retail_sales;

---DATA ANALYSIS AND BUSSINESSKEY PROBLEMS
---Q1-write a sql query to retrive all columns for sales made on '2022-11-05'
select * from retail_sales
where sale_date ='2022-11-05'
---Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales
where category = 'Clothing' and quantity =4 
and TO_CHAR(sale_date,'YYYY-MM') ='2022-11'; 
---- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
select category ,sum(total_sale) as net_scale, count (quantity) as total_orders from retail_sales
group by category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select floor(avg(age)) from retail_sales
where category='Beauty'
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(*)as total_transaction,gender,category from retail_sales
group by gender, category
order by category;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
select year, month, avg_sale from
(select
EXTRACT(year from sale_date) as  year,
EXTRACT(month from sale_date) as month,
avg(total_sale) as avg_sale ,
rank() over(partition by EXTRACT(year from sale_date) order by avg(total_sale) desc ) as rank from retail_sales
group by year,month) as t1 where rank =1;
--order by year,month;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) as total_sales from retail_sales
group by 1
order by 2 desc
limit 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(DISTINCT customer_id) as num_cust from retail_sales
group by 1
order by 2 ;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
WITH hourly_sale 
AS
(
select *,
CASE 
   WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17  THEN 'Afternoon'
   ELSE 'Evening'
END AS shift
from retail_sales )
SELECT shift,COUNT (*) as total_orders FROM hourly_sale
group by shift

select * from hourly_sale

