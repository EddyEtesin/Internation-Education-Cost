select * from International_Education_Costs$

---- 1. What is the average tuition cost for each country?
select Country , Avg(Tuition_USD) as Average_Tuition from International_Education_Costs$
group by Country 

---2. Which program has the highest average rent cost across all cities?
select top 1 Program , Avg(Rent_USD) as average_rent from International_Education_Costs$
group by program
order by average_rent desc

----3. Find the total number of Master’s level programs per country.
select country, count(*) as No_of_Masters_program from International_Education_Costs$
where [Level] = 'Master'
group by country 

----4. List the average insurance cost by level of education.
select [Level],avg(Insurance_USD) as average_Insurance from International_Education_Costs$
group by [Level]

----5. What is the average visa fee charged in each country? 
select country, avg(Visa_Fee_USD) as Average_Visa_fee_USD
from International_Education_Costs$
group by country 

----6. Which universities have a tuition fee above the average of all universities?
select University, Tuition_USD 
from International_Education_Costs$ 
where Tuition_USD >  ( select avg(Tuition_USD) from International_Education_Costs$ )

---7. List programs where the rent is higher than the average rent of all cities.
select program, Rent_USD from International_Education_Costs$
where Rent_USD > ( select avg(Rent_USD) from International_Education_Costs$)

----8. Find the universities with the lowest tuition fee in their respective countries.

with RankedTuitions as (
	select 
		Country, University, tuition_USD,
		row_number () over(Partition by country order by tuition_USD asc) as Rank
	from International_Education_Costs$
)
select
	Country, University, tuition_USD 
	from  RankedTuitions
	where Rank = 1
	order by Tuition_USD;

----9. Use a CTE to calculate the total cost per university and list the top 10 most expensive ones.
WITH ranked_costs AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY University ORDER BY (Tuition_USD + Rent_USD + Insurance_USD) DESC) AS Rank
    FROM International_Education_Costs$
)
SELECT  top 10
    University,
    (Tuition_USD + Rent_USD + Insurance_USD) AS Total_Cost
FROM ranked_costs
WHERE Rank = 1
ORDER BY Total_Cost DESC;

-----10. With a CTE, rank cities within each country by average rent cost.

WITH city_rents AS (
    SELECT 
        Country,
        City,
        AVG(Rent_USD) AS Average_rent,
        ROW_NUMBER() OVER(PARTITION BY Country ORDER BY AVG(Rent_USD)) AS Rent_Rank
    FROM International_Education_Costs$
    GROUP BY Country, City
)
SELECT 
    Country,
    City,
    Average_rent
FROM city_rents
ORDER BY Country, Average_rent desc;
	
---Use ROW_NUMBER() to assign ranks to universities within each country based on tuition.
select Country, University, Tuition_USD,
ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Tuition_USD desc) AS Tuition_Rank
from International_Education_Costs$ 

---14. Use RANK() to find top 3 most expensive universities in each country by tuition.
WITH RankedUniversities AS (
    SELECT country,University,Tuition_USD,
        RANK() OVER (PARTITION BY country ORDER BY Tuition_USD DESC) AS Rank
    FROM International_Education_Costs$
)
SELECT country,University,Tuition_USD,Rank
FROM RankedUniversities
WHERE Rank <= 3
ORDER BY country,Tuition_USD Desc;

---15. Show the difference in rent between each city and the average rent in that country using AVG() OVER (PARTITION BY Country).
SELECT
    Country,
    City,
    Rent_USD,
    AVG(Rent_USD) OVER (PARTITION BY Country) AS Avg_Country_Rent,
    Rent_USD - AVG(Rent_USD) OVER (PARTITION BY Country) AS Rent_Difference
FROM
    International_Education_Costs$
ORDER BY
    Country,
    Rent_Difference DESC;

-----16. Create a column that classifies tuition as 'Low', 'Medium', or 'High' using CASE.

select country,University,Tuition_USD ,
case when Tuition_USD < 10000 then 'Low'
when Tuition_USD between 10000 and 30000 then 'Medium'
else 'high'
end as Tution_Rate
FROM
    International_Education_Costs$
order by Country, Tuition_USD 

----Categorize programs into STEM and Non-STEM and get the average cost per category.

select case
        when Program Like '%Engineering%' 
          Or Program Like '%Technology%' 
          Or Program Like '%Science%' 
          Or Program Like '%Mathematics%' 
          Or Program Like '%Computer%' 
        then 'STEM'
        else 'Non-STEM'
		end as Program_category, 
		avg(Tuition_USD) as Average_tuition 
from International_Education_Costs$
group by 
case
        when Program Like '%Engineering%' 
          Or Program Like '%Technology%' 
          Or Program Like '%Science%' 
          Or Program Like '%Mathematics%' 
          Or Program Like '%Computer%' 
        then 'STEM'
        else 'Non-STEM'
		end 