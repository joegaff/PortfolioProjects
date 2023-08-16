## Data Importation
-- Create Table: July 2022
DROP TABLE IF EXISTS July2022;
USE Cyclistic;
CREATE TABLE July2022 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202207-divvy-tripdata.csv'
INTO TABLE July2022
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE July2022
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE July2022 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Create Table: August 2022
DROP TABLE IF EXISTS Aug2022;
USE Cyclistic;
CREATE TABLE Aug2022 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202208-divvy-tripdata.csv'
INTO TABLE Aug2022
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Aug2022
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Aug2022 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Create Table: September 2022
DROP TABLE IF EXISTS Sep2022;
USE Cyclistic;
CREATE TABLE Sep2022 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202209-divvy-tripdata.csv'
INTO TABLE Sep2022
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Sep2022
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Sep2022 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Create Table: October 2022
DROP TABLE IF EXISTS Oct2022;
USE Cyclistic;
CREATE TABLE Oct2022 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202210-divvy-tripdata.csv'
INTO TABLE Oct2022
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Oct2022
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Oct2022 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Create Table: November 2022
DROP TABLE IF EXISTS Nov2022;
USE Cyclistic;
CREATE TABLE Nov2022 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202211-divvy-tripdata.csv'
INTO TABLE Nov2022
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Nov2022
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Nov2022 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Creat Table Decemeber 2022
DROP TABLE IF EXISTS Dec2022;
USE Cyclistic;
CREATE TABLE Dec2022 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202212-divvy-tripdata.csv'
INTO TABLE Dec2022
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Dec2022
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Dec2022 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Create Table: January 2023
DROP TABLE IF EXISTS Jan2023;
USE Cyclistic;
CREATE TABLE Jan2023 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202301-divvy-tripdata.csv'
INTO TABLE Jan2023
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Jan2023
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Jan2023 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Create Table: February 2023
DROP TABLE IF EXISTS Feb2023;
USE Cyclistic;
CREATE TABLE Feb2023 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202302-divvy-tripdata.csv'
INTO TABLE Feb2023
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Feb2023
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Feb2023 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Creat Table March 2023
DROP TABLE IF EXISTS Mar2023;
USE Cyclistic;
CREATE TABLE Mar2023 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202303-divvy-tripdata.csv'
INTO TABLE Mar2023
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Mar2023
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Mar2023 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Creat Table April 2023
DROP TABLE IF EXISTS Apr2023;
USE Cyclistic;
CREATE TABLE Apr2023 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202304-divvy-tripdata.csv'
INTO TABLE Apr2023
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE Apr2023
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE Apr2023 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Creat Table May 2023
DROP TABLE IF EXISTS May2023;
USE Cyclistic;
CREATE TABLE May2023 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202305-divvy-tripdata.csv'
INTO TABLE May2023
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE May2023
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE May2023 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));

-- Creat Table June 2023
DROP TABLE IF EXISTS June2023;
USE Cyclistic;
CREATE TABLE June2023 (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10 , 6 ),
    start_lng DECIMAL(10 , 6 ),
    end_lat DECIMAL(10 , 6 ),
    end_lng DECIMAL(10 , 6 ),
    member_casual VARCHAR(255)
);

-- Load Data from CSV file into Table 
LOAD DATA LOCAL INFILE '/Users/joegaffney/Downloads/Portfolio Projects/Cyclistic Project/202306-divvy-tripdata.csv'
INTO TABLE June2023
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Step 1: Add new columns
ALTER TABLE June2023
ADD trip_month INT,
ADD trip_day_of_week VARCHAR(10),
ADD trip_duration_time TIME;

-- Step 2: Update trip_month and trip_day_of_week based on started_at
UPDATE June2023 
SET 
    trip_month = MONTH(started_at),
    trip_day_of_week = DAYNAME(started_at),
    trip_duration_time = SEC_TO_TIME(TIMESTAMPDIFF(SECOND,
                started_at,
                ended_at));
                
## Mergeing the Data in Quarterly Table
-- Quarter 1 
CREATE TABLE 2022_Quarter_3 AS
SELECT * FROM July2022 WHERE 1=0;
INSERT INTO 2022_Quarter_3 SELECT * FROM July2022;
INSERT INTO 2022_Quarter_3 SELECT * FROM Aug2022;
INSERT INTO 2022_Quarter_3 SELECT * FROM Sep2022;

CREATE TABLE 2022_Quarter_2_4 AS
SELECT * FROM Oct2022 WHERE 1=0;
INSERT INTO 2022_Quarter_2_4 SELECT * FROM Oct2022;
INSERT INTO 2022_Quarter_2_4 SELECT * FROM Nov2022;
INSERT INTO 2022_Quarter_2_4 SELECT * FROM Dec2022;

CREATE TABLE 2023_Quarter_1 AS
SELECT * FROM Jan2023 WHERE 1=0;
INSERT INTO 2023_Quarter_1 SELECT * FROM Jan2023;
INSERT INTO 2023_Quarter_1 SELECT * FROM Feb2023;
INSERT INTO 2023_Quarter_1 SELECT * FROM Mar2023;

CREATE TABLE 2023_Quarter_2 AS
SELECT * FROM Apr2023 WHERE 1=0;
INSERT INTO 2023_Quarter_2 SELECT * FROM Apr2023;
INSERT INTO 2023_Quarter_2 SELECT * FROM May2023;
INSERT INTO 2023_Quarter_2 SELECT * FROM June2023;

RENAME TABLE 2022_Quarter_2_4 TO 2022_Quarter_4;

 
 
CREATE TABLE Annual_Data AS
SELECT * FROM July2022 WHERE 1=0;
INSERT INTO Annual_Data SELECT * FROM July2022;
INSERT INTO Annual_Data SELECT * FROM Aug2022;
INSERT INTO Annual_Data SELECT * FROM Sep2022;
INSERT INTO Annual_Data SELECT * FROM Oct2022;
INSERT INTO Annual_Data SELECT * FROM Nov2022;
INSERT INTO Annual_Data SELECT * FROM Dec2022;
INSERT INTO Annual_Data SELECT * FROM Jan2023;
INSERT INTO Annual_Data SELECT * FROM Feb2023;
INSERT INTO Annual_Data SELECT * FROM Mar2023;
INSERT INTO Annual_Data SELECT * FROM Apr2023;
INSERT INTO Annual_Data SELECT * FROM May2023;
INSERT INTO Annual_Data SELECT * FROM June2023;
 
 
-- Update to remove leading and trailing spaces and non-printable characters
UPDATE annual_data
SET member_casual = 'member'
WHERE TRIM(UPPER(member_casual)) IN ('MEMBER', 'MEMBERS', 'MEMBER\r');

UPDATE annual_data
SET member_casual = 'casual'
WHERE TRIM(UPPER(member_casual)) IN ('CASUAL', 'CASUALS', 'CASUAL\r');


-- Update to set correct values for 'member' and 'casual'
UPDATE annual_data
SET member_casual = 'member'
WHERE member_casual IN ('Member', 'MEMBER', 'Members', 'member');

UPDATE annual_data
SET member_casual = 'casual'
WHERE member_casual IN ('Casual', 'CASUAL', 'Casuals', 'casual');

