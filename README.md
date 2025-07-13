# Apple Sales Analysis (1M+ Rows) – SQL Project

This project focuses on analyzing over **1 million rows** of Apple product sales data using **PostgreSQL**. The analysis covers store performance, sales trends, warranty claims, and product-level metrics — all through powerful and optimized SQL queries.

## Project Goals

- Perform exploratory data analysis (EDA) on large-scale retail data
- Optimize query performance with indexing
- Solve real-world business problems using SQL

## Tools & Skills Used

- **PostgreSQL**
- **SQL Joins, Aggregations, and Window Functions**
- **Query Optimization (EXPLAIN ANALYZE, Indexing)**
- **Business Intelligence Problem Solving**
- **Data Cleaning & Exploration**

## Business Questions Solved

1. Number of stores per country
2. Total units sold per store
3. December 2023 sales volume
4. Stores with no warranty claims
5. Percentage of rejected warranty claims
6. Top-performing store in the last year
7. Unique products sold in the past year
8. Category-wise average product price
9. Warranty claims filed in 2020
10. Best-selling day per store using `RANK()` window function

## Query Optimization Highlights

Before and after indexing:
- Filter on `product_id`: ↓ from **387ms** → **19ms**
- Filter on `store_id`: ↓ from **523ms** → **14ms**

## Dataset Overview

- `sales.csv`: 1M+ sales records
- `products.csv`: product details & pricing
- `stores.csv`: store information by region
- `warranty.csv`: repair status & claim dates
- `category.csv`: product category mappings

## Key Takeaway

This project demonstrates my ability to **write clean, optimized SQL queries**, uncover **insights from large datasets**, and simulate the kind of business problem-solving expected from BI and Data Analyst roles.

