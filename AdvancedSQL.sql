# SQL Practice - Week 2

## SQL Queries

### 1. SQL Query - Joins

####Join `FactInternetSales` with `DimProduct` and `DimCustomer` to get sales information along with product and customer details.

#### Query 1: Get sales data with product name and customer details
SELECT 
    fis.SalesAmount,
    dp.Name AS ProductName,
    dc.FirstName AS CustomerFirstName,
    dc.LastName AS CustomerLastName
FROM 
    FactInternetSales fis
JOIN 
    DimProduct dp ON fis.ProductKey = dp.ProductKey
JOIN 
    DimCustomer dc ON fis.CustomerKey = dc.CustomerKey;


### 2. SQL Query - Aggregations

#### Aggregate the sales by product category from the FactInternetSales and DimProductCategory tables.

#### Query 2: Aggregate sales by product category
SELECT 
    dpc.Name AS ProductCategory,
    SUM(fis.SalesAmount) AS TotalSalesAmount
FROM 
    FactInternetSales fis
JOIN 
    DimProduct dp ON fis.ProductKey = dp.ProductKey
JOIN 
    DimProductCategory dpc ON dp.ProductCategoryKey = dpc.ProductCategoryKey
GROUP BY 
    dpc.Name;

### 3. SQL Query - Window Functions
#### Use the ROW_NUMBER() function to rank sales records by SalesAmount for each customer in descending order.

#### Query 3: Rank sales by sales amount for each customer
SELECT 
    dc.FirstName,
    dc.LastName,
    fis.SalesAmount,
    ROW_NUMBER() OVER (PARTITION BY fis.CustomerKey ORDER BY fis.SalesAmount DESC) AS SalesRank
FROM 
    FactInternetSales fis
JOIN 
    DimCustomer dc ON fis.CustomerKey = dc.CustomerKey;


### 4. SQL Query - Aggregate & Grouping
#### Find the total sales by SalesTerritory using the FactResellerSales and DimSalesTerritory tables.

#### Query 4: Total sales by Sales Territory
SELECT 
    dst.Name AS SalesTerritory,
    SUM(fr.SalesAmount) AS TotalSales
FROM 
    FactResellerSales fr
JOIN 
    DimSalesTerritory dst ON fr.SalesTerritoryKey = dst.SalesTerritoryKey
GROUP BY 
    dst.Name;


### 5. SQL Query - Using Date Functions
#### Calculate the total sales for the year 2021 using the FactInternetSales and DimDate tables.

#### Query 5: Total sales in the year 2021
SELECT 
    SUM(fis.SalesAmount) AS TotalSales
FROM 
    FactInternetSales fis
JOIN 
    DimDate dd ON fis.OrderDateKey = dd.DateKey
WHERE 
    dd.CalendarYear = 2021;