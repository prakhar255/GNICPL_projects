use water_quality;
show tables;
-- Print the table
select * from water_quality_india;

-- Count of Monitoring Stations
SELECT COUNT(DISTINCT STN_code) AS total_monitoring_stations
FROM water_quality_india;

-- Distribution of Water Body Types
SELECT Type_Water_Body, COUNT(*) AS count_of_locations
FROM water_quality_india
GROUP BY Type_Water_Body
ORDER BY count_of_locations DESC;

-- Average WQI by Water Body Type
SELECT Type_Water_Body, ROUND(AVG(WQI),2) AS avg_WQI
FROM water_quality_india
GROUP BY Type_Water_Body
ORDER BY avg_WQI DESC;

-- Average WQI by State
SELECT State_Name, ROUND(AVG(WQI),2) AS avg_WQI
FROM water_quality_india
GROUP BY State_Name
ORDER BY avg_WQI DESC;

-- Top 10 Worst Locations by WQI
SELECT WQI_Category, COUNT(*) AS count
FROM water_quality_india
GROUP BY WQI_Category
ORDER BY count DESC;

-- Yearly Trend of Water Quality
SELECT Year, ROUND(AVG(WQI),2) AS avg_WQI
FROM water_quality_india
GROUP BY Year
ORDER BY Year;

-- Relationship Between Parameters and WQI
SELECT 
    ROUND(AVG(avg_bod_mgl),2) AS avg_BOD,
    ROUND(AVG(avg_dissolved),2) AS avg_DO,
    ROUND(AVG(avg_ph),2) AS avg_pH,
    ROUND(AVG(WQI),2) AS avg_WQI
FROM water_quality_india;

-- Identify Polluted States (WQI > 60)
SELECT State_Name, COUNT(*) AS polluted_locations
FROM water_quality_india
WHERE WQI > 60
GROUP BY State_Name
ORDER BY polluted_locations DESC;