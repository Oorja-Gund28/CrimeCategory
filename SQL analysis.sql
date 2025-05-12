--DATA ANALYSIS

--1. LOCATION BASED ANALYSIS

SELECt Location, COUNT(Crime_Category) [No. of reportings]
FROM train
GROUP BY Location
ORDER BY [No. of reportings] DESC

SELECT Cross_Street, COUNT(Location) [No. of reportings]
FROM train
GROUP BY Cross_Street
ORDER BY [No. of reportings] DESC

SELECT Area_Name, COUNT(Location) [No. of reportings]
FROM train
GROUP BY Area_Name
ORDER BY [No. of reportings] DESC

SELECT Premise_Description, COUNT(Location) [No. of reportings]
FROM train
GROUP BY Premise_Description
ORDER BY [No. of reportings] DESC

SELECT Premise_Code, Premise_Description, Crime_Category, COUNT(Location) [No. of reportings]
FROM train
GROUP BY Premise_Code, Premise_Description, Crime_Category
ORDER BY Premise_Code, [No. of reportings] DESC


SELECT Area_ID, Area_Name, Reporting_District_no, COUNT(*) [No. of reportings]
FROM train
GROUP BY  Area_ID, Area_Name, Reporting_District_no


--TOP CRIME CATEGORY PER AREA
SELECT Area_ID, Area_Name, Crime_Category
FROM
(SELECT Area_ID, Area_Name, Crime_Category, COUNT(*) [No. of reportings],
	ROW_NUMBER() OVER (PARTITION BY Area_ID, Area_Name ORDER BY COUNT(*) DESC) [RANK]
FROM train
GROUP BY  Area_ID, Area_Name, Crime_Category) X
WHERE RANK=1


--TOP CRIME CATEGORY PER DISTRICT
SELECT Area_ID, Area_Name, Reporting_District_no, Crime_Category
FROM
(SELECT Area_ID, Area_Name, Reporting_District_no, Crime_Category, COUNT(*) [No. of reportings],
	ROW_NUMBER() OVER (PARTITION BY Area_ID, Area_Name, Reporting_District_no ORDER BY COUNT(*) DESC) [RANK]
FROM train
GROUP BY  Area_ID, Area_Name, Reporting_District_no, Crime_Category) X
WHERE RANK=1


--To check relevance of Longitude & latitude columns
SELECT Location, Area_Name, Longitude, Latitude, Crime_Category
FROM train
WHERE Location='6TH                          ST' AND Area_Name='Central'


SELECT Location, Area_Name, COUNT(*) FREQUENCY
FROM train
GROUP BY Location, Area_Name
ORDER BY FREQUENCY DESC


--2.TIME BASED ANALYSIS

SELECT Time_Occurred, COUNT(*) FREQUENCY
FROM train
GROUP BY Time_Occurred
ORDER BY Time_Occurred

--Avg days of reporting per crime
SELECT Crime_Category, AVG([No. of days]) [Avg days b/w occuring & reporting]
FROM
(SELECT Crime_Category, Date_Occurred, Date_Reported, DATEDIFF(DAY,Date_Occurred,Date_Reported) [No. of days]
FROM train
) X
GROUP BY Crime_Category
ORDER BY [Avg days b/w occuring & reporting] DESC


SELECT Time_Occurred,
CASE 
    WHEN Time_Occurred BETWEEN 400 AND 759 THEN 'Early Morning'
    WHEN Time_Occurred BETWEEN 800 AND 1159 THEN 'Morning'
    WHEN Time_Occurred BETWEEN 1200 AND 1559 THEN 'Afternoon'
    WHEN Time_Occurred BETWEEN 1600 AND 1959 THEN 'Evening'
    WHEN Time_Occurred BETWEEN 2000 AND 2359 THEN 'Night'
    WHEN Time_Occurred BETWEEN 1 AND 359 THEN 'Late Night'
    ELSE 'Unknown'
END AS Time_Slot
FROM train


--3.VICTIM BASED ANALYSIS

SELECT Victim_Age, COUNT(*) [No. of reportings]
FROM train
GROUP BY Victim_Age
ORDER BY [No. of reportings] DESC


SELECT Victim_Sex, COUNT(*) [No. of reportings]
FROM train
GROUP BY Victim_Sex
ORDER BY [No. of reportings] DESC


SELECT Victim_Descent, COUNT(*) [No. of reportings]
FROM train
GROUP BY Victim_Descent
ORDER BY [No. of reportings] DESC


SELECT Crime_Category, AVG(Victim_Age) [Avg victim age]
FROM train
GROUP BY Crime_Category


--4.PART BASED ANALYSIS

SELECT Part_1_2, [No. of reportings], ([No. of reportings]*100/(SELECT COUNT(*) FROM train)) [Reporting%]
FROM
(SELECT Part_1_2, COUNT(*) [No. of reportings]--, COUNT(*)/(SELECT COUNT(*) FROM train) [Reporting%]
FROM train
GROUP BY Part_1_2) y
GROUP BY Part_1_2, [No. of reportings]


--5.STATUS BASED ANALYSIS

SELECT Status, Status_Description, COUNT(*) [No. of reportings]
FROM train
GROUP BY Status, Status_Description
ORDER BY [No. of reportings] DESC

--TOP STATUS PER CRIME CATEGORY
SELECT Crime_Category, Status, Status_Description, [No. of reportings]
FROM
(SELECT Crime_Category, Status, Status_Description, COUNT(Status) [No. of reportings], 
       ROW_NUMBER() OVER (PARTITION BY Crime_Category ORDER BY COUNT(Status) DESC) [RANK]
FROM train
GROUP BY Crime_Category, Status, Status_Description
) X
WHERE RANK=1


--AGE SEGMENTS
SELECT Crime_Category, Victim_Sex, Victim_Age, 
	CASE WHEN Victim_Age BETWEEN 0 AND 5 THEN 'Infants' 
		WHEN Victim_Age BETWEEN 6 AND 17 THEN 'Children'
		WHEN Victim_Age BETWEEN 18 AND 30 THEN 'Young Adults'
		WHEN Victim_Age BETWEEN 31 AND 60 THEN 'Middle Aged'
		WHEN Victim_Age BETWEEN 61 AND 99 THEN 'Elderly'
		ELSE 'Unknown'
	END AS Age_Group
FROM train



--DELETING ROWS WITH -VE AGE
DELETE FROM train
WHERE Victim_Age<0


