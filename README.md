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


 
