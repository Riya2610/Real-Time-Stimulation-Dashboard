CREATE DATABASE coffee_shop_sales;
USE coffee_shop_sales;


-- real time stimulation


CREATE TABLE sales (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    transaction_date TEXT NOT NULL,
    transaction_time TEXT NOT NULL,
    transaction_qty INT NOT NULL,
    store_id INT NOT NULL,
    store_location TEXT (255) NOT NULL,
    product_id INT NOT NULL,
    unit_price DOUBLE (10, 2) NOT NULL,
    product_category TEXT (255) NOT NULL,
    product_type TEXT (255) NOT NULL,
    product_detail TEXT(255) NOT NULL
);
select* from sales;
truncate table sales;
drop table sales;

USE coffee_shop_sales;

CREATE TABLE IF NOT EXISTS sales_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    detail_description TEXT NOT NULL,
    detail_amount DOUBLE (10, 2) NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES sales(transaction_id)
);

INSERT INTO sales_details (transaction_id, detail_description, detail_amount)
SELECT 
    s.transaction_id, 
    CONCAT('Detail description ', FLOOR(1 + (RAND() * 100))), 
    ROUND((RAND() * 100), 2)
FROM 
    sales s
LEFT JOIN sales_details sd
ON s.transaction_id = sd.transaction_id
WHERE sd.transaction_id IS NULL
ORDER BY 
    RAND()
LIMIT 5;

select * from sales_details;

delete  from sales_details where detail_id >20;