CREATE TABLE sales_data (
		index bigint,
		date date,
		year numeric,
		month text,
		customer_age numeric,
		customer_gender text,
		country text,
		state text,
		product_category text,
		sub_category text,
		quantity numeric,
		unit_cost numeric,
		unit_price numeric,
		cost numeric,
		revenue numeric,
		column1 text
);

COPY sales_data 
FROM '/Users/alexbruno/Desktop/sales_data.csv'
WITH (FORMAT CSV, HEADER);

SELECT *
FROM sales_data;

ALTER TABLE sales_data ALTER COLUMN customer_age SET DATA TYPE integer;
ALTER TABLE sales_data ALTER COLUMN year SET DATA TYPE integer;
ALTER TABLE sales_data ALTER COLUMN quantity SET DATA TYPE integer;
ALTER TABLE sales_data ALTER COLUMN unit_cost SET DATA TYPE numeric(15,2);
ALTER TABLE sales_data ALTER COLUMN unit_price SET DATA TYPE numeric(15,2);
ALTER TABLE sales_data ALTER COLUMN cost SET DATA TYPE numeric(15,2);
ALTER TABLE sales_data ALTER COLUMN revenue SET DATA TYPE numeric(15,2);


SELECT DISTINCT month
FROM sales_data;

SELECT *
FROM sales_data
WHERE month IS NULL;

DELETE FROM sales_data
WHERE month IS NULL;

ALTER TABLE sales_data
DROP COLUMN column1;

SELECT product_category, sub_category, 
	count(*) AS total_transactions
FROM sales_data
GROUP BY product_category, sub_category
ORDER BY product_category, total_transactions DESC;

SELECT 
CASE
	WHEN customer_age < 20 THEN 'Under 20'
	WHEN customer_age BETWEEN 20 AND 29 THEN '20-29'
	WHEN customer_age BETWEEN 30 AND 39 THEN '30-39'
	WHEN customer_age BETWEEN 40 AND 49 THEN '40-49'
	WHEN customer_age BETWEEN 50 AND 59 THEN '50-59'
	WHEN customer_age BETWEEN 60 AND 69 THEN '60-69'
	WHEN customer_age BETWEEN 70 AND 79 THEN '70-79'
	WHEN customer_age BETWEEN 80 AND 89 THEN '80+'
END AS age_groups,
sum(unit_price * quantity) AS total_spend
FROM sales_data
GROUP BY age_groups
ORDER BY total_spend DESC;

SELECT customer_gender, sum(revenue)
FROM sales_data
GROUP BY customer_gender
ORDER BY sum(revenue) DESC;

SELECT year, month, 
	sum(revenue - cost) AS total_profit
FROM sales_data
GROUP BY year, month;