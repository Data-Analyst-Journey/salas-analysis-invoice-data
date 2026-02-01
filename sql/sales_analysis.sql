-- Create Table for customers invoices
CREATE TABLE mana_invoices (
    invoice_id INT,
    customer_code VARCHAR,
    product_code BIGINT,
    quantity FLOAT,
    unit_price BIGINT,
    invoice_date VARCHAR,
    row_id INT,
    total_buy BIGINT
    );
 
-- Import data into the mana_invoices table    
  COPY mana_invoices(
    invoice_id,
    customer_code,
    product_code,
    quantity,
    unit_price,
    invoice_date,
    row_id,
    total_buy)
    FROM 'D:\Data Analyst\files\Sales_Analysis_From_Invoice_Data\RawData\mana-data-invoices.csv'
    DELIMITER ','
    CSV HEADER; 
    
-- Initial data exploration: review all rows and columns in the table
SELECT * FROM mana_invoices;

-- Check if there are any NULL values in important columns
SELECT 
     COUNT(*) AS total_rows,
     COUNT(invoice_id) AS invoiceid_not_null,
     COUNT(customer_code) AS customercode_not_null,
     COUNT(product_code) AS productcode_not_null,
     COUNT(unit_price) AS unitprice_not_null,
     COUNT(invoice_date) AS invoicedate_not_null
FROM mana_invoices; 

-- Check if some data in essential columns are invalid
SELECT
    MAX(quantity) AS maxquantity,
    MAX(unit_price) AS maxunit_price,
    MAX(total_buy) AS maxtotal_buy
FROM mana_invoices; 

-- Number of customers
SELECT 
    COUNT(DISTINCT customer_code)AS total_customers
FROM mana_invoices;

-- Calculation of total revenue 
SELECT 
   SUM(total_buy) AS customers_purchases 
FROM mana_invoices;

-- Total products
SELECT 
    COUNT(DISTINCT product_code) AS products_number
FROM mana_invoices;

-- Total Orders
SELECT 
  COUNT(DISTINCT invoice_id)
FROM mana_invoices;

-- Top 5 days with the most amount of income   
SELECT invoice_date,
    SUM(total_buy) AS date_income
FROM mana_invoices
GROUP BY invoice_date
ORDER BY date_income DESC
LIMIT 5;

-- Top 5 days with the most sale quantities
SELECT invoice_date,
    SUM(quantity) AS sale_quantities
FROM mana_invoices
GROUP BY invoice_date
ORDER BY sale_quantities DESC
LIMIT 5;

-- Top 5 product by quantity of sales
SELECT product_code,
       SUM(quantity) AS sum_qny
FROM mana_invoices
GROUP BY product_code
ORDER BY sum_qny DESC
LIMIT 5;

-- TOP 5 product by income
SELECT product_code , 
       SUM(total_buy) AS total_mny
FROM mana_invoices
GROUP BY product_code
ORDER BY total_mny DESC
LIMIT 5;

-- Finding Top customer by buy
SELECT customer_code,
       SUM(total_buy) AS total_mny
FROM mana_invoices
GROUP BY customer_code
ORDER BY total_mny DESC
LIMIT 1;

-- Count the number of unique customers per date
SELECT invoice_date,
       COUNT(DISTINCT customer_code) AS perday_customer
FROM mana_invoices
GROUP BY invoice_date
ORDER BY customer_count DESC;

-- How many customers bought an especific product
SELECT product_code, 
      COUNT(DISTINCT customer_code) AS numberof_customers
FROM mana_invoices
GROUP BY product_code
ORDER BY numberof_customers DESC;