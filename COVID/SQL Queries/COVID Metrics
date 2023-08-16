/* --------------------
        QUERY SQL
   --------------------*/

-- Global Numbers: Total Cases, Total Deaths, Overall Death Rate
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/sum(new_cases) *100 as Death_Rate
FROM Portfolio_Project.coviddeaths
WHERE continent <> '' 
ORDER BY 1,2;

-- Total Cases, Total Deaths, and Death Rates per day in United States
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as Death_Rates
FROM Portfolio_Project.coviddeaths
WHERE location = 'United States' and total_cases <> 0
ORDER BY 1,2;

-- Total Percent of Population that has been infected by COVID on a day-to-day bias
SELECT Location, date, population, total_cases, (total_cases/population) * 100 as Population_Infected_Rate
FROM Portfolio_Project.coviddeaths
WHERE location = 'United States' and total_cases <> 0
ORDER BY 1,2;

-- Top 10 Countries with the Highest Infection Rates compared to Population
SELECT Location, population, max(total_cases) as Highest_Infection_Count, Max((total_cases/population)) * 100 as Population_Infected_Rate
FROM Portfolio_Project.coviddeaths
GROUP BY Location, Population
ORDER BY Population_Infected_Rate desc
LIMIT 10;

-- Top 10 Countries with the Highest Death Count
SELECT Location, max(total_deaths) as Total_Death_Count
FROM Portfolio_Project.coviddeaths
WHERE continent <> ''
GROUP BY Location
ORDER BY Total_Death_Count desc
LIMIT 10;

-- Breaking Down by Continents:
-- All Continents Death Counts in descending order
SELECT location, max(total_deaths) as Total_Death_Count
FROM Portfolio_Project.coviddeaths
WHERE continent = '' AND location not like "%income%" AND location not like "%World%"
GROUP BY location
ORDER BY Total_Death_Count desc;

-- Rolling Total Vaccinations and Percent of Population Vaxxed per Continent per day
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
