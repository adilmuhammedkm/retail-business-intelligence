CREATE DATABASE IF NOT EXISTS retail_analytics;
USE retail_analytics;

CREATE TABLE IF NOT EXISTS retail_sales (
    InvoiceID VARCHAR(20),
    ProductID VARCHAR(20),
    ProductDescription TEXT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Revenue DECIMAL(12,2),
    InvoiceDate DATETIME,
    Year INT,
    Month INT,
    Day INT,
    CustomerID INT,
    Country VARCHAR(50)
);
