/*
Senior Data Scientist/AI Engineering.: Dr. Eddy Giusepe Chirinos Isidro

Data Analysis Project
=====================
*/

SELECT * FROM ecommerce_churn LIMIT 10;

/*
---------------------
Step 1: Data Cleaning
---------------------
*/

-- 1. Finding the total number of customers
SELECT DISTINCT count("CustomerID") AS "TotalNumberOfCustomers"
FROM ecommerce_churn;

-- 2. Checking for duplicate rows
SELECT "CustomerID", count("CustomerID") AS Count
FROM ecommerce_churn
GROUP BY "CustomerID"
HAVING count("CustomerID") > 1; --Keep only customers who appear more than once

-- 3. Checking for null values
SELECT 'CustomerID' AS ColumnName, COUNT(*) AS CountOfNulls --count(*) is different from count(Tenure)
FROM ecommerce_churn
WHERE "CustomerID" IS NULL

UNION

SELECT 'Churn' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "Churn" IS NULL

UNION

SELECT 'Tenure' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "Tenure" IS NULL

UNION

SELECT 'PreferredLoginDevice' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "PreferredLoginDevice" IS NULL

UNION

SELECT 'CityTier' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "CityTier" IS NULL

UNION

SELECT 'WarehouseToHome' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "WarehouseToHome" IS NULL

UNION

SELECT 'PreferredPaymentMode' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "PreferredPaymentMode" IS NULL

UNION

SELECT 'Gender' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "Gender" IS NULL

UNION

SELECT 'HourSpendOnApp' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "HourSpendOnApp" IS NULL

UNION

SELECT 'NumberOfDeviceRegistered' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "NumberOfDeviceRegistered" IS NULL

UNION

SELECT 'PreferedOrderCat' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "PreferedOrderCat" IS NULL

UNION

SELECT 'SatisfactionScore' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "SatisfactionScore" IS NULL

UNION

SELECT 'MaritalStatus' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "MaritalStatus" IS NULL

UNION

SELECT 'NumberOfAddress' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "NumberOfAddress" IS NULL

UNION

SELECT 'Complain' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "Complain" IS NULL

UNION

SELECT 'OrderAmountHikeFromlastYear' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "OrderAmountHikeFromlastYear" IS NULL

UNION

SELECT 'CouponUsed' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "CouponUsed" IS NULL

UNION

SELECT 'OrderCount' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "OrderCount" IS NULL

UNION

SELECT 'DaySinceLastOrder' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "DaySinceLastOrder" IS NULL

UNION

SELECT 'CashbackAmount' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE "CashbackAmount" IS NULL;

-- 3.1 Handling null values
UPDATE ecommerce_churn
SET "Tenure" = (SELECT AVG("Tenure") FROM ecommerce_churn)
WHERE "Tenure" IS NULL;

UPDATE ecommerce_churn
SET "OrderCount" = (SELECT AVG("OrderCount") FROM ecommerce_churn)
WHERE "OrderCount" IS NULL;

UPDATE ecommerce_churn
SET "CouponUsed" = (SELECT AVG("CouponUsed") FROM ecommerce_churn)
WHERE "CouponUsed" IS NULL;

UPDATE ecommerce_churn
SET "OrderAmountHikeFromlastYear" = (SELECT AVG("OrderAmountHikeFromlastYear") FROM ecommerce_churn)
WHERE "OrderAmountHikeFromlastYear" IS NULL;

UPDATE ecommerce_churn
SET "HourSpendOnApp" = (SELECT AVG("HourSpendOnApp") FROM ecommerce_churn)
WHERE "HourSpendOnApp" IS NULL;

UPDATE ecommerce_churn
SET "WarehouseToHome" = (SELECT  AVG("WarehouseToHome") FROM ecommerce_churn)
WHERE "WarehouseToHome" IS NULL;

UPDATE ecommerce_churn
SET "DaySinceLastOrder" = (SELECT AVG("DaySinceLastOrder") FROM ecommerce_churn)
WHERE "DaySinceLastOrder" IS NULL; 

-- 4. Creating a new column from an already existing "churn" column
ALTER TABLE ecommerce_churn 
ADD COLUMN "CustomerStatus" VARCHAR(50);

UPDATE ecommerce_churn 
SET "CustomerStatus" = (CASE
	WHEN "Churn"  = 1 THEN 'Churned'
	WHEN "Churn" = 0 THEN 'Stayed'
END);

-- 5. Creating a new column from an already existing "complain" column
ALTER TABLE ecommerce_churn
ADD COLUMN "ComplainRecieved" VARCHAR(10)
	
UPDATE ecommerce_churn
SET "ComplainRecieved" = (CASE 
    WHEN "Complain" = 1 THEN 'Yes'
    WHEN "Complain" = 0 THEN 'No'
END);

-- 6. Checking values in each column for correctness and accuracy
-- 6.1 Fixing redundancy in “PreferedLoginDevice” Column
SELECT DISTINCT "PreferredLoginDevice" FROM ecommerce_churn; -- Phone and Mobile Phone are the same thing.

UPDATE ecommerce_churn
SET "PreferredLoginDevice" = 'Phone' WHERE "PreferredLoginDevice" = 'Mobile Phone';

-- 6.2 Fixing redundancy in "PreferedOrderCat" Column
SELECT DISTINCT "PreferedOrderCat" FROM ecommerce_churn;

UPDATE ecommerce_churn
SET "PreferedOrderCat" = 'Mobile Phone' WHERE "PreferedOrderCat" = 'Mobile';

-- 6.3 Fixing redundancy in "PreferredPaymentMode" Column
SELECT DISTINCT "PreferredPaymentMode" FROM ecommerce_churn;

UPDATE ecommerce_churn
SET "PreferredPaymentMode"  = 'Cash on Delivery' WHERE "PreferredPaymentMode"  = 'COD';

-- 6.4 Fixing wrongly entered values in "WarehouseToHome" column
SELECT DISTINCT "WarehouseToHome" FROM ecommerce_churn; -- Changes 126 and 127, are incorrect

UPDATE ecommerce_churn
SET "WarehouseToHome" = '27' WHERE "WarehouseToHome" = '127';

UPDATE ecommerce_churn
SET "WarehouseToHome" = '26' WHERE "WarehouseToHome" = '126';


/*
---------------------
Step 2: Data Exploration
---------------------
*/

-- 1. What is the overall customer churn rate?
SELECT
    "TotalNumberOfCustomers",
    "TotalNumberOfChurnedCustomers",
    CAST(
        ("TotalNumberOfChurnedCustomers" * 1.0 / "TotalNumberOfCustomers") * 100
        AS DECIMAL(10, 2)
    ) AS "ChurnRate"
FROM
    (SELECT COUNT(*) AS "TotalNumberOfCustomers"
     FROM ecommerce_churn
    ) AS "Total",
    
    (SELECT COUNT(*) AS "TotalNumberOfChurnedCustomers"
     FROM ecommerce_churn
     WHERE "CustomerStatus" = 'Churned'
    ) AS "Churned";

--2. How does the churn rate vary based on the preferred login device?
SELECT "PreferredLoginDevice", 
        COUNT(*) AS "TotalCustomers",
        SUM("Churn") AS "ChurnedCustomers",
        CAST((SUM("Churn") * 1.0 / COUNT(*)) * 100 AS DECIMAL(10,2)) AS "ChurnRate"
FROM ecommerce_churn
GROUP BY "PreferredLoginDevice";

--3. What is the distribution of customers across different city tiers?
SELECT "CityTier", 
       COUNT(*) AS "TotalCustomer", 
       SUM("Churn") AS "ChurnedCustomers", 
       CAST(SUM("Churn") * 1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "ChurnRate"
FROM ecommerce_churn
GROUP BY "CityTier"
ORDER BY "ChurnRate" DESC;

--4. Is there any correlation between the warehouse-to-home distance and customer churn?
ALTER TABLE ecommerce_churn
ADD "WarehouseToHomeRange" VARCHAR(50)

UPDATE ecommerce_churn
SET "WarehouseToHomeRange" = CASE 
    WHEN "WarehouseToHome" <= 10 THEN 'Very close distance'
    WHEN "WarehouseToHome" > 10 AND "WarehouseToHome" <= 20 THEN 'Close distance'
    WHEN "WarehouseToHome" > 20 AND "WarehouseToHome" <= 30 THEN 'Moderate distance'
    WHEN "WarehouseToHome" > 30 THEN 'Far distance'
END;

--Finding a correlation between warehouse to home and churn rate:
SELECT "WarehouseToHomeRange",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "WarehouseToHomeRange"
ORDER BY "Churnrate" DESC;

--5. Which is the most preferred payment mode among churned customers?
SELECT "PreferredPaymentMode",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "PreferredPaymentMode"
ORDER BY "Churnrate" DESC;

--6. What is the typical Tenure for churned customers?
ALTER TABLE ecommerce_churn
ADD "TenureRange" VARCHAR(50);

UPDATE ecommerce_churn
SET "TenureRange" = CASE
	WHEN "Tenure" <= 6 THEN '6 Months'
    WHEN "Tenure" > 6 AND "Tenure" <= 12 THEN '1 Year'
    WHEN "Tenure" > 12 AND "Tenure" <= 24 THEN '2 Years'
    WHEN "Tenure" > 24 THEN 'more than 2 years'
END;

--Finding typical tenure for churned customers
SELECT "TenureRange",
		COUNT(*) AS "TotalCustomer",
		SUM("Churn") AS "CustomerChurn",
		CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "TenureRange" 
ORDER BY "Churnrate" DESC;

--7. Is there any difference in churn rate between male and female customers?
SELECT "Gender",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "Gender"
ORDER BY "Churnrate" DESC;

--8. How does the average time spent on the app differ for churned and non-churned customers?
SELECT "CustomerStatus",
       ROUND(AVG("HourSpendOnApp")::NUMERIC, 2) AS "AverageHourSpentOnApp" -- Here, you can also use CAST
FROM ecommerce_churn
GROUP BY "CustomerStatus";

--9. Does the number of registered devices impact the likelihood of churn?
SELECT "NumberOfDeviceRegistered",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "NumberOfDeviceRegistered"
ORDER BY "Churnrate" DESC;

--10. Which order category is most preferred among churned customers?
SELECT "PreferedOrderCat",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "PreferedOrderCat"
ORDER BY "Churnrate" DESC;

--11. Is there any relationship between customer satisfaction scores and churn?
SELECT "SatisfactionScore",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "SatisfactionScore"
ORDER BY "Churnrate" DESC;

--12. Does the marital status of customers influence churn behavior?
SELECT "MaritalStatus",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "MaritalStatus"
ORDER BY "Churnrate" DESC;

--13. How many addresses do churned customers have on average?
SELECT ROUND(AVG("NumberOfAddress")::NUMERIC, 2) AS "AverageNumOfChurnedCustomerAddress"
FROM ecommerce_churn
WHERE "CustomerStatus" = 'Stayed'

--14. Do customer complaints influence churned behavior?
SELECT "ComplainRecieved",
       COUNT(*) AS "TotalCustomer",
       SUM("Churn") AS "CustomerChurn",
       CAST(SUM("Churn")*1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS "Churnrate"
FROM ecommerce_churn
GROUP BY "ComplainRecieved"
ORDER BY "Churnrate" DESC;



































