-- Global Numbers: Total Cases, Total Deaths, Overall Death Rate
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/sum(new_cases) *100 as Death_Rate
FROM Portfolio_Project.coviddeaths
WHERE continent <> '' 
ORDER BY 1,2;

-- Looking at Total Cases, Total Deaths, and Death Rates per day in United States
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as Death_Rates
FROM Portfolio_Project.coviddeaths
WHERE location = 'United States' and total_cases <> 0
ORDER BY 1,2;

-- Looking at Total Percent of Population that has been infected by COVID on a day-to-day bias
SELECT Location, date, population, total_cases, (total_cases/population) * 100 as Population_Infected_Rate
FROM Portfolio_Project.coviddeaths
WHERE location = 'United States' and total_cases <> 0
ORDER BY 1,2;

-- Looking at Top 10 Countries with the Highest Infection Rates compared to Population
SELECT Location, population, max(total_cases) as Highest_Infection_Count, Max((total_cases/population)) * 100 as Population_Infected_Rate
FROM Portfolio_Project.coviddeaths
GROUP BY Location, Population
ORDER BY Population_Infected_Rate desc
LIMIT 10;

-- Looking at Top 10 Countries with the Highest Death Count
SELECT Location, max(total_deaths) as Total_Death_Count
FROM Portfolio_Project.coviddeaths
WHERE continent <> ''
GROUP BY Location
ORDER BY Total_Death_Count desc
LIMIT 10;

## Breaking Down by Continents:
-- Showing all Continents Death's Counts in descending order
SELECT location, max(total_deaths) as Total_Death_Count
FROM Portfolio_Project.coviddeaths
WHERE continent = '' AND location not like "%income%" AND location not like "%World%"
GROUP BY location
ORDER BY Total_Death_Count desc;

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

Create View Daily_Covid_Cases_by_Country as 
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as Death_Rate
FROM Portfolio_Project.coviddeaths
WHERE location = 'United States' and total_cases <> 0
ORDER BY 1,2;

Create View Daily_Infection_Rate_by_Country as 
SELECT Location, date, population, total_cases, (total_cases/population) * 100 as Population_Infected_Rate
FROM Portfolio_Project.coviddeaths
WHERE location = 'United States' and total_cases <> 0
ORDER BY 1,2;

Create View Highest_Infected_Countries as
SELECT Location, population, max(total_cases) as Highest_Infection_Count, Max((total_cases/population)) * 100 as Population_Infected_Rate
FROM Portfolio_Project.coviddeaths
GROUP BY Location, Population
ORDER BY Population_Infected_Rate desc;

Create View Highest_Death_Count as
SELECT Location, max(total_deaths) as Total_Death_Count
FROM Portfolio_Project.coviddeaths
WHERE continent <> ''
GROUP BY Location
ORDER BY Total_Death_Count desc;

Create View Highest_Death_Count as
SELECT Location, population, max(total_deaths) as total_deaths, max(total_deaths)/population * 1000 as Crude_Death_Rate_per_1k
FROM Portfolio_Project.coviddeaths
WHERE continent <> ''
GROUP BY Location, population
ORDER BY Crude_Death_Rate_per_1k desc;

Create View Highest_Death_Count_by_Continent as
SELECT location, max(total_deaths) as Total_Death_Count, max(total_deaths)/population * 1000 as Crude_Death_Rate_per_1k
FROM Portfolio_Project.coviddeaths
WHERE continent = '' AND location not like "%income%" AND location not like "%world%"
GROUP BY location, population
ORDER BY Crude_Death_Rate_per_1k desc;

Create View Overall_Statistics as
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/sum(new_cases) *100 as Death_Rate
FROM Portfolio_Project.coviddeaths
WHERE continent <> '' 
ORDER BY 1,2;

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
