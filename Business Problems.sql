---apple sales project - 1m rows sales datasets---

SELECT * FROM category;
SELECT * FROM products;
SELECT * FROM stores;
SELECT * FROM sales;
SELECT * FROM warranty;

-- EDA
SELECT DISTINCT repair_status 
FROM warranty;

SELECT COUNT(*)
FROM sales;

-- Improving Query Performance

EXPLAIN ANALYZE
SELECT * 
FROM sales
WHERE product_id = 'P-44'
--(execution time - 387.835; Planning time - 0.243)

EXPLAIN ANALYZE
SELECT * 
FROM sales
WHERE store_id = 'ST-31'
--(execution time - 523.759; Planning time - 0.421)

CREATE INDEX sales_product_id ON sales(product_id);
--(After Index: execution time - 19.246; Planning time - 0.233)
CREATE INDEX sales_store_id ON sales(store_id);
--(After Index: execution time - 14.383; Planning time - 0.182)
CREATE INDEX sales_sale_date ON sales(sale_date);


----- BUSINESS PROBLEM-----

--1. Find the number of stores in each country.

SELECT store_id, country
FROM stores;

SELECT country, COUNT(store_id) AS no_of_stores
FROM stores
GROUP BY 1
ORDER BY 2 DESC;

--2. Calculate the total number of units sold by each store.

SELECT * FROM sales;

SELECT store_id, SUM(quantity) as total_units_sold
FROM sales
GROUP BY 1;

--(OR)

SELECT s.store_id,
       st.store_name,
       SUM(s.quantity) as total_units_sold
FROM sales as s
JOIN stores as st ON st.store_id = s.store_id
GROUP BY 1, 2
ORDER BY 3 DESC;

--3. Identify how many sales occurred in December 2023.

SELECT * FROM sales;

SELECT
     COUNT(sale_id) AS total_sales
FROM sales
WHERE EXTRACT(YEAR FROM sale_date) = 2023;

--4. Determine how many stores have never had a warranty claim filed.

SELECT * FROM warranty;

SELECT COUNT(store_id)
FROM sales as s
RIGHT JOIN warranty as w 
ON s.sale_id = w.sale_id
WHERE w.repair_status = 'Pending';

--5. Calculate the percentage of warranty claims marked as "Rejected".

SELECT * FROM warranty;

SELECT COUNT(claim_id)/(SELECT COUNT(*) FROM Warranty)::numeric*100
FROM warranty 
WHERE repair_status = 'Rejected';

--6. Identify which store had the highest total units sold in the last year.

SELECT * FROM sales;

SELECT store_id, 
       sum(quantity)
FROM sales
WHERE sale_date >= (CURRENT_DATE - INTERVAL '1 Year')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--(OR)

SELECT s.store_id,
       st.store_name,
       sum(s.quantity)
FROM sales as s
JOIN stores as st
ON s.store_id = st.store_id
WHERE sale_date >= (CURRENT_DATE - INTERVAL '1 Year')
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1

--7. Count the number of unique products sold in the last year.

SELECT (count(distinct product_id)) 
FROM sales
WHERE sale_date >= (CURRENT_DATE - INTERVAL '1 Year')

--8. Find the average price of products in each category.

SELECT category_id,
       avg(price) as avg_price
FROM products
GROUP BY 1

--(OR)

SELECT p.category_id,
       c.category_name,
	   avg(p.price) as avg_price
FROM products as p
JOIN category as c
ON p.category_id = c.category_id
GROUP BY 1,2
ORDER BY 3 DESC

--9. How many warranty claims were filed in 2020?

SELECT * FROM warranty

SELECT count(*) as warranty_claim	 
FROM warranty
WHERE EXTRACT(YEAR FROM claim_date) = 2020

--10. For each store, identify the best-selling day based on highest quantity sold.

SELECT * FROM sales

--store_id, day_name, sum(qty)
--window dense rank

SELECT *
FROM
(  SELECT 
       store_id,
       TO_CHAR(sale_date, 'Day') as day_name,
	   sum(quantity) as total_unit_sold,
	   RANK() OVER(PARTITION BY store_id ORDER BY sum(quantity) DESC) as rank
FROM sales
GROUP BY 1, 2
) as t1
WHERE rank = 1


