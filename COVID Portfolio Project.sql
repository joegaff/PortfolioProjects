-- Global Numbers: Total Cases, Total Deaths, Overall Death Rate
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    SUM(new_deaths) / SUM(new_cases) * 100 AS Death_Rate
FROM
    Portfolio_Project.coviddeaths
WHERE
    continent <> ''
ORDER BY 1 , 2;

-- Looking at Total Cases, Total Deaths, and Death Rates per day in United States
SELECT 
    Location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS Death_Rates
FROM
    Portfolio_Project.coviddeaths
WHERE
    location = 'United States'
        AND total_cases <> 0
ORDER BY 1 , 2;

-- Looking at Total Percent of Population that has been infected by COVID on a day-to-day bias
SELECT 
    Location,
    date,
    population,
    total_cases,
    (total_cases / population) * 100 AS Population_Infected_Rate
FROM
    Portfolio_Project.coviddeaths
WHERE
    location = 'United States'
        AND total_cases <> 0
ORDER BY 1 , 2;

-- Looking at Top 10 Countries with the Highest Infection Rates compared to Population
SELECT 
    Location,
    population,
    MAX(total_cases) AS Highest_Infection_Count,
    MAX((total_cases / population)) * 100 AS Population_Infected_Rate
FROM
    Portfolio_Project.coviddeaths
GROUP BY Location , Population
ORDER BY Population_Infected_Rate DESC
LIMIT 10;

-- Looking at Top 10 Countries with the Highest Death Count
SELECT 
    Location, MAX(total_deaths) AS Total_Death_Count
FROM
    Portfolio_Project.coviddeaths
WHERE
    continent <> ''
GROUP BY Location
ORDER BY Total_Death_Count DESC
LIMIT 10;

SELECT 
    location, MAX(total_deaths) AS Total_Death_Count
FROM
    Portfolio_Project.coviddeaths
WHERE
    continent = ''
        AND location NOT LIKE '%income%'
        AND location NOT LIKE '%World%'
GROUP BY location
ORDER BY Total_Death_Count DESC;

-- Looking at the Rolling Total Vaccinations and Percent of Population Vaxxed per Continent per day
With PopvsVac (continent, location, date, population, new_vaccinations, rolling_total_vaccinations)
as
(
Select DEATH.continent, DEATH.location, DEATH.date, DEATH.population, VAC.new_vaccinations
,SUM(VAC.new_vaccinations) OVER (Partition by DEATH.location Order by DEATH.location, DEATH.date) as rolling_total_vaccinations
From Portfolio_Project.CovidDeaths as DEATH
Join Portfolio_Project.CovidVaccinations as VAC
	on DEATH.location = VAC.location
    and DEATH.date = VAC.date
WHERE DEATH.continent <> '' 
order by 2,3
)
Select *, (Rolling_total_vaccinations/population) * 100 as Population_Vaxed_Percentage
From PopvsVac;

-- Which country is most vaccinated per pupil?
With PopvsVac (continent, location, date, population, people_fully_vaccinated)
as
(
Select DEATH.continent, DEATH.location, DEATH.date, DEATH.population, VAC.people_fully_vaccinated
From Portfolio_Project.CovidDeaths as DEATH
Join Portfolio_Project.CovidVaccinations as VAC
	on DEATH.location = VAC.location
    and DEATH.date = VAC.date
WHERE DEATH.continent <> '' and VAC.people_fully_vaccinated <>''
order by 2,3
)
Select location, max(people_fully_vaccinated/population) as Population_Vaxed_Percentage
From PopvsVac
Group by location, population
Order by 2 desc;

-- Which country is least vaccinated per pupil?
With PopvsVac (continent, location, date, population, people_fully_vaccinated)
as
(
Select DEATH.continent, DEATH.location, DEATH.date, DEATH.population, VAC.people_fully_vaccinated
From Portfolio_Project.CovidDeaths as DEATH
Join Portfolio_Project.CovidVaccinations as VAC
	on DEATH.location = VAC.location
    and DEATH.date = VAC.date
WHERE DEATH.continent <> '' and VAC.people_fully_vaccinated <>''
order by 2,3
)
Select location, max(people_fully_vaccinated/population) as Population_Vaxed_Percentage
From PopvsVac
Group by location, population
Order by 2 asc;

-- Creating Views to store data for later visualizations
USE  Portfolio_Project;
Create View Percent_Population_Vaccinated as 
With PopvsVac (continent, location, date, population, new_vaccinations, rolling_total_vaccinations)
as
(
Select DEATH.continent, DEATH.location, DEATH.date, DEATH.population, VAC.new_vaccinations
,SUM(VAC.new_vaccinations) OVER (Partition by DEATH.location Order by DEATH.location, DEATH.date) as rolling_total_vaccinations
From Portfolio_Project.CovidDeaths as DEATH
Join Portfolio_Project.CovidVaccinations as VAC
	on DEATH.location = VAC.location
    and DEATH.date = VAC.date
WHERE DEATH.continent <> '' 
order by 2,3
)
Select *, (Rolling_total_vaccinations/population) * 100 as Population_Vaxed_Percentage
From PopvsVac;

CREATE VIEW Daily_Covid_Cases_by_Country AS
    SELECT 
        Location,
        date,
        total_cases,
        total_deaths,
        (total_deaths / total_cases) * 100 AS Death_Rate
    FROM
        Portfolio_Project.coviddeaths
    WHERE
        location = 'United States'
            AND total_cases <> 0
    ORDER BY 1 , 2;

CREATE VIEW Daily_Infection_Rate_by_Country AS
    SELECT 
        Location,
        date,
        population,
        total_cases,
        (total_cases / population) * 100 AS Population_Infected_Rate
    FROM
        Portfolio_Project.coviddeaths
    WHERE
        location = 'United States'
            AND total_cases <> 0
    ORDER BY 1 , 2;

CREATE VIEW Highest_Infected_Countries AS
    SELECT 
        Location,
        population,
        MAX(total_cases) AS Highest_Infection_Count,
        MAX((total_cases / population)) * 100 AS Population_Infected_Rate
    FROM
        Portfolio_Project.coviddeaths
    GROUP BY Location , Population
    ORDER BY Population_Infected_Rate DESC;

CREATE VIEW Highest_Death_Count AS
    SELECT 
        Location, MAX(total_deaths) AS Total_Death_Count
    FROM
        Portfolio_Project.coviddeaths
    WHERE
        continent <> ''
    GROUP BY Location
    ORDER BY Total_Death_Count DESC;

CREATE VIEW Highest_Death_Count AS
    SELECT 
        Location,
        population,
        MAX(total_deaths) AS total_deaths,
        MAX(total_deaths) / population * 1000 AS Crude_Death_Rate_per_1k
    FROM
        Portfolio_Project.coviddeaths
    WHERE
        continent <> ''
    GROUP BY Location , population
    ORDER BY Crude_Death_Rate_per_1k DESC;

CREATE VIEW Highest_Death_Count_by_Continent AS
    SELECT 
        location,
        MAX(total_deaths) AS Total_Death_Count,
        MAX(total_deaths) / population * 1000 AS Crude_Death_Rate_per_1k
    FROM
        Portfolio_Project.coviddeaths
    WHERE
        continent = ''
            AND location NOT LIKE '%income%'
            AND location NOT LIKE '%world%'
    GROUP BY location , population
    ORDER BY Crude_Death_Rate_per_1k DESC;

CREATE VIEW Overall_Statistics AS
    SELECT 
        SUM(new_cases) AS total_cases,
        SUM(new_deaths) AS total_deaths,
        SUM(new_deaths) / SUM(new_cases) * 100 AS Death_Rate
    FROM
        Portfolio_Project.coviddeaths
    WHERE
        continent <> ''
    ORDER BY 1 , 2;

CREATE VIEW Rolling_Vaccination_Count as
Select DEATH.continent, DEATH.location, DEATH.date, DEATH.population, VAC.new_vaccinations
,SUM(VAC.new_vaccinations) OVER (Partition by DEATH.location Order by DEATH.location, DEATH.date) as rolling_total_vaccinations
From Portfolio_Project.CovidDeaths as DEATH
Join Portfolio_Project.CovidVaccinations as VAC
	on DEATH.location = VAC.location
    and DEATH.date = VAC.date
WHERE DEATH.continent <> '' 
order by 2,3;

CREATE VIEW Highest_Vaccinated_Countries AS
With PopvsVac (continent, location, date, population, people_fully_vaccinated)
as
(
Select DEATH.continent, DEATH.location, DEATH.date, DEATH.population, VAC.people_fully_vaccinated
From Portfolio_Project.CovidDeaths as DEATH
Join Portfolio_Project.CovidVaccinations as VAC
	on DEATH.location = VAC.location
    and DEATH.date = VAC.date
WHERE DEATH.continent <> '' and VAC.people_fully_vaccinated <>''
order by 2,3
)
Select location, max(people_fully_vaccinated/population) as Population_Vaxed_Percentage
From PopvsVac
Group by location, population
Order by 2 desc;

CREATE VIEW Least_Vaccinated_Countries AS
With PopvsVac (continent, location, date, population, people_fully_vaccinated)
as
(
Select DEATH.continent, DEATH.location, DEATH.date, DEATH.population, VAC.people_fully_vaccinated
From Portfolio_Project.CovidDeaths as DEATH
Join Portfolio_Project.CovidVaccinations as VAC
	on DEATH.location = VAC.location
    and DEATH.date = VAC.date
WHERE DEATH.continent <> '' and VAC.people_fully_vaccinated <>''
order by 2,3
)
Select location, max(people_fully_vaccinated/population) as Population_Vaxed_Percentage
From PopvsVac
Group by location, population
Order by 2 asc;

###
