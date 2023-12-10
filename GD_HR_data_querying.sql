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
SELECT DISTINCT
    BusinessTravel
FROM
    gd_hr_data;
-- replacing the unnecessary parts of the strings -------------------------------------------------------
UPDATE gd_hr_data 
SET 
    BusinessTravel = REPLACE(BusinessTravel,
        'Travel_Rarely',
        'Rarely');

UPDATE gd_hr_data 
SET 
    BusinessTravel = REPLACE(BusinessTravel,
        'Travel_Frequently',
        'Frequently');
-- checking if our data is still intact ------------------------------------------------------------------
SELECT DISTINCT 
	BusinessTravel
FROM 
	gd_hr_data;

-- Checking the age column --------------------------------------------------------------------
SELECT DISTINCT
    age
FROM
    gd_hr_data
ORDER BY 1 ASC;
-- no child labor here!


/* General Statistics -----------------------------------------------------------------------------------------------------------------------------------------------*/
-- Number of employees: ----------------------------------------------------------------------------------

CREATE VIEW num_employee as
SELECT 
	COUNT(*) AS num_employees
FROM 
	gd_hr_data;

-- Overall attrition rate: -------------------------------------------------------------------------------
-- We use a technique called Case Pivoting------------------------------
CREATE VIEW attrition_rate AS
SELECT 
		COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM 
	gd_hr_data;

-- 16.12% is quite a high number, the CEO has done good to start efforts to curb this problem

/* Average monthly rate by age group ---------------------------------------------------------------------
Adding a new column for age group to save time later */

ALTER TABLE gd_hr_data -- adding the column
ADD COLUMN age_group VARCHAR(5);

UPDATE gd_hr_data -- populating the column
SET age_group = (CASE WHEN gd_hr_data.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN gd_hr_data.age BETWEEN 26 AND 35 THEN '26-31'
        WHEN gd_hr_data.age BETWEEN 36 AND 45 THEN '36-45'
        WHEN gd_hr_data.age BETWEEN 46 AND 55 THEN '46-55'
        WHEN gd_hr_data.age BETWEEN 56 AND 59 THEN '56-59'
        ELSE '60+'
	END);
-- This column wasn't need because PBI can bin oopa

-- Average Job Satisfaction -------------------------------------------------------------------------------
CREATE VIEW job_satis AS
SELECT
	AVG(JobSatisfaction) AS avg_job_satis
FROM gd_hr_data;

-- Average Monthly Rate-------------------------------------------------------------------------------------
CREATE VIEW avg_rate AS
SELECT 
	AVG(monthlyrate) as avg_monthly_rate
FROM gd_hr_data;

-- Employee tenure distribution -------------------------------------------------------------------------
CREATE VIEW tenure_dist AS
SELECT
	YearsAtCompany,
	COUNT(*) AS num_emp,
	COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate

FROM gd_hr_data
GROUP BY 1
ORDER BY 1;

-- Attrition vs Monthly Rate --------------------------------------------------------------------
CREATE VIEW monthly_rate_att AS
SELECT
	monthlyrate,
	COUNT(*) AS num_emp,
	COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate

FROM gd_hr_data
WHERE monthlyrate BETWEEN 5000 AND 20000
GROUP BY 1
ORDER BY 1;


-- Attrition rate by Age Group ---------------------------------------------
CREATE VIEW attrition_age_dist AS
SELECT 
		age_group,
        COUNT(*) as num_emp,
		COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM gd_hr_data
GROUP BY 1
ORDER BY 1;
-- The 18-25 group suffers from massive attrition rates but that is likely due to the small number of employees that fall in that category, the 26-31 slice requires the most attention, as it is 19.14% of 606 employees.

-- Attrtion by number of companies the employee has been in -------------------------------------------------------------
CREATE VIEW att_rate_num_company AS
SELECT
	numcompaniesworked,
	COUNT(*) as num_emp,
    COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM gd_hr_data
GROUP BY 1
ORDER BY 1;
-- It seems the rate is quite high for employees who only worked in one company before, 18.81% of 521 ---------------------------------------

-- Attrition and salary by Department ----------------------------------------------------------------------------------------------
CREATE VIEW att_rate_dep AS
SELECT 
	Department,
    ROUND(AVG(MonthlyRate),2) AS avg_salary,
    COUNT(*) as num_emp,
    COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM 
	gd_hr_data
GROUP BY 1
ORDER BY 1;
-- Sales and R&D departments require the most attention, at 13.84% of 961 employees and 20.63% of 446 employees, respectively.

-- Attrition Rate by Commute Distance --------------------------------------------------------------------------------------
CREATE VIEW att_rate_dist AS
SELECT 
	DistanceFromHome,
    COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM 
	gd_hr_data
GROUP BY 1
ORDER BY 1;

-- Overtime -----------------------------------------
CREATE VIEW att_rate_overtime AS
SELECT
	overtime,
	COUNT(*) as num_emp,
    COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM 
	gd_hr_data
GROUP BY 1
ORDER BY 1;
-- 30.53% of the employees that do overtime have terminated, which is quite alarming. -----------------------------------------

-- Years in current position before getting promoted  ------------------------------------------
CREATE VIEW career_growth AS
SELECT
	YearsSinceLastPromotion,
	COUNT(*) as num_emp,
    COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM 
	gd_hr_data
GROUP BY 1
ORDER BY 1;
-- It seems the turnover rate is highest for people whose first company is Green Destinations, at 18.93% of 581 employees --------------------------------

-- Years under current manager ----------------------------------------------------------------
CREATE VIEW years_manager AS
SELECT
	Yearswithcurrmanager,
	COUNT(*) as num_emp,
    COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM 
	gd_hr_data
GROUP BY 1
ORDER BY 1;
-- Unsurprisingly, it's highest in the first few years, especially the first at 32.32% of 263 employees, but later down the line the attrition rate becomes a zero. ---------

-- Work-life balance ------------------------------------------------
CREATE VIEW wl_balance AS
SELECT
	worklifebalance,
	COUNT(*) as num_emp,
    COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
FROM 
	gd_hr_data
GROUP BY 1
ORDER BY 1;
-- Seems even across the board, doesn't seem to be a factor, plus more employees are satisfied about the work-life balance than those that aren't, always a great thing -----------------------------------------------------