/*SELECT * FROM retail_sales
where transaction_id is NULL 
OR 
sale_date is NULL 
OR
sale_time  is NULL 
OR
quantiy is NULL
OR 
category is NULL 
OR 
customer_id is NULL
OR 
gender IS NULL 
OR
age IS NULL 
OR 
price_per_unit IS NULL 
OR
cogs IS NULL 
OR 
total_sale IS NULL */ 



 
 
-- HOW MANY SALES WE HAVE 
 select count(*)
 from sql_poject1.retail_sales;
 
 -- HOW MANY CUSTOMERS WE HAVE 
 
 SELECT count(Distinct customer_id) as total_customers
 from retail_sales
 
 -- WHAT and how many categories we have 
 SELECT category , COUNT(DISTINCT category) AS unique_category from retail_sales group by category
 
 
 -- BUSINESS KEY PROBLEMS 
 
 -- Q.1 REITRIVE ALL COLOUMNS ON 2022-11-05 
 
 SELECT * FROM retail_sales 
 WHERE sale_date = '2022-11-05 '
 

-- Q.2 retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022

SELECT *
from retail_sales 
where category = 'Clothing' AND quantiy >= 2 AND Month(sale_date) = '11' AND year(sale_date) = '2022'


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
SELECT COUNT(*) AS TOTAL_ORDERS , SUM(total_sale) AS NET_SALE , category 
FROM retail_sales  
group by category ; 


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 
 SELECT ROUND(AVG(age) ,2) AS AVG_AGE from retail_sales 
 where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * from retail_sales where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(transaction_id) , gender , category from retail_sales 
group by gender , category 
order by category;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year(sale_date) as year , month(sale_date) as month ,
AVG(total_sale) from retail_sales
group by year , month 
order by year , 3 desc;


select year(sale_date) as year ,
 month(sale_date) as month ,
AVG(total_sale) , 
RANK() OVER(PARTITION BY year(sale_date) 
ORDER BY AVG(total_sale) DESC )
from retail_sales
group by year , month ;
 

SELECT *
FROM (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sale_rank
    FROM retail_sales
    GROUP BY 
        YEAR(sale_date),
        MONTH(sale_date)
) AS t1
WHERE sale_rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5 ;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT COUNT(DISTINCT customer_id) , category 
from retail_sales 
group by category ;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT 
CASE
   WHEN HOUR(sale_time) <12 THEN 'Morning'
	WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'NOON'
    Else 'Evening'
    END as SHIFT , 
    count(*) as total_orders 
    from retail_sales
    group by shift ; 
   