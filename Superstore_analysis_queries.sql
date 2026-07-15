/*==========================================================
             SUPERSTORE SALES ANALYSIS USING SQL
============================================================

Project Name : Superstore Sales Analysis
Tool         : MySQL
Dataset      : Superstore Cleaned Dataset
Author       : Sonu Kumar
Date         : July 2026
Version      : 1.0

Objective:
Perform exploratory and business analysis on the
Superstore dataset using SQL to identify sales trends,
customer behavior, product performance, regional
performance, and profitability insights.

Workflow:
1. Database Setup
2. Data Exploration
3. Data Quality Checks
4. Basic Business Analysis
5. Advanced SQL Analysis
6. Business Insights of superstore
7. Conclusion 

Skill Used : 
 1. MySQl 
 2. Data Exploration 
 3. Data Cleaning 
 4. Aggregate Function 
 5. Group By & Having 
 6. Subqueries 
 7. Common Table Expressions (CTEs) 
 8. Window Functions 
 9. Date functions 
 10.Business Analysis 


--     			DATABASE SETUP
==========================================================*/
CREATE DATABASE Superstore_analysis ;
USE Superstore_analysis ;
--    Data Exploration and Data quality check 
SELECT * FROM 
superstore 
limit 10;

-- 				Basic Business analysis 
--  How many total transaction are present in the Superstore Datasets? 

SELECT COUNT(*) AS Total_Records 
FROM superstore;

-- What is the overall sales and profit of the business ? 

SELECT 
ROUND(SUM(Sales),2) AS Total_Sales ,
ROUND(SUM(Profit),2) AS Total_Profit 
FROM superstore ;

-- Which Product , category generate the highest sales, and Profit ? 
SELECT Category ,
	   ROUND(SUM(Sales), 2) AS Total_Sales , 
       ROUND(SUM(Profit),2) AS Total_Profit 
FROM superstore 
GROUP BY Category 
ORDER BY Total_Sales desc;

--   Which Region has the highest Sales ? 
 SELECT Region ,
 ROUND(SUM(Sales),2) AS Total_Sales 
 FROM superstore 
 GROUP BY Region 
 ORDER BY Total_Sales desc;
 
 --  Which state generated the highest profit ?
 
 SELECT State ,
 ROUND(SUM(Profit),2) AS Total_Profit 
 FROM superstore 
 GROUP BY State 
 ORDER BY Total_Profit desc 
 LIMIT 10 ;
 
 -- Who are the top 10 customers by sales?
 
 SELECT Customer_Name  ,
 ROUND(SUM(Sales),2) as Total_sales 
 FROM superstore 
 GROUP BY Customer_Name 
 ORDER BY Total_sales desc 
 LIMIT 10 ;
 
 --  Which product are making losess?
 
 SELECT Product_ID ,
 ROUND(SUM(Profit),2) as Total_profit 
 FROM superstore 
 GROUP BY Product_ID 
 HAVING SUM(Profit)<0 
 ORDER BY Total_profit ;
 
 -- Does Discount affect profit ?
 
 SELECT Discount , 
 ROUND(SUM(Profit),2) as Total_profit 
 FROM superstore 
 GROUP BY Discount 
 ORDER BY Discount ;
 
 -- Which order have high discounts but negative profit ?
 
 SELECT 
 Order_ID ,
 Customer_Name , 
 Sales, 
 Discount , 
 Profit 
 FROM  superstore 
 WHERE Discount > 0.20
 AND Profit <0 ;
 
 -- what is the average delivery time for each shipping mode ?
 
 SELECT Ship_Mode ,
 ROUND(AVG(DATEDIFF(Ship_Date,Order_Date)),2) AS Avg_Delivery_Days 
 FROM superstore 
 GROUP BY Ship_Mode ;
 
 -- Advanced business analysis 
 -- Find  the top 3 Customers in each region by sales 
 
WITH customers_sales AS ( 
		SELECT 
        Region, 
        Customer_Name ,
        ROUND(SUM(Sales),2) as total_sales ,
        ROW_NUMBER() OVER( PARTITION BY Region  ORDER BY ROUND(SUM(Sales),2)  DESC) AS 
        rn 
        from superstore 
        GROUP BY Region , Customer_Name 
        )
        SELECT * 
        FROM customers_sales 
        where rn <=3 ;
        
--  Rank Products by Total Sales 

SELECT 
Product_ID ,
ROUND(SUM(Sales),2) AS Total_Sales,
RANK() OVER(ORDER BY ROUND(SUM(Sales),2) DESC ) AS Sales_Rank
FROM superstore 
GROUP BY Product_ID ;

-- Find the second highest profitable state ?

with state_profit AS ( 
		 SELECT 
         State ,
         ROUND(SUM(Profit),2) as Total_Profit , 
         DENSE_RANK() OVER( ORDER BY ROUND(SUM(Profit),2) DESC ) AS rnk 
         FROM superstore 
         GROUP BY State 
         ) 
         SELECT * 
         FROM state_profit 
         where rnk =2 ;
         
--  Final Business Insights 
-- Key Insights
-- . The Technology category generated the highest sales and profit .
-- . The West region was the best - performing region in terms of revenue and profitability .
-- . Some products generated losses despite good sales due to high discounts . 
-- . Monthly sales analysis revealed  seasonal  trends that can help in forecasting demand .

--  Conclusion 
-- This project demonstrate how SQL can be used to anlyzed business data and generated actionable insights .
-- Using aggregate functions, subqueries , CTEs and Window functions , I analyzed sales , profit , 
-- customer behavior , regional performance , product performance , and shipping trends . 
--  The insights from the analysis can help businesses make data - driven decision related to pricing , 
-- inventory management , customer retention , and sales strategy .
		

         
 
  
 
 
























