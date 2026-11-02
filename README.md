# SQL Advertising Data Integration

## Overview
This project combines Facebook Ads and Google Ads data using PostgreSQL, Common Table Expressions (CTEs), JOIN operations, and UNION.

The project integrates advertising data from multiple tables to analyze marketing campaign performance at both campaign and ad set levels.

## Objectives
- Combine Facebook Ads data with campaign and ad set information.
- Integrate Facebook Ads and Google Ads data into a single dataset.
- Aggregate advertising metrics by date, media source, campaign, and ad set.
- Calculate total spend, impressions, clicks, and conversion value.
- Identify the campaign with the highest ROMI among campaigns with total spend greater than 500,000.
- Identify the ad set with the highest ROMI within the selected campaign.

## SQL Concepts
- Common Table Expressions (CTEs)
- INNER JOIN
- UNION and UNION ALL
- Aggregate functions (SUM)
- GROUP BY and ORDER BY
- Subqueries
- HAVING
- ROMI analysis

## Tools
- PostgreSQL
- SQL

## Data Sources
- `facebook_ads_basic_daily`
- `facebook_adset`
- `facebook_campaign`
- `google_ads_basic_daily`

## File
- `join-union-cte-advertising-analysis.sql` — SQL queries for integrating Facebook and Google Ads data, aggregating campaign performance, and performing ROMI analysis.

## Bonus Analysis
The bonus analysis identifies:
- The campaign with the highest ROMI among campaigns with total spend above 500,000.
- The ad set with the highest ROMI within that campaign.
