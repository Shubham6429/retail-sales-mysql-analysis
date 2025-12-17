# Retail Sales SQL Analysis

This repository contains a SQL-based analysis of a retail sales dataset using MySQL 8.0.
The project was done to practice writing real-world SQL queries focused on data cleaning, exploration, and business-style analysis.

The database was created manually in MySQL Workbench, and all queries were written independently as part of hands-on SQL practice.

## Project Objectives

1.Understand the structure and distribution of retail sales data

2.Perform data cleaning to ensure data quality

3.Conduct exploratory data analysis (EDA) using SQL

4.Answer business-driven questions related to sales, customers, and trends

5.Strengthen practical SQL skills using MySQL 8.0

## Tools Used

MySQL 8.0

MySQL Workbench

SQL (CTEs, window functions, aggregations)


## Dataset Overview

The dataset contains retail transaction-level data with the following information:

Transaction ID

Date and time of sale

Customer ID

Gender and age

Product category

Quantity sold

Price per unit

Cost of goods sold (COGS)

Total sale amount



### Data Checking & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
 SELECT *
from retail_sales 
where category = 'Clothing' AND quantiy >= 4 AND Month(sale_date) = '11' AND year(sale_date) = '2022'
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) 
FROM retail_sales
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
 SELECT 
CASE
   WHEN HOUR(sale_time) <12 THEN 'Morning'
	WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'NOON'
    Else 'Evening'
    END as SHIFT , 
    count(*) as total_orders 
    from retail_sales
    group by shift ; 
```


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Some transactions are much higher than average, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.
- **Most orders**: Most orders happen during afternoon and evening hours.


## Notes 
- Database was created manually (no CREATE DATABASE script included)
- All queries are written for MySQL 8.0
- This project focuses on SQL analysis only (no visualization layer
