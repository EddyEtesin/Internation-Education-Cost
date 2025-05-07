# International Education Cost Analysis - SQL Queries

This repository contains a collection of SQL queries analyzing international education costs across various countries, universities, and programs.

## Database Structure
The queries operate on a table named `International_Education_Costs$` which appears to contain the following columns:
- Country
- City
- University
- Program
- Level (e.g., Master)
- Tuition_USD
- Rent_USD
- Insurance_USD
- Visa_Fee_USD

## Query Analysis

### 1. Basic Aggregations
- Average tuition by country
- Highest average rent cost by program
- Master's level programs count by country
- Average insurance cost by education level
- Average visa fee by country

### 2. Comparative Analysis
- Universities with above-average tuition fees
- Programs with above-average rent costs
- Universities with lowest tuition in each country

### 3. Cost Calculations
- Top 10 most expensive universities by total cost (tuition + rent + insurance)
- Cities ranked by average rent within each country

### 4. Advanced Analytics
- University tuition rankings within countries
- Top 3 most expensive universities per country
- Rent differences from country averages
- Tuition classification (Low/Medium/High)
- STEM vs Non-STEM program cost analysis

## Key Insights
The queries provide valuable insights into:
- Cost distributions across different countries and education levels
- Relative affordability of universities within their countries
- Expense patterns between different program categories
- Components of education costs (tuition, rent, insurance, visa fees)

## Usage
To use these queries:
1. Ensure you have the `International_Education_Costs$` table in your database
2. Run individual queries to extract specific insights
3. Modify queries as needed for your particular database system

Note: Some queries use SQL Server-specific syntax (e.g., `TOP` clause) which may need adjustment for other database systems.
