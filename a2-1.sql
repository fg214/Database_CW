-- Answer to the 2nd Database Assignment 2018/19
--
-- 198934
-- Please insert your candidate number in the line above.
-- Do NOT remove ANY lines of this template.


-- In each section below put your answer in a new line 
-- BELOW the corresponding comment.
-- Use ONE SQL statement ONLY per question.
-- If you don’t answer a question just leave 
-- the corresponding space blank. 
-- Anything that does not run in SQL you MUST put in comments.
-- Your code should never throw a syntax error.
-- Questions with syntax errors will receive zero marks.

-- DO NOT REMOVE ANY LINE FROM THIS FILE.

-- START OF ASSIGNMENT CODE


-- @@01
CREATE TABLE MoSpo_HallOfFame (

hoFdriverId INTEGER UNSIGNED,
hoFyear YEAR, 
hoFSeries ENUM('BritishGT', 'FORMULA1', 'FORMULAE', 'SuperGT'),
hoFImage VARCHAR(200) NULL ,
hoFWins TINYINT(2) UNSIGNED DEFAULT 0, 
hoFBestRaceName VARCHAR(30),
hoFBestRaceDate DATE, 

PRIMARY KEY(hoFdriverId, hoFYear),
CONSTRAINT FK_DrId FOREIGN KEY(hoFdriverId) REFERENCES MoSpo_Driver(driverId) ON DELETE CASCADE,
CONSTRAINT FK_RN_RD FOREIGN KEY(hoFBestRaceName, hofBestRaceDate) REFERENCES MoSpo_Race(raceName, raceDate) ON DELETE SET NULL
);
 
-- @@02

ALTER TABLE driverWeight 
	ADD driverWeight DOUBLE(3,1),
	

-- @@03
UPDATE MoSpo_RacingTeam
SET 
	teamPostcode = 'HP135PN'
WHERE 
	teamName = 'Beechdean MotorSport'


-- @@04

-- Latin1_Genral_CI_AS = CASE INSENSITIVE
-- Latin1_General_CS_AS = CASE SENSITIVE 

-- SET driverFirstName  = UPPER(driverFirstName)
-- WHERE driverFirstName <> UPPER(driverFirstName) -- COLLATE Latin1_General_CS_AS

-- UPDATE MoSpo_Driver
-- SET driverLastName = UPPER(driverLastName)
-- WHERE driverLastName <> UPPER(driverLastName) -- COLLATE Latin1_General_CS_AS


DELETE FROM MoSpo_Driver WHERE DriverLastName = 'Senna' AND DriverFirstName = 'Ayrton';


-- @@05

SELECT COUNT(teamName) AS numberTeams 
FROM MoSpo_RacingTeam
 

-- @@06

SELECT driverId, CONCAT(LEFT(driverFirstName, 1), ' ', driverFirstname) AS driverName, driverDOB FROM MoSpo_Driver WHERE LEFT(driverLastname, 1) = LEFT(driverFirstname, 1);
-- driverName = CONCAT(LEFT(driverFirstName, 1) AND LEFT(driverLastName)
-- CREATE VIEW 

-- @@07
SELECT driverTeam AS teamName,  COUNT(*) AS numberOfDriver 
FROM MoSpo_Driver
GROUP BY driverTeam
HAVING COUNT(numberOfDriver) > 1;

-- @@08
SELECT lapInfoRaceName AS raceName, lapInfoRaceDate AS raceDate, MIN(lapInfoTime) AS lapTime
FROM MoSpo_LapInfo
GROUP BY lapInfoRaceName, lapInfoRaceDate;
-- HAVING COUNT()

-- @@09
SELECT raceName, SUM(yearCount)/COUNT(raceName) as avgStops from  
(SELECT pitstopRaceName as raceName, YEAR(pitstopRaceDate) as raceYear, COUNT(*) as yearCount FROM MoSpo_PitStop 
group by pitstopRaceName, raceYear) as t group by raceName;

-- SELECT pitstopRaceName, pitstopRaceDate, YEAR(pitstopRaceDate) as year, COUNT(*) as totalPitStop FROM MoSpo_PitStop GROUP BY YEAR(pitstopRaceDate)

-- @@10
SELECT DISTINCT carMake 
FROM MoSpo_Car
JOIN MoSpo_RaceEntry ON carId = raceEntryCarId 
-- race entry on lap info
-- DATE, ID, AND NAME
JOIN MoSpo_LapInfo ON MoSpo_RaceEntry.raceEntryRaceName = MoSpo_LapInfo.lapInfoRaceName AND MoSpo_RaceEntry.raceEntryRaceDate = lapInfoRaceDate 
WHERE MoSpo_LapInfo.lapInfoCompleted = 0 AND YEAR(raceEntryRaceDate) =2018;
-- @@11


-- SELECT *, COUNT(MoSpo_PitStop.pitstopRaceNumber) FROM MoSpo_PitStop LEFT JOIN MoSpo_Race on MoSpo_PitStop.pitstopRaceName = MoSpo_Race.raceName GROUP BY pitstopRaceName , pitstopRaceDate;

SELECT raceName, raceDate, IFNULL(pitstops.counter, 0) FROM MoSpo_Race LEFT JOIN (
	SELECT *, COUNT(pitstopRaceName) AS counter FROM MoSpo_PitStop GROUP BY pitstopRaceName , pitstopRaceDate
) AS pitstops ON pitstops.pitstopRaceName = raceName GROUP BY raceName , raceDate;

-- @@12

-- ID, LAST NAME

SELECT driverId, driverLastname AS driverLastName FROM MoSpo_Driver LEFT JOIN (
	SELECT lapInfoRaceName, lapInfoRaceDate, races.raceEntryRaceName, races.raceEntryRaceDate, races.raceEntryDriverId, MoSpo_Driver.driverLastname as lastN FROM MoSpo_LapInfo LEFT JOIN (
	SELECT raceEntryRaceName, raceEntryRaceDate, raceEntryDriverId FROM MoSpo_RaceEntry
) AS races ON races.raceEntryRaceName = MoSpo_LapInfo.lapInfoRaceName
  AND races.raceEntryRaceDate = MoSpo_LapInfo.lapInfoRaceDate
  LEFT JOIN MoSpo_Driver ON raceEntryDriverId = MoSpo_Driver.driverId
  WHERE lapInfoCompleted = 0 GROUP BY lapInfoRaceName, lapInfoRaceDate	
) as retired ON driverLastname = retired.lastN WHERE lastN IS NULL GROUP BY driverLastname







-- @@13


-- Do not write any DELIMITER command in the submission.
-- For Q14 OMIT the termination symbol at the end of your 
-- function declaration


-- @@14

 
 

-- END OF ASSIGNMENT CODE
