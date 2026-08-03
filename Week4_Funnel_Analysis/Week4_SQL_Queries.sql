-- ============================================================
-- LogicStack Data Analysis Internship
-- Week 4 Final Project
-- Funnel Analysis using SQL
-- ============================================================

---------------------------------------------------------------
-- TASK 1 : DATA EXPLORATION
---------------------------------------------------------------

-- Query 1: Total Rows
SELECT COUNT(*) AS Total_Rows
FROM client_site_dataset;

-- Query 2: Unique Users
SELECT COUNT(DISTINCT "User ID") AS Unique_Users
FROM client_site_dataset;

-- Query 3: Unique Sessions
SELECT COUNT(DISTINCT "Session ID") AS Unique_Sessions
FROM client_site_dataset;

-- Query 4: List All Event Types
SELECT DISTINCT Event
FROM client_site_dataset;

---------------------------------------------------------------
-- TASK 2 : FUNNEL STAGE ANALYSIS
---------------------------------------------------------------

-- Query 5: Count Total Events by Type
SELECT
Event,
COUNT(*) AS Total_Events
FROM client_site_dataset
GROUP BY Event;

-- Query 6: Count Users per Event Type
SELECT
Event,
COUNT(DISTINCT "User ID") AS Users
FROM client_site_dataset
GROUP BY Event;

-- Query 7: Browse to Purchase Conversion
SELECT
SUM(CASE WHEN Event='Browse' THEN 1 ELSE 0 END) AS Browse,
SUM(CASE WHEN Event='Purchase' THEN 1 ELSE 0 END) AS Purchase
FROM client_site_dataset;

---------------------------------------------------------------
-- TASK 3 : REVENUE ANALYSIS
---------------------------------------------------------------

-- Query 8: Total Revenue
SELECT
SUM(Revenue) AS Total_Revenue
FROM client_site_dataset;

-- Query 9: Revenue by Region
SELECT
Region,
SUM(Revenue) AS Revenue
FROM client_site_dataset
GROUP BY Region
ORDER BY Revenue DESC;

-- Query 10: Revenue by Channel
SELECT
Channel,
SUM(Revenue) AS Revenue
FROM client_site_dataset
GROUP BY Channel
ORDER BY Revenue DESC;

-- Query 11: Revenue by Device
SELECT
Device,
SUM(Revenue) AS Revenue
FROM client_site_dataset
GROUP BY Device
ORDER BY Revenue DESC;

---------------------------------------------------------------
-- TASK 4 : BUSINESS INSIGHTS
---------------------------------------------------------------

-- Query 12: Top 5 Users by Revenue
SELECT
"User ID",
SUM(Revenue) AS Revenue
FROM client_site_dataset
GROUP BY "User ID"
ORDER BY Revenue DESC
LIMIT 5;

-- Query 13: Best Performing Channel
SELECT
Channel,
SUM(Revenue) AS Revenue
FROM client_site_dataset
GROUP BY Channel
ORDER BY Revenue DESC;

-- Query 14: Highest Revenue Region
SELECT
Region,
SUM(Revenue) AS Revenue
FROM client_site_dataset
GROUP BY Region
ORDER BY Revenue DESC;

-- Query 15: Device Conversion Rate
SELECT
Device,
COUNT(CASE WHEN Event='Browse' THEN 1 END) AS Browse,
COUNT(CASE WHEN Event='Purchase' THEN 1 END) AS Purchase,
ROUND(
COUNT(CASE WHEN Event='Purchase' THEN 1 END)*100.0/
COUNT(CASE WHEN Event='Browse' THEN 1 END),2
) AS Conversion_Rate
FROM client_site_dataset
GROUP BY Device;

---------------------------------------------------------------
-- TASK 5 : DROP-OFF ANALYSIS
---------------------------------------------------------------

-- Query 16: Drop-off Analysis
SELECT
Event,
COUNT(*) AS Users
FROM client_site_dataset
GROUP BY Event;