USE customer_churn;
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_Churn_SQL.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
USE customer_churn;

DROP TABLE IF EXISTS churn_data;

CREATE TABLE churn_data (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(10)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_Churn_SQL.csv'
INTO TABLE churn_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_Churn_SQL.csv'
INTO TABLE churn_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_Churn_SQL.csv'
INTO TABLE churn_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE churn_data
MODIFY TotalCharges DECIMAL(10,2) NULL;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_Churn_SQL_Final.csv'
INTO TABLE churn_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM churn_data;
SELECT * FROM churn_data LIMIT 5;

SELECT customerID, COUNT(*) AS count
FROM churn_data
GROUP BY customerID
HAVING COUNT(*) > 1;

TRUNCATE TABLE churn_data;

SELECT COUNT(*) FROM churn_data;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_Churn_SQL_Final.csv'
INTO TABLE churn_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM churn_data;

SELECT * FROM churn_data LIMIT 5;

SELECT Churn, COUNT(*) AS customer_count
FROM churn_data
GROUP BY Churn;

SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM churn_data), 2) AS percentage
FROM churn_data
GROUP BY Churn;

SELECT
    Contract,
    Churn,
    COUNT(*) AS customer_count
FROM churn_data
GROUP BY Contract, Churn
ORDER BY Contract, Churn;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT DISTINCT CONCAT('[', Churn, ']') AS churn_value
FROM churn_data;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers,
    ROUND(
        COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT
    Churn,
    LENGTH(Churn) AS value_length,
    COUNT(*) AS count
FROM churn_data
GROUP BY Churn, LENGTH(Churn);

UPDATE churn_data
SET Churn = TRIM(REPLACE(Churn, '\r', ''));

UPDATE churn_data
SET Churn = TRIM(REPLACE(Churn, '\r', ''))
WHERE customerID IS NOT NULL;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN TRIM(Churn) = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN TRIM(Churn) = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT
    Churn,
    LENGTH(Churn) AS length,
    HEX(Churn) AS hex_value,
    COUNT(*) AS count
FROM churn_data
GROUP BY Churn;

SET SQL_SAFE_UPDATES = 0;

UPDATE churn_data
SET Churn = REPLACE(Churn, '\r', '');

SELECT
    Churn,
    LENGTH(Churn) AS value_length,
    COUNT(*) AS count
FROM churn_data
GROUP BY Churn;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT
    InternetService,
    Churn,
    COUNT(*) AS customer_count
FROM churn_data
GROUP BY InternetService, Churn
ORDER BY InternetService, Churn;

SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY InternetService
ORDER BY churn_rate DESC;

SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY tenure_group
ORDER BY churn_rate DESC;

SELECT
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low (<35)'
        WHEN MonthlyCharges < 70 THEN 'Medium (35-69)'
        ELSE 'High (70+)'
    END AS charge_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY charge_group
ORDER BY churn_rate DESC;

SELECT
    InternetService,
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY InternetService, Contract
ORDER BY churn_rate DESC;

SELECT COUNT(*) AS total_customers
FROM churn_data;