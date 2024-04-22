create database World_Population;

use World_Population;

create table world_population1(
Ranking int ,
Country_code varchar(3) primary key,
Country_name varchar(255),
Capital varchar(255),
Continent varchar(255),
Area_km2 float,
Density_per_km2 float,
Growth_rate float,
World_population_percentage float
);

select * from world_population1

create table world_population2(
Country_code varchar(3) primary key,
2022_population int,
2020_population int,
2015_population int,
2010_population int,
2000_population int,
1990_population int,
1980_population int,
1970_population int,
foreign key (Country_code) references world_population1(Country_code) on delete cascade
);

select * from world_population2;

SELECT * FROM world_population1
WHERE Continent = 'Europe';

SELECT COUNT(*) FROM world_population1
WHERE Continent = 'Asia';

SELECT Continent,
COUNT(*) AS Number_Of_Countries,
AVG(Area_km2) AS Avg_Area,
AVG(Density_per_km2) AS Avg_Density,
AVG(Growth_rate) AS Avg_Growth_Rate,
AVG(World_population_percentage) AS Avg_Population_Percentage
FROM world_population1
GROUP BY Continent;

select * from world_population1 
order by  Ranking asc limit 10;

select * from world_population1 
order by  World_population_percentage desc limit 10;

SELECT Continent,
AVG(Area_km2) AS Avg_Area, AVG(Density_per_km2) AS Avg_Density
FROM world_population1
GROUP BY Continent
HAVING AVG(Area_km2) > 100000;

select * from world_population1 
having World_population_percentage between 0.2 and 0.25;

select * from world_population1 
limit 10;

select SUM(2022_population) from world_population2;
 
select Continent, SUM(2022_population) from world_population2 
as t1 join world_population1 
as t2 on t1.Country_code = t2.Country_code group by t2.Continent;

ALTER TABLE world_population2
ADD 1950_population Decimal(15,2);

select * from world_population2

ALTER TABLE world_population2
RENAME COLUMN 1950_population to 1940_population;

select * from world_population2

ALTER TABLE world_population2
DROP COLUMN 1940_population;

select * from world_population2

INSERT INTO world_population1 (Ranking, Country_code, Country_name, Capital, Continent, 
Area_km2, Density_per_km2, Growth_rate, World_population_percentage)
VALUES (400, 'US', 'United States', 'Washington D.C.', 'North America', 9372610, 35, 0.71, 4.25);

select * from world_population1

UPDATE world_population1
SET Density_per_km2 = 40
WHERE Country_code = 'US';

select * from world_population1

DELETE FROM world_population1
WHERE Country_code = 'US';

select * from world_population1;

-- DCL

grant insert on world_population1 to appachan@localhost;

revoke insert on world_population1 from appachan@localhost;

-- String Functions

SELECT CONCAT(`Country_name`, ' - ', Capital) AS CountryAndCapital
FROM world_population1;

SELECT UPPER(`Country_name`) AS Upper_Country
FROM world_population1;

SELECT LEFT(`Country_name`, 3) AS Shortened_Country_Name
FROM world_population1;

SELECT REPLACE(`Country_name`, ' ', '_') AS Country_With_Underscores
FROM world_population1;

SELECT INSTR('land', Capital) AS Position_Of_Land
FROM world_population1;

-- Aggregate Funtions

select * from world_population1;

SELECT SUM(Area_km2)
FROM world_population1;

SELECT AVG(Density_per_km2)
FROM world_population1;

SELECT AVG(2022_population), MIN(2022_population), 
MAX(2022_population) FROM world_population2;

SELECT MIN(Density_per_km2), MAX(Area_km2)
FROM world_population1;

SELECT COUNT(*) AS High_Growth_Countries
FROM world_population1
WHERE `Growth_rate` > 1.04;

SELECT Country_name AS High_Growth_Countries, Growth_rate as GrowthRate, Ranking
FROM world_population1
WHERE `Growth_rate` > 1.04;

-- numeric functions

SELECT Ranking, Country_code, Country_name, Capital, Continent,
CEILING(Area_km2) AS Rounded_Area, FLOOR(Density_per_km2) AS Floored_Density,
SQRT(Area_km2) AS SquareRoot_Area, MOD(Ranking, 5) AS Rank_Modulo5,
POWER(Density_per_km2, 2) AS Density_Squared, Growth_rate, World_population_percentage
FROM world_population1;

-- Date and Time Function

SELECT Ranking, Country_code, Country_name, Capital,
Continent, Area_km2, Density_per_km2, Growth_rate,
World_population_percentage, NOW() AS CurrentDateTime, CURDATE() AS CurrentDate,
CURTIME() AS CurrentTime, DATE_ADD(CURDATE(), INTERVAL 1 DAY) AS TomorrowDate
FROM world_population1;

-- Arithmetic Operator

select * from world_population2;

select Country_code, 2022_population/2 as 2022_population_halved, 
1990_population+1980_population+1970_population as Early_population,
1970_population*2 as 1970_doubled from world_population2;

select Country_code, 2000_population+1990_population+1980_population 
as Early_population from world_population2;

-- Logical operator

select * from world_population1 where Area_km2 > 100000 
and Growth_rate > 1;

select * from world_population2 where 2022_population > 1000000000 
or 2022_population < 10000;

select * from world_population2 where not 2000_population > 2000;

-- Windows function

SELECT Ranking, Country_code, Country_name, Capital, Continent, Area_km2, 
Density_per_km2, Growth_rate, World_population_percentage,
DENSE_RANK() OVER (ORDER BY Density_per_km2 DESC) AS PopulationDensityRank
FROM world_population1;

SELECT Ranking, Country_code, Country_name, Capital, Continent, Area_km2, 
Density_per_km2, Growth_rate, World_population_percentage,
ROW_NUMBER() OVER (ORDER BY Area_km2 DESC) AS Area_row
FROM world_population1;

-- Control Flow Function

select Country_code,
if(2022_population>10000000, "high", "low") as Population_category 
from world_population2;

select Country_code,
case
when 2022_population>9000000 then "High"
when 2022_population>7000000 then "Medium"
else "Low" 
end as Population_category from world_population2;

-- join

select * from world_population2 left join world_population1 using(Country_code);

select t1.Country_name, t1.Ranking, 
t2.2022_population, t2.1990_population
from world_population1 t1 join world_population2 t2
on t1.Country_code = t2.Country_code where t2.2022_population>1000000 
and t2.1990_population<500000;

SELECT t1.Ranking, t1.Country_code, t1.Country_name, t1.Capital, t1.Continent,
t1.Area_km2, t1.Density_per_km2, t1.Growth_rate, t1.World_population_percentage,
t2.2022_population, t2.2020_population, t2.2015_population, t2.2010_population,
t2.2000_population,t2.1990_population,t2.1980_population,t2.1970_population
FROM world_population1 t1
JOIN world_population2 t2 ON t1.Country_code = t2.Country_code;

-- Common table expression

WITH CTE_Table AS (
SELECT Ranking, Country_code, Country_name, Capital, Continent, 
Area_km2, Density_per_km2,Growth_rate, World_population_percentage
FROM world_population1 WHERE Continent = 'Europe'  
)
SELECT * FROM CTE_Table;

-- View

create view mypopulation as
select Ranking, Country_code, Country_name, Continent
from world_population1
where Growth_rate=1;

select * from mypopulation;

drop view mypopulation;

select * from world_population2;
