# Retail Sales Analysis SQL Project

## Project Overview

**Project Title:** Retail Sales Analysis  
**Level:** Beginner  
**Database:** `p1_retail_db`  
**SQL Dialect:** PostgreSQL

This project uses SQL to explore and analyze retail sales data. It demonstrates database table creation, data quality checks, handling missing values, exploratory data analysis (EDA), and business queries that summarize sales and customer behavior.

## Objectives

1. Create the `retail_sales` table.
2. Inspect the dataset and check for missing values.
3. Explore the number of transactions, unique customers, and product categories.
4. Use SQL queries to answer business questions about sales, customers, gender, and product categories.

## Project Structure

```text
retail-sales-analysis/
├── schema_creation.sql
├── data_cleaning_and_analysis.sql
└── README.md
```

- **`schema_creation.sql`** — creates the `retail_sales` table.
- **`data_cleaning_and_analysis.sql`** — contains data inspection, null checks, data cleaning, exploratory queries, and business analysis queries.

## Database Schema

The project uses a table named `retail_sales` with the following columns:

| Column | Description |
|---|---|
| `transactions_id` | Unique transaction identifier and primary key |
| `sale_date` | Date of the sale |
| `sale_time` | Time of the sale |
| `customer_id` | Customer identifier |
| `gender` | Customer gender |
| `age` | Customer age |
| `category` | Product category |
| `quantity` | Quantity sold |
| `price_per_unit` | Price per unit |
| `cogs` | Cost of goods sold |
| `total_sale` | Total sale amount for the transaction |

## Project Workflow

### 1. Database and Table Setup

The schema script creates the `retail_sales` table with `transactions_id` as the primary key.

### 2. Data Cleaning and Quality Checks

The analysis script includes queries to:

- Preview records from the table.
- Rename the misspelled `quantiy` column to `quantity`.
- Count the total number of rows.
- Check columns for `NULL` values.
- Identify records with one or more missing values and delete those records.
- Count distinct customers and inspect unique product categories.

> **Note:** The cleaning script contains a `DELETE` statement for rows with missing values. Review the matching rows and make a backup before running destructive operations on important data.

### 3. Business Analysis Questions

The SQL queries answer the following questions:

1. Retrieve all sales made on `2022-11-05`.
2. Find Clothing transactions where quantity sold is greater than 4.
3. Calculate total sales for each category.
4. Calculate the average age of customers who purchased from the Beauty category.
5. Retrieve transactions with `total_sale` greater than 1000.
6. Count transactions for each gender.
7. Calculate the average sale for each gender.
8. Find transactions where the category is Beauty and the gender is Female.
9. Count transactions for each category.
10. Calculate total revenue for each category among female customers.

## SQL Concepts Practiced

- `SELECT` and `WHERE`
- Aggregate functions: `COUNT()`, `SUM()`, and `AVG()`
- `GROUP BY`
- `NULL` checks with `IS NULL`
- `DISTINCT`
- `ALTER TABLE` and `DELETE`
- Date filtering
- Numeric casting and rounding in PostgreSQL

## How to Run the Project

1. Install or open PostgreSQL and connect using a SQL client such as pgAdmin or `psql`.
2. Create a database named `p1_retail_db` if it does not already exist.
3. Import or load the retail sales dataset into the database.
4. Run `schema_creation.sql` to create the table. If the table already exists, avoid recreating it unnecessarily.
5. Load the dataset into `retail_sales`.
6. Review and run `data_cleaning_and_analysis.sql` in sections, checking the results as you go.

**Important:** The provided SQL files define the schema and contain cleaning/analysis queries; make sure the source dataset has been loaded before running queries that expect data.

## Conclusion

This project demonstrates foundational PostgreSQL skills through retail sales data preparation, quality checks, exploratory analysis, and business-focused SQL queries. It provides a starting point for further analysis, such as monthly sales trends, customer segmentation, and a dashboard built with a visualization tool.

## Author

**Ghanshyam Seervi**

This project is part of my data analytics portfolio and showcases my practice with PostgreSQL and SQL-based business analysis.
