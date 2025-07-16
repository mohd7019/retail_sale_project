CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );


SELECT COUNT(*) FROM RETAIL_SALES

SELECT * FROM RETAIL_SALES

-- DATA CLEANING

select * from retail_sales
where transaction_id is null or sale_time is null or gender is null or category is null or quantity is null or cogs is null or total_sale is null; 

-- removing null values 

delete from retail_sales 
where transaction_id is null or sale_time is null or gender is null or category is null or quantity is null or cogs is null or total_sale is null; 


----------------------------------------------------------------------------------------------------

--DATA EXPLORATION


-- HOW MANY SALES WE HAVE ?

SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES


-- HOW MANY CUSTOMER WE HAVE ?

SELECT COUNT(*) AS TOTAL_CUSTOMERS FROM RETAIL_SALES

-- HOW MANY UNIQUE CUSTOMERS WE HAVE ?

SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMER FROM RETAIL_SALES

-- UNIQUE CATEGORY ?

SELECT COUNT (DISTINCT CATEGORY) AS TOTAL_CATEGORY FROM RETAIL_SALES

--------------------------------------------------------------------------------------------------

-- DATA ANALYSIS AND SOLVING BUISNESS KEY PROBLEMS

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM RETAIL_SALES

SELECT * 
FROM RETAIL_SALES
WHERE SALE_DATE = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity 
     --sold is more than 4 in the month of Nov-2022

SELECT *
FROM RETAIL_SALES
WHERE category ILIKE 'clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;




-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category , sum(total_sale) as total_sales
from retail_sales
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items 
      --  from the 'Beauty' category.

SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category ILIKE 'beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select transaction_id 
from retail_sales
where total_sale > 1000


--  Q.6 Write a SQL query to find the total number of transactions (transaction_id) 
       --  made by each gender in each category.

select gender , category , count(transaction_id) as total_no_of_transaction
from retail_sales
group by 1, 2


-- Q.7 Write a SQL query to find the top 5 customers based on the highest total sales


	  
select customer_id , sum(total_sale)
from retail_sales
group by 1
order by 2 desc
limit 5


-- Q.8 Write a SQL query to find the number of unique customers who purchased 
      --  items from each category.


select category , count(distinct customer_id) as unique_customer
from retail_sales
group by 1


-- Q.9 Write a SQL query to create each shift and number of orders 
    --  (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hour_sale 
as
(select 
      case
	      when extract(hour from sale_time) < 12 then 'morning'
		  when extract(hour from sale_time) between 12 and 17 then 'afternoon'
		  else 'evening'
	end as shift 
from retail_sales)
select shift , count(*) as total_orders from hour_sale
group by shift




-- -- Q.10 Write a SQL query to calculate the average sale for each month. 
      --  Find out best selling month in each year


SELECT year,
       month,
       avg_monthly_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale)::numeric, 2) AS avg_monthly_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM 
        retail_sales
    GROUP BY 
        EXTRACT(YEAR FROM sale_date),
        EXTRACT(MONTH FROM sale_date)
) ranked_months
WHERE sales_rank = 1
ORDER BY year;
