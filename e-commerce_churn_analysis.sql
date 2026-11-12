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
SELECT DISTINCT count(CustomerID) AS TotalNumberOfCustomers
FROM ecommerce_churn;

-- 2. Checking for duplicate rows
SELECT CustomerID, count(CustomerID) AS Count
FROM ecommerce_churn
GROUP BY CustomerID
HAVING count(CustomerID) > 1; --Keep only customers who appear more than once

-- 3. Checking for null values
SELECT 'CustomerID' AS ColumnName, COUNT(*) AS CountOfNulls --count(*) is different from count(Tenure)
FROM ecommerce_churn
WHERE CustomerID IS NULL

UNION

SELECT 'Churn' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE Churn IS NULL

UNION

SELECT 'Tenure' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE Tenure IS NULL

UNION

SELECT 'PreferredLoginDevice' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE PreferredLoginDevice IS NULL

UNION

SELECT 'CityTier' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE CityTier IS NULL

UNION

SELECT 'WarehouseToHome' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE WarehouseToHome IS NULL

UNION

SELECT 'PreferredPaymentMode' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE PreferredPaymentMode IS NULL

UNION

SELECT 'Gender' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE Gender IS NULL

UNION

SELECT 'HourSpendOnApp' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE HourSpendOnApp IS NULL

UNION

SELECT 'NumberOfDeviceRegistered' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE NumberOfDeviceRegistered IS NULL

UNION

SELECT 'PreferedOrderCat' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE PreferedOrderCat IS NULL

UNION

SELECT 'SatisfactionScore' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE SatisfactionScore IS NULL

UNION

SELECT 'MaritalStatus' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE MaritalStatus IS NULL

UNION

SELECT 'NumberOfAddress' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE NumberOfAddress IS NULL

UNION

SELECT 'Complain' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE Complain IS NULL

UNION

SELECT 'OrderAmountHikeFromlastYear' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE OrderAmountHikeFromlastYear IS NULL

UNION

SELECT 'CouponUsed' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE CouponUsed IS NULL

UNION

SELECT 'OrderCount' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE OrderCount IS NULL

UNION

SELECT 'DaySinceLastOrder' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE DaySinceLastOrder IS NULL

UNION

SELECT 'CashbackAmount' AS ColumnName, count(*) AS CountOfNulls
FROM ecommerce_churn
WHERE CashbackAmount IS NULL;

-- 3.1 Handling null values
UPDATE ecommerce_churn
SET Tenure = (SELECT AVG(Tenure) FROM ecommerce_churn)
WHERE Tenure IS NULL;

UPDATE ecommerce_churn
SET OrderCount = (SELECT AVG(OrderCount) FROM ecommerce_churn)
WHERE OrderCount IS NULL;

UPDATE ecommerce_churn
SET CouponUsed = (SELECT AVG(CouponUsed) FROM ecommerce_churn)
WHERE CouponUsed IS NULL;

UPDATE ecommerce_churn
SET OrderAmountHikeFromlastYear = (SELECT AVG(OrderAmountHikeFromlastYear) FROM ecommerce_churn)
WHERE OrderAmountHikeFromlastYear IS NULL;

UPDATE ecommerce_churn
SET HourSpendOnApp = (SELECT AVG(HourSpendOnApp) FROM ecommerce_churn)
WHERE HourSpendOnApp IS NULL;

UPDATE ecommerce_churn
SET WarehouseToHome = (SELECT  AVG(WarehouseToHome) FROM ecommerce_churn)
WHERE WarehouseToHome IS NULL;

UPDATE ecommerce_churn
SET DaySinceLastOrder = (SELECT AVG(DaySinceLastOrder) FROM ecommerce_churn)
WHERE DaySinceLastOrder IS NULL; 