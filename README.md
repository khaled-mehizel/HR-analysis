# HR-analysis
 An analytical report of fictitious HR data meant to shed light on turnover rates, the causes, patterns, and how to improve said rate.

# Goal
This project covers a fictitious dataset that covers HR data of a travel agency. The agency is struggling with high employee attrition rate. 
The goal of this study is to analyze the company's employee attrition rate, identify the causes, and suggest solutions to improve the situation. All using our data!
Note that this project is restricted to the analysis side of things, so no predictive stuff here.

In order to reach our goal, we want to answer the following questions using our data:
**Dashboard, general statistics**:
- Number of employees
- Calculate the overall attrition rate?
- Average monthly income by Age Group
- Attrition Rate by Age Group
- Count of employees by Years of Service
**Employee Information**:
- Which ages, salary groups, years of service, education, marital status groups contribute the most to the attrition rate?
- Is the commute distance a factor?
- Do senior employees have a higher attrition rate as well?
- Are people who were in a lot of companies at higher risk of attrition?
**Performance and compensation**:
- Do hikes in salary affect attrition?
- Which departments suffer from the most attrition?
- What about people who do overtime vs those who don't?
- Performance level?
**Management and career growth**:
- How long has been the employee in their current position without getting promoted?
- Do people who stay under the same manager for longer resign more often?
- Is current work-life balance a factor?


# Resources and tools used
The dataset can be acquired [here](https://databudd.com/s/greendestination.csv)

- Excel for preliminary examination.
- Notepad++ and its plugin CSV Lint for preprocessing.
- MySQL Workbench for cleaning and querying.
- Power BI for visualization.
- PowerPoint for reporting.

# Preliminary examination
The dataset is composed of 

We'll use CSV Lint to do the following:
- Set the data type for each column, down-casting them into small types to save improve performance by reducing overhead storage, and CSV Lint bases this limit on the longest string in the column, so there's no risk of truncating any data.
- Get rid of redundant and other useless columns like EmployeeCount, DailyRate, Over18Y, to name a few.
- The EmployeeHours column is useless too because every one in this business apparently works 80 hours. That alone counts for a lot of the attrition, I'd say.
- Convert the CSV into an SQL script to allow in-line loading, creating the database in Workbench itself is only a few seconds instead of the hour or so the wizard takes.

# Importing and Cleaning:
- We use the SQL script to import the data into a new database in MySQL Workbench.
- First, we must clean the data:

  - I decided to use **Cartesian Product** self join, but I couldn't decide what subset of columns to use to determine whether the record is a duplicate or not, so I used Excel to check records based on all the columns, and showed that there were no duplicates.
    I knew that the EmployeeNumber column contained no duplicates since I set it as a primary key, but I wanted to be sure, maybe someone put in the same employee twice. <br>
  Example of the Cartesian product query using three columns as the criteria for considering the record as a duplicate (not enough by the way):
    ``````
    DELETE t2 FROM gd_hr_data t1,
      gd_hr_data t2 
    WHERE
      t1.EmployeeNumber < t2.EmployeeNumber
      AND (t1.age = t2.age
      AND t1.Department = t2.Department
      AND t1.PercentSalaryHike = t2.PercentSalaryHike);
- Next, we must address the Travel Requirements column, its records are filled with redundant "travel_" strings, we must trim those. First, we'll look at the values using this simple query:
  ```
  SELECT DISTINCT BusinessTravel
  FROM gd_hr_data;
  ```
  We'll simply **UPDATE** the column using a **REPLACE()** statement as you can see:
  ```
  UPDATE gd_hr_data
  SET BusinessTravel = REPLACE(BusinessTravel,"Travel_Frequently", "Frequently");
  ```
  It's not as dynamic as I'd like, but it's readable, and reliable, which are the most important aspects in code.

- We check the rest of the data using Excel because we have 21 columns.


-  is to do the general statistics, for our cards:
  - Overall Attrition rate: A simple query that is just dividing the count of terminated employees by those who aren't!





