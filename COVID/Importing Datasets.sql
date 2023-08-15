DROP TABLE IF EXISTS coviddeaths;
USE Portfolio_Project;
CREATE TABLE `coviddeaths` (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` date DEFAULT NULL,
  `population` int DEFAULT NULL,
  `total_cases` int DEFAULT NULL,
  `new_cases` int DEFAULT NULL,
  `new_cases_smoothed` decimal NULL,
  `total_deaths` int DEFAULT NULL,
  `new_deaths` int DEFAULT NULL,
  `new_deaths_smoothed` double DEFAULT NULL,
  `total_cases_per_million` int DEFAULT NULL,
  `new_cases_per_million` int DEFAULT NULL,
  `new_cases_smoothed_per_million` double DEFAULT NULL,
  `total_deaths_per_million` double DEFAULT NULL,
  `new_deaths_per_million` double DEFAULT NULL,
  `new_deaths_smoothed_per_million` double DEFAULT NULL,
  `reproduction_rate` double DEFAULT NULL,
  `icu_patients` int DEFAULT NULL,
  `icu_patients_per_million` double DEFAULT NULL,
  `hosp_patients` bigint DEFAULT NULL,
  `hosp_patients_per_million` double DEFAULT NULL,
  `weekly_icu_admissions` double DEFAULT NULL,
  `weekly_icu_admissions_per_million` double DEFAULT NULL,
  `weekly_hosp_admissions` double DEFAULT NULL,
  `weekly_hosp_admissions_per_million` double DEFAULT NULL);


LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/CovidDeaths.csv'
INTO TABLE Portfolio_Project.coviddeaths
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;





## Importing COVID Vaccination Table
DROP TABLE IF EXISTS covidvaccinations;
USE Portfolio_Project;
CREATE TABLE covidvaccinations (
    iso_code VARCHAR(3),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    total_tests INT,
    new_tests INT,
    total_tests_per_thousand DOUBLE,
    new_tests_per_thousand DOUBLE,
    new_tests_smoothed INT,
    new_tests_smoothed_per_thousand DOUBLE,
    positive_rate DOUBLE,
    tests_per_case DOUBLE,
    tests_units VARCHAR(50),
    total_vaccinations INT,
    people_vaccinated INT,
    people_fully_vaccinated INT,
    total_boosters INT,
    new_vaccinations INT,
    new_vaccinations_smoothed INT,
    total_vaccinations_per_hundred DOUBLE,
    people_vaccinated_per_hundred DOUBLE,
    people_fully_vaccinated_per_hundred DOUBLE,
    total_boosters_per_hundred DOUBLE,
    new_vaccinations_smoothed_per_million DOUBLE,
    new_people_vaccinated_smoothed DOUBLE,
    new_people_vaccinated_smoothed_per_hundred DOUBLE,
    stringency_index DOUBLE,
    population_density DOUBLE,
    median_age DOUBLE,
    aged_65_older DOUBLE,
    aged_70_older DOUBLE,
    gdp_per_capita DOUBLE,
    extreme_poverty DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE,
    female_smokers DOUBLE,
    male_smokers DOUBLE,
    handwashing_facilities DOUBLE,
    hospital_beds_per_thousand DOUBLE,
    life_expectancy DOUBLE,
    human_development_index DOUBLE,
    excess_mortality_cumulative_absolute DOUBLE,
    excess_mortality_cumulative DOUBLE,
    excess_mortality DOUBLE,
    excess_mortality_cumulative_per_million DOUBLE);


LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/CovidVaccinations.csv'
INTO TABLE Portfolio_Project.covidvaccinations
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

covidvaccinations