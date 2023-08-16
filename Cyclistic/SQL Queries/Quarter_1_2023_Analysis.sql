## Data Insights from Quarter 1, 2023
-- Breakdown of Bike Type for Members & Casuals based on Membership
SELECT 
    'Q1' as Quarter,
    rideable_type AS 'Type',
    member_casual AS 'Membership_Type',
    COUNT(*) AS 'Count',
    (COUNT(*) / total_members * 100) AS 'Percentage'
FROM
    2023_Quarter_1
        CROSS JOIN
    (SELECT 
        COUNT(*) AS total_members
    FROM
        2023_Quarter_1
    WHERE
        member_casual = 'member') AS member_counts
WHERE
    member_casual = 'member'
GROUP BY rideable_type , member_casual , total_members 
UNION SELECT 
        'Q1' as Quarter,
    rideable_type AS 'Type',
    member_casual AS 'Membership_Type',
    COUNT(*) AS 'Count',
    (COUNT(*) / total_members * 100) AS 'Percentage'
FROM
    2023_Quarter_1
        CROSS JOIN
    (SELECT 
        COUNT(*) AS total_members
    FROM
        2023_Quarter_1
    WHERE
        member_casual = 'casual') AS member_counts
WHERE
    member_casual = 'casual'
GROUP BY rideable_type , member_casual , total_members;

-- Breakdown of Bike Type for Members & Casuals based on Membership
SELECT 
   'Q1' as Quarter,
   trip_day_of_week AS 'Weekday',
    member_casual AS 'Membership_Type',
    COUNT(*) AS 'Count',
    (COUNT(*) / total_members * 100) AS 'Percentage'
FROM
    2023_Quarter_1
        CROSS JOIN
    (SELECT 
        COUNT(*) AS total_members
    FROM
        2023_Quarter_1
    WHERE
        member_casual = 'member') AS member_counts
WHERE
    member_casual = 'member'
GROUP BY 2, 3, total_members 
UNION SELECT 
	"Q1" as Quarter,
	trip_day_of_week AS 'Weekday',
    member_casual AS 'Membership_Type',
    COUNT(*) AS 'Count',
    (COUNT(*) / total_members * 100) AS 'Percentage'
FROM
    2023_Quarter_1
        CROSS JOIN
    (SELECT 
        COUNT(*) AS total_members
    FROM
        2023_Quarter_1
    WHERE
        member_casual = 'casual') AS member_counts
WHERE
    member_casual = 'casual'
GROUP BY 1 , 2 , total_members;


-- Top 10 Start Stations by Members
SELECT 
    Start_station_name, member_casual, COUNT(*) AS Count
FROM
    2023_Quarter_1
WHERE
    member_casual = 'member'
        AND start_station_name != ''
GROUP BY Start_station_name
ORDER BY Count DESC
LIMIT 10;

-- Top 10 Start Stations by Casual Riders
SELECT 
    'Q1' as Quarter,Start_station_name, member_casual, COUNT(*) AS Count
FROM
    2023_Quarter_1
WHERE
    member_casual = 'casual'
        AND start_station_name != ''
GROUP BY Start_station_name
ORDER BY Count DESC
LIMIT 10;

-- Average Trip Durations by month by membership type
SELECT 
    trip_month AS month,
    'member' AS member,
    SEC_TO_TIME(ROUND(AVG(CASE
                        WHEN member_casual = 'member' THEN trip_duration_time
                    END))) AS avg_trip_duration_member,
    'casual' AS casual,
    SEC_TO_TIME(ROUND(AVG(CASE
                        WHEN member_casual = 'casual' THEN trip_duration_time
                    END))) AS avg_trip_duration_casual
FROM
    2023_Quarter_1
WHERE
    member_casual IN ('member' , 'casual')
GROUP BY trip_month
ORDER BY trip_month;

-- Breaking Down the Total Trips per Month and Trips Per Day Per Month for Both Membership Levels
SELECT 
    month,
    Days,
    member,
    Total_Trips_Members,
    (Total_Trips_Members / Days) AS M_Trips_Per_day_,
    casual,
    Total_Trips_Casuals,
    (Total_Trips_Casuals / Days) AS C_Trips_Per_day
FROM
    (SELECT 
        trip_month AS month,
            COUNT(DISTINCT LEFT(started_at, 10)) AS Days,
            'member' AS member,
            SUM(CASE
                WHEN member_casual = 'member' THEN 1
                ELSE 0
            END) AS Total_Trips_Members,
            'casual' AS casual,
            SUM(CASE
                WHEN member_casual = 'casual' THEN 1
                ELSE 0
            END) AS Total_Trips_Casuals
    FROM
        2023_Quarter_1
    WHERE
        member_casual IN ('member' , 'casual')
    GROUP BY trip_month
    ORDER BY trip_month) AS subquery;


-- Average Start Time for the trip by Membership Type
SELECT 
	'Q1' as Quarter,
    member_casual AS membership_type,
    SEC_TO_TIME(AVG(TIME_TO_SEC())) AS avg_start_time
FROM
    2023_Quarter_1
GROUP BY member_casual;
        
  -- Peak Hours for Members      
(SELECT 
	'Q1' as Quarter,
    member_casual AS membership_type,
    HOUR(started_at) AS peak_hour,
    COUNT(*) AS ride_count
FROM
    2023_Quarter_1
WHERE
    member_casual = 'member'
GROUP BY member_casual , peak_hour
ORDER BY member_casual , ride_count DESC
LIMIT 3)
UNION 
(SELECT 
	'Q1' as Quarter,
    member_casual AS membership_type,
    HOUR(started_at) AS peak_hour,
    COUNT(*) AS ride_count
FROM
    2023_Quarter_1
WHERE
    member_casual = 'casual'
GROUP BY member_casual , peak_hour
ORDER BY member_casual , ride_count DESC
LIMIT 3);

-- Lull Hours
(SELECT 
    'Q1' AS Quarter,
    member_casual AS membership_type,
    HOUR(started_at) AS peak_hour,
    COUNT(*) AS ride_count
FROM
    2023_Quarter_1
WHERE
    member_casual = 'member'
GROUP BY member_casual , peak_hour
ORDER BY member_casual , ride_count ASC
LIMIT 3) 
UNION 
(SELECT 
	'Q1' AS Quarter,
    member_casual AS membership_type,
    HOUR(started_at) AS peak_hour,
    COUNT(*) AS ride_count
FROM
    2023_Quarter_1
WHERE
    member_casual = 'casual'
GROUP BY member_casual , peak_hour
ORDER BY member_casual , ride_count ASC
LIMIT 3);


-- Weekends vs Weekdays
SELECT 
	'Q1' AS Quarter,
    membership_type,
    day_type,
    ride_count,
    (ride_count / total_ride_count) * 100 AS Percent
FROM
    (SELECT 
        member_casual AS membership_type,
            CASE
                WHEN trip_day_of_week IN ('Saturday' , 'Sunday') THEN 'Weekend'
                ELSE 'Weekday'
            END AS day_type,
            COUNT(*) AS ride_count
    FROM
        2023_Quarter_1
    GROUP BY member_casual , day_type
    ORDER BY member_casual , day_type) AS subquery
        JOIN
    (SELECT 
        member_casual, COUNT(*) AS total_ride_count
    FROM
        2023_Quarter_1
    GROUP BY member_casual) AS total_rides ON subquery.membership_type = total_rides.member_casual;
