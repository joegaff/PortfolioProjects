## Data Importation
-- Creating table Census_2010 with Census Data from 2010
CREATE TABLE Census_2010 (
    Ward INT,
    Total_Population INT,
    White_alone INT,
    Black_or_African_American INT,
    Hispanic_or_Latino INT,
    Asian INT,
    American_Indian_and_Alaska_Native INT,
    Native_Hawaiian_and_Other_Pacific_Islander INT,
    Some_Other_Race INT,
    Two_or_More_Non_White_Races INT,
    Total_Population_Age_18_and_over INT,
    White_alone_Age_18_and_over INT,
    Black_or_African_American_Age_18_and_over INT,
    Hispanic_or_Latino_Age_18_and_over INT,
    Asian_Age_18_and_over INT,
    American_Indian_and_Alaska_Native_Age_18_and_over INT,
    Native_Hawaiian_and_Other_Pacific_Islander_Age_18_and_over INT,
    Some_Other_Race_Age_18_and_over INT,
    Two_or_More_Non_White_Races_Age_18_and_over INT,
    Total_Group_Quarters_Population INT,
    Correctional_Facilities_for_Adults INT,
    Juvenile_Facilities INT,
    Nursing_Facilities INT,
    Other_Institutional_Facilities INT,
    College_University_Student_Housing INT,
    Military_Quarters INT,
    Other_Noninstitutional_Facilities INT,
    Total_Housing_Units INT,
    Occupied_Housing_Units INT,
    Vacant_Housing_Units INT
);

LOAD DATA LOCAL INFILE  '/Users/joegaffney/Downloads/Portfolio Projects/Redistricting/2010_Census_by_Precint.csv'
INTO TABLE Census_2010
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Creating table Census_2020 with Census Data from 2020
CREATE TABLE Census_2020 (
    Ward INT,
    Total_Population INT,
    White_alone INT,
    Black_or_African_American INT,
    Hispanic_or_Latino INT,
    Asian INT,
    American_Indian_and_Alaska_Native INT,
    Native_Hawaiian_and_Other_Pacific_Islander INT,
    Some_Other_Race INT,
    Two_or_More_Non_White_Races INT,
    Total_Population_Age_18_and_over INT,
    White_alone_Age_18_and_over INT,
    Black_or_African_American_Age_18_and_over INT,
    Hispanic_or_Latino_Age_18_and_over INT,
    Asian_Age_18_and_over INT,
    American_Indian_and_Alaska_Native_Age_18_and_over INT,
    Native_Hawaiian_and_Other_Pacific_Islander_Age_18_and_over INT,
    Some_Other_Race_Age_18_and_over INT,
    Two_or_More_Non_White_Races_Age_18_and_over INT,
    Total_Group_Quarters_Population INT,
    Correctional_Facilities_for_Adults INT,
    Juvenile_Facilities INT,
    Nursing_Facilities INT,
    Other_Institutional_Facilities INT,
    College_University_Student_Housing INT,
    Military_Quarters INT,
    Other_Noninstitutional_Facilities INT,
    Total_Housing_Units INT,
    Occupied_Housing_Units INT,
    Vacant_Housing_Units INT
);

LOAD DATA LOCAL INFILE  '/Users/joegaffney/Downloads/Portfolio Projects/Redistricting/2020_Census_by_Precint.csv'
INTO TABLE Census_2020
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Creating table Murphy_Map with Voting District Assignments
CREATE TABLE Murphy_Map (
    Precint INT,
    District INT
);
LOAD DATA LOCAL INFILE  '/Users/joegaffney/Downloads/Portfolio Projects/Redistricting/Murphy Map.csv'
INTO TABLE Murphy_Map
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Total Population by Proposed District
WITH subquery AS (
SELECT 
	m.District,
	c.Total_Population
FROM 
	Census_2020 c
INNER JOIN Murphy_Map m
	on c.Ward = m.Precint)
SELECT 
	District,
    SUM(Total_Population) as Total_Population
FROM 
	subquery
GROUP BY 
	DISTRICT
ORDER BY 
	District; 
    
-- Total Population, and Deviation from Average Population by Proposed District 
WITH subquery AS (
    SELECT 
        m.District,
        SUM(c.Total_Population) as Total_Population
    FROM 
        Census_2020 c
    INNER JOIN Murphy_Map m
        on c.Ward = m.Precint
    GROUP BY 
        m.District
)
SELECT 
    District,
    Total_Population,
    ((Total_Population - AVG(Total_Population) OVER ()) / AVG(Total_Population) OVER ()) * 100 as Deviation
FROM 
    subquery
ORDER BY 
    District;
    
-- Total Population by District for 2020 and 2010, and the percent change in proposal 
WITH subquery AS (
    SELECT 
        m.District,
        SUM(c2020.Total_Population) as Total_Population_2020,
        SUM(c2010.Total_Population) as Total_Population_2010
    FROM 
        Murphy_Map m
    LEFT JOIN Census_2010 c2010 ON c2010.Ward = m.Precint
    LEFT JOIN Census_2020 c2020 ON c2020.Ward = m.Precint
    GROUP BY 
        m.District
)
SELECT 
    District,
    Total_Population_2020,
    Total_Population_2010,
    ROUND(((Total_Population_2020-Total_Population_2010)/Total_Population_2020) * 100,2) as Proposed_Change_Percentage
FROM 
    subquery
ORDER BY 
    District;

-- Population Breakdown by Race by District
WITH subquery AS (
SELECT 
	m.District,
	c.Total_Population,
    c.White_alone,
    c.Black_or_African_American,
    c.Hispanic_or_Latino,
    c.Asian,
    c.American_Indian_and_Alaska_Native,
    c.Native_Hawaiian_and_Other_Pacific_Islander,
    c.Some_Other_Race,
    c.Two_or_More_Non_White_Races
FROM 
	Census_2020 c
INNER JOIN Murphy_Map m
	on c.Ward = m.Precint)
SELECT 
	District,
    SUM(Total_Population) AS Total_Population,
    ROUND((SUM(White_alone) / SUM(Total_Population)) * 100,2) as White_Percentage,
	ROUND((SUM(Black_or_African_American) / SUM(Total_Population)) * 100,2) as Black_Percentage,
	ROUND((SUM(Hispanic_or_Latino) / SUM(Total_Population)) * 100,2) as Latino_Percentage,
	ROUND((SUM(Asian) / SUM(Total_Population)) * 100,2) as Asian_Percentage,
	ROUND((SUM(American_Indian_and_Alaska_Native) / SUM(Total_Population)) * 100,2) as Indian_Percentage,
	ROUND((SUM(Native_Hawaiian_and_Other_Pacific_Islander) / SUM(Total_Population)) * 100,2) as Hawaiian_Percentage,
	ROUND((SUM(Some_Other_Race) / SUM(Total_Population)) * 100,2) as Other_Percentage,
	ROUND((SUM(Two_or_More_Non_White_Races) / SUM(Total_Population)) * 100,2) as Two_or_more_Percentage
FROM 
	subquery
GROUP BY 
	DISTRICT
ORDER BY 
	District; 

-- Population Breakdown by Race by District for 2020 and 2010
WITH subquery AS (
SELECT 
	m.District,
	c2020.Total_Population as Total_Population,
    c2020.White_alone as White_2020,
    c2010.White_alone as White_2010,
    c2020.Black_or_African_American as Black_2020,
    c2010.Black_or_African_American as Black_2010,
    c2020.Hispanic_or_Latino as Latino_2020,
    c2010.Hispanic_or_Latino as Latino_2010,
    c2020.Asian as Asian_2020,
    c2010.Asian as Asian_2010,
    c2020.American_Indian_and_Alaska_Native as Indian_2020,
    c2010.American_Indian_and_Alaska_Native as Indian_2010,
    c2020.Native_Hawaiian_and_Other_Pacific_Islander as Hawaiian_2020,
    c2010.Native_Hawaiian_and_Other_Pacific_Islander as Hawaiian_2010,
    c2020.Some_Other_Race as Other_2020,
    c2010.Some_Other_Race as Other_2010,
    c2020.Two_or_More_Non_White_Races as Two_or_More_2020,
    c2010.Two_or_More_Non_White_Races as Two_or_More_2010
FROM 
	Murphy_Map m
    LEFT JOIN Census_2010 c2010 ON c2010.Ward = m.Precint
    LEFT JOIN Census_2020 c2020 ON c2020.Ward = m.Precint)
SELECT 
	District,
    SUM(Total_Population) AS Total_Population,
    ROUND((SUM(White_2020) / SUM(Total_Population)) * 100,2) as White_Percentage_2020,
    ROUND((SUM(White_2010) / SUM(Total_Population)) * 100,2) as White_Percentage_2010,
	ROUND((SUM(Black_2020) / SUM(Total_Population)) * 100,2) as Black_Percentage_2020,
    ROUND((SUM(Black_2010) / SUM(Total_Population)) * 100,2) as Black_Percentage_2010,
	ROUND((SUM(Latino_2020) / SUM(Total_Population)) * 100,2) as Latino_Percentage_2020,
    ROUND((SUM(Latino_2010) / SUM(Total_Population)) * 100,2) as Latino_Percentage_2010,
	ROUND((SUM(Asian_2020) / SUM(Total_Population)) * 100,2) as Asian_Percentage_2020,
    ROUND((SUM(Asian_2010) / SUM(Total_Population)) * 100,2) as Asian_Percentage_2010,
	ROUND((SUM(Indian_2020) / SUM(Total_Population)) * 100,2) as Indian_Percentage_2020,
    ROUND((SUM(Indian_2010) / SUM(Total_Population)) * 100,2) as Indian_Percentage_2010,
	ROUND((SUM(Hawaiian_2020) / SUM(Total_Population)) * 100,2) as Hawaiian_Percentage_2020,
    ROUND((SUM(Hawaiian_2010) / SUM(Total_Population)) * 100,2) as Hawaiian_Percentage_2010,
	ROUND((SUM(Other_2020) / SUM(Total_Population)) * 100,2) as Other_Percentage_2020,
    ROUND((SUM(Other_2010) / SUM(Total_Population)) * 100,2) as Other_Percentage_2010,
	ROUND((SUM(Two_or_More_2020) / SUM(Total_Population)) * 100,2) as Two_or_more_Percentage_2020,
    ROUND((SUM(Two_or_More_2010) / SUM(Total_Population)) * 100,2) as Two_or_more_Percentage_2010
FROM 
	subquery
GROUP BY 
	DISTRICT
ORDER BY 
	District; 

-- Population Change Breakdown by Race by District for 2020 and 2010
WITH subquery AS (
SELECT 
	m.District,
	c2020.Total_Population as Total_Population,
    c2020.White_alone as White_2020,
    c2010.White_alone as White_2010,
    c2020.Black_or_African_American as Black_2020,
    c2010.Black_or_African_American as Black_2010,
    c2020.Hispanic_or_Latino as Latino_2020,
    c2010.Hispanic_or_Latino as Latino_2010,
    c2020.Asian as Asian_2020,
    c2010.Asian as Asian_2010,
    c2020.American_Indian_and_Alaska_Native as Indian_2020,
    c2010.American_Indian_and_Alaska_Native as Indian_2010,
    c2020.Native_Hawaiian_and_Other_Pacific_Islander as Hawaiian_2020,
    c2010.Native_Hawaiian_and_Other_Pacific_Islander as Hawaiian_2010,
    c2020.Some_Other_Race as Other_2020,
    c2010.Some_Other_Race as Other_2010,
    c2020.Two_or_More_Non_White_Races as Two_or_More_2020,
    c2010.Two_or_More_Non_White_Races as Two_or_More_2010
FROM 
	Murphy_Map m
    LEFT JOIN Census_2010 c2010 ON c2010.Ward = m.Precint
    LEFT JOIN Census_2020 c2020 ON c2020.Ward = m.Precint)
SELECT 
	District,
    SUM(Total_Population) AS Total_Population,
    ROUND((SUM(White_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(White_2010) / SUM(Total_Population)) * 100,2) as White_Percentage_Diff,
	ROUND((SUM(Black_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(Black_2010) / SUM(Total_Population)) * 100,2) as Black_Percentage_Diff,
	ROUND((SUM(Latino_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(Latino_2010) / SUM(Total_Population)) * 100,2) as Latino_Percentage_Diff,
	ROUND((SUM(Asian_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(Asian_2010) / SUM(Total_Population)) * 100,2) as Asian_Percentage_Diff,
	ROUND((SUM(Indian_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(Indian_2010) / SUM(Total_Population)) * 100,2) as Indian_Percentage_Diff,
	ROUND((SUM(Hawaiian_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(Hawaiian_2010) / SUM(Total_Population)) * 100,2) as Hawaiian_Percentage_Diff,
	ROUND((SUM(Other_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(Other_2010) / SUM(Total_Population)) * 100,2) as Other_Percentage_Diff,
	ROUND((SUM(Two_or_More_2020) / SUM(Total_Population)) * 100,2) - ROUND((SUM(Two_or_More_2010) / SUM(Total_Population)) * 100,2) as Two_or_more_Percentage_Diff
FROM 
	subquery
GROUP BY 
	DISTRICT
ORDER BY 
	District; 
    
-- Adult vs Children Population by District
WITH subquery AS (
    SELECT 
        m.District,
        c2020.Total_Population as Total_Population_2020,
        c2020.Total_Population_Age_18_and_over as Adult_Population_2020,
        c2010.Total_Population as Total_Population_2010,
        c2010.Total_Population_Age_18_and_over as Adult_Population_2010
    FROM 
        Murphy_Map m
        LEFT JOIN Census_2020 c2020 on c2020.Ward = m.Precint
        LEFT JOIN Census_2010 c2010 on c2010.Ward = m.Precint)
SELECT 
    District,
    SUM(Total_Population_2020) as Total_Population_2020,
    ROUND(SUM(Adult_Population_2020)/SUM(Total_Population_2020) * 100, 2) as Adult_Population_2020,
    ROUND(((SUM(Total_Population_2020) - SUM(Adult_Population_2020))/SUM(Total_Population_2020)) * 100, 2) as Child_Population_2020,
    SUM(Total_Population_2010) as Total_Population_2010,
    ROUND(SUM(Adult_Population_2010)/SUM(Total_Population_2010) * 100, 2) as Adult_Population_2010,
    ROUND(((SUM(Total_Population_2010) - SUM(Adult_Population_2010))/SUM(Total_Population_2010))*100,2) as Child_Population_2010
FROM 
    subquery
GROUP BY 
    District;
    
-- Boston as a Whole (%)
(SELECT 
    "2010" as Year,
    SUM(Total_Population) AS Total_Population,
    ROUND((SUM(White_alone) / SUM(Total_Population)) * 100,2) as White_Percentage,
	ROUND((SUM(Black_or_African_American) / SUM(Total_Population)) * 100,2) as Black_Percentage,
	ROUND((SUM(Hispanic_or_Latino) / SUM(Total_Population)) * 100,2) as Latino_Percentage,
	ROUND((SUM(Asian) / SUM(Total_Population)) * 100,2) as Asian_Percentage,
	ROUND((SUM(American_Indian_and_Alaska_Native) / SUM(Total_Population)) * 100,2) as Indian_Percentage,
	ROUND((SUM(Native_Hawaiian_and_Other_Pacific_Islander) / SUM(Total_Population)) * 100,2) as Hawaiian_Percentage,
	ROUND((SUM(Some_Other_Race) / SUM(Total_Population)) * 100,2) as Other_Percentage,
	ROUND((SUM(Two_or_More_Non_White_Races) / SUM(Total_Population)) * 100,2) as Two_or_more_Percentage
FROM 
	Census_2010)
UNION 
(SELECT 
	"2020" as Year,
    SUM(Total_Population) AS Total_Population,
    ROUND((SUM(White_alone) / SUM(Total_Population)) * 100,2) as White_Percentage,
	ROUND((SUM(Black_or_African_American) / SUM(Total_Population)) * 100,2) as Black_Percentage,
	ROUND((SUM(Hispanic_or_Latino) / SUM(Total_Population)) * 100,2) as Latino_Percentage,
	ROUND((SUM(Asian) / SUM(Total_Population)) * 100,2) as Asian_Percentage,
	ROUND((SUM(American_Indian_and_Alaska_Native) / SUM(Total_Population)) * 100,2) as Indian_Percentage,
	ROUND((SUM(Native_Hawaiian_and_Other_Pacific_Islander) / SUM(Total_Population)) * 100,2) as Hawaiian_Percentage,
	ROUND((SUM(Some_Other_Race) / SUM(Total_Population)) * 100,2) as Other_Percentage,
	ROUND((SUM(Two_or_More_Non_White_Races) / SUM(Total_Population)) * 100,2) as Two_or_more_Percentage
FROM 
	Census_2020);
    
-- Boston as a Whole (COUNT)
    (SELECT 
    "2010" as Year,
    SUM(Total_Population) AS Total_Population,
    SUM(White_alone) as White,
	SUM(Black_or_African_American) as Black,
	SUM(Hispanic_or_Latino)  as Latino,
	SUM(Asian) as Asian,
	SUM(American_Indian_and_Alaska_Native) as Indian,
	SUM(Native_Hawaiian_and_Other_Pacific_Islander) as Hawaiian,
	SUM(Some_Other_Race) as Other,
	SUM(Two_or_More_Non_White_Races) as Two_or_more
FROM 
	Census_2010)
UNION 
(SELECT 
	"2020" as Year,
    SUM(Total_Population) AS Total_Population,
    SUM(White_alone) as White,
	SUM(Black_or_African_American) as Black,
	SUM(Hispanic_or_Latino)  as Latino,
	SUM(Asian) as Asian,
	SUM(American_Indian_and_Alaska_Native) as Indian,
	SUM(Native_Hawaiian_and_Other_Pacific_Islander) as Hawaiian,
	SUM(Some_Other_Race) as Other,
	SUM(Two_or_More_Non_White_Races) as Two_or_more
FROM 
	Census_2020);