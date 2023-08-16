## Analylitc Insights from Spotify's Top 10,000 Tracks

-- Top 10 Songs by Popularity
SELECT 
    Album_Release_date, Track_Name, Artist_Names, Popularity
FROM
    Spotify
ORDER BY Popularity DESC
LIMIT 10;
 
-- Top Artist by Number of Tracks in the Dataset:
SELECT 
    Artist_Names, COUNT(*) AS Number_of_Tracks
FROM
    Spotify
GROUP BY Artist_Names
ORDER BY Number_of_Tracks DESC
LIMIT 10;

-- Average Popularity by Album Release Year:
SELECT 
    YEAR(Album_Release_Date) AS Release_Year,
    AVG(Popularity) AS Average_Popularity,
    COUNT(*) AS Number_of_Songs
FROM
    spotify
WHERE
    Album_Release_Date <> 0
GROUP BY YEAR(Album_Release_Date)
ORDER BY Release_Year;

-- Explicit vs Non-Explicit 
SELECT 
    (COUNT(CASE
        WHEN Explicit = 'FALSE' THEN 1
    END) / COUNT(*)) * 100 AS Total_Non_Explicit_Songs,
    (COUNT(CASE
        WHEN Explicit = 'TRUE' THEN 1
    END) / COUNT(*)) * 100 AS Total_Explicit_Songs
FROM
    spotify;

-- Average Characteristic of Songs by Release Year
SELECT 
    YEAR(Album_Release_Date) AS Release_Year,
    ROUND(AVG(Danceability), 2) AS Average_Danceability,
    ROUND(AVG(Loudness), 2) AS Average_Loudness,
    ROUND(AVG(Acousticness), 2) AS Average_Acousticness,
    ROUND(AVG(Energy), 2) AS Average_Energy,
    ROUND(AVG(Speechiness), 2) AS Average_Speechiness
FROM
    spotify
WHERE
    Album_Release_Date <> 0
GROUP BY YEAR(Album_Release_Date)
ORDER BY Release_Year;
