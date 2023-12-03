/* Cleaning the data ----------------------------------------------------------------------------------------------------------------------------------------------------
Checking for duplicates ------------------------------------------------------------------------------- */
-- We can do this using Cartesian Product, basically a version of the table to itself, and selecting a big enough subset of columns to be as sure that it's an actual duplicate as we can.

DELETE t2 FROM gd_hr_data t1,
    gd_hr_data t2 
WHERE
    t1.EmployeeNumber < t2.EmployeeNumber
    AND (t1.age = t2.age
    AND t1.Department = t2.Department
    AND t1.PercentSalaryHike = t2.PercentSalaryHike);
-- There are 0 duplicates in this table, I checked in Excel because this column subset wouldn't be enough anyway-----------

-- Getting rid of redundant data within the BusinessTravel column --------------------------------------------------
-- checking which values there are-----------------
SELECT DISTINCT BusinessTravel
FROM gd_hr_data;
-- replacing the unnecessary parts of the strings -------------------------------------------------------
UPDATE gd_hr_data
SET BusinessTravel = REPLACE(BusinessTravel,"Travel_Rarely", "Rarely");

UPDATE gd_hr_data
SET BusinessTravel = REPLACE(BusinessTravel,"Travel_Frequently", "Frequently");
-- checking if our data is still intact ------------------------------------------------------------------
SELECT DISTINCT BusinessTravel
FROM gd_hr_data;

-- Checking the age column --------------------------------------------------------------------
SELECT DISTINCT age
FROM gd_hr_data
ORDER BY 1 ASC;
-- no child labor here!


/* General Statistics -----------------------------------------------------------------------------------------------------------------------------------------------
Overall attrition rate ------------------------------------------------------------------------------- */
