use data_mart;
select * from weekly_sales limit 5;

## Data Cleaning
CREATE TABLE clean_weekly_sales AS SELECT week_date,
    WEEK(week_date) AS Week_number,
    MONTH(week_date) AS Month_number,
    YEAR(week_date) AS Calender_year,
    Region,
    Platform,
    CASE
        WHEN segment = 'null' THEN 'Unknown'
        ELSE segment
    END AS segment,
    CASE
        WHEN RIGHT(segment, 1) = '1' THEN 'Young Adults'
        WHEN RIGHT(segment, 1) = '2' THEN 'Middle Aged'
        WHEN RIGHT(segment, 1) IN ('3' , '4') THEN 'Retiress'
        ELSE 'Unknown'
    END AS age_band,
    CASE
        WHEN LEFT(segment, 1) = 'C' THEN 'Couples'
        WHEN LEFT(segment, 1) = 'F' THEN 'Families'
        ELSE 'Unknown'
    END AS Demographic,
    customer_type,
    transactions,
    sales,
    ROUND(sales / transactions, 2) AS avg_transactions FROM
    weekly_sales;

select * from clean_weekly_sales limit 10;

## Data Exploration

## 1.Which week numbers are missing from the dataset?

create table seq100 (x int not null auto_increment primary key);
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 select x + 50 from seq100;
select * from seq100;
create table seq52 as (select x from seq100 limit 52);
select distinct x as week_day from seq52 where x not in (select distinct week_number from clean_weekly_sales);
select distinct week_number from clean_weekly_sales;

## 2.How many total transactions were there for each year in the dataset?

select calender_year, sum(transactions) from clean_weekly_sales group by calender_year;

## 3.What are the total sales for each region for each month?

select region, month_number, sum(sales) as Total_sales from clean_weekly_sales group by region,month_number ORDER BY month_number, region;

## 4.What is the total count of transactions for each platform?

select platform, count(transactions) from clean_weekly_sales group by platform;

## 5.What is the percentage of sales for Retail vs Shopify for each month?

with cte_monthly_platform_sales as (select month_number, calender_year, platform, sum(sales) as monthly_sales
from clean_weekly_sales group by month_number, calender_year, platform)
SELECT
  month_number,calender_year,
  ROUND(
    100 * MAX(CASE WHEN platform = 'Retail' THEN monthly_sales ELSE NULL END) /
      SUM(monthly_sales),
    2
  ) AS retail_percentage,
  ROUND(
    100 * MAX(CASE WHEN platform = 'Shopify' THEN monthly_sales ELSE NULL END) /
      SUM(monthly_sales),
    2
  ) AS shopify_percentage
FROM cte_monthly_platform_sales
GROUP BY month_number,calender_year
ORDER BY month_number,calender_year;

## 6.What is the percentage of sales by demographic for each year in the dataset?

SELECT
  Demographic, calender_year,sum(sales) as Yearly_sales,
  ROUND(
    100 * sum(sales)/SUM(SUM(SALES)) OVER (PARTITION BY demographic),
    2
    ) AS Percentage from clean_weekly_sales
GROUP BY
  calender_year,
  demographic
ORDER BY
  calender_year,
  demographic;
  
## 7.Which age_band and demographic values contribute the most to Retail sales?

SELECT 
    age_band, demographic, SUM(sales) AS Total_sales
FROM
    clean_weekly_sales
WHERE
    Platform = 'Retail'
GROUP BY age_band , demographic
ORDER BY total_sales DESC;






