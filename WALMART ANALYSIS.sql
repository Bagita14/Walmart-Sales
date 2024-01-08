CREATE DATABASE IF NOT EXISTS walmartsales;

CREATE TABLE salesWalmart(
	invoice_id VARCHAR(30) PRIMARY KEY NOT NULL,
	branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INTEGER NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(10,2) NOT NULL,
    rating FLOAT(2,1)
    );
    
    
    
    -------- CREATE NEW COLUMN CALLED time_of_day ------------
    
    SELECT time,
    CASE 
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN "Morning"
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
    END AS 'time_of_day'
    FROM saleswalmart;
    
    
    ------------ ADD COLUMN time_of_day to table ----------
    
    ALTER TABLE saleswalmart ADD COLUMN time_of_day VARCHAR(20);
    
    
    
--------- POPULATE COLUMN time_of_day with data ------------


UPDATE saleswalmart
SET time_of_day = (
	CASE 
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN "Morning"
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
    END
    );
		
    
-------- CREATE NEW COLUMN CALLED day_name ------------ 
SELECT date,
	DAYNAME(date) AS day_name
    FROM saleswalmart;
    
    
    
   ------------ ADD COLUMN day_name to table ---------- 
   
   ALTER TABLE saleswalmart ADD COLUMN day_name VARCHAR(10);
   
   
   --------- POPULATE COLUMN time_of_day with data ------------
   
   UPDATE saleswalmart
   SET day_name = DAYNAME(date);
   
   
   
   -------- CREATE NEW COLUMN CALLED month_name ------------
   SELECT date, 
	monthname(date) AS month_name
    FROM saleswalmart;
    
    
 ------------ ADD COLUMN month_name to table ----------   
 
 ALTER TABLE saleswalmart ADD COLUMN month_name VARCHAR(12);
    
    
    --------- POPULATE COLUMN month_name with data ------------
    
    UPDATE saleswalmart
    SET month_name = monthname(date);
    
    
    
    
   ------- IN HOW MANY CITIES ARE THEY LOCATED -------
   SELECT DISTINCT city 
   FROM saleswalmart;
   
   
   --------- WHICH CITY HAS WHICH BRANCH TYPE --------
   
   SELECT DISTINCT branch
   FROM saleswalmart;
   
   SELECT DISTINCT city, branch
   FROM saleswalmart;
   
   
   
--  --------  UNIQUE PRODUCT LINES ---------------


SELECT DISTINCT product_line
FROM saleswalmart;



--  --------NO OF UNIQUE PRODUCT LINES ---------------

SELECT COUNT(DISTINCT product_line)
FROM saleswalmart;


-- ------------- MOST COMMON PAYMENT METHOD ---------------

SELECT payment_method,
	COUNT(payment_method) AS 'count_of_payment_method'
FROM saleswalmart
GROUP BY payment_method
ORDER BY count_of_payment_method DESC;



-- ----------------- MOST SELLING PRODUCT LINE -------------

SELECT product_line,
COUNT(product_line) AS cnt_product_line
FROM saleswalmart
GROUP BY product_line
ORDER BY cnt_product_line DESC;


-- ---------------------- TOTAL REVENUE BY MONTH -------------

SELECT month_name AS month,
SUM(total) AS total_revenue
FROM saleswalmart
GROUP BY month_name
ORDER BY total_revenue DESC;


-- ---------------------- MONTH WITH THE HIGHEST COGS ----------

SELECT month_name AS month,
SUM(COGS) AS total_COGS
FROM saleswalmart
GROUP BY month_name
ORDER BY total_COGS DESC;


-- ------------------------ PRODUCT LINE WITH LARGEST REVENUE ------

SELECT product_line,
SUM(total) AS total_revenue
FROM saleswalmart
GROUP BY product_line
ORDER BY total_revenue DESC;


-- ----------------------- CITY WITH LARGEST REVENUE ----------------

SELECT city,
SUM(total) AS total_revenue
FROM saleswalmart
GROUP BY city
ORDER BY total_revenue DESC;


-- ------------------------- PRODUCT LINE WITH THE HIGHEST VAT ---------

SELECT product_line,
SUM(VAT) AS total_VAT
FROM saleswalmart
GROUP BY product_line
ORDER BY total_VAT DESC;


-- ------------------ BRANCH THAT SOLD MORE THAN AVERAGE PRODUCT SOLD --------------------

SELECT branch, 
SUM(quantity) AS qty
FROM saleswalmart
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM saleswalmart)
ORDER BY qty DESC
;


-- -------------------- MOST COMMON PRODUCT LINE BY GENDER ----------------

SELECT gender, product_line,
COUNT(gender) AS cnt_of_gender
FROM saleswalmart
GROUP BY gender, product_line
ORDER BY cnt_of_gender DESC
;


-- --------------------- AVERAGE RATING OF EACH PRODUCT --------------

SELECT product_line,
ROUND(AVG(rating),2) AS avg_rating
FROM saleswalmart
GROUP BY product_line
ORDER BY avg_rating DESC;