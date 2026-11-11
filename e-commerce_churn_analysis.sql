/*
Senior Data Scientist/AI Engineering.: Dr. Eddy Giusepe Chirinos Isidro

Data Analysis Project
=====================
*/
SELECT * FROM ecommerce_churn LIMIT 10;

/*
Step 1: Data Cleaning
        -------------
*/
-- 1. Finding the total number of customers
select distinct count(CustomerID) as TotalNumberOfCustomers
from ecommerce_churn;

-- 2. Checking for duplicate rows
select CustomerID, count(CustomerID) as Count
from ecommerce_churn
group by CustomerID
Having count(CustomerID) > 1; --Keep only customers who appear more than once

-- 3. Checking for null values
SELECT 'Tenure' as NomeColuna, count(*) as QuantidadeNull --É diferente count(*) de count(Tenure) 
FROM ecommerce_churn
where Tenure is NULL;
