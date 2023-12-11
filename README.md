# HR-analysis
 An analytical report of fictitious HR data meant to shed light on turnover rates, the causes, patterns, and how to improve said rate.

# Goal
This project covers a fictitious dataset that covers HR data of a travel agency. The agency is struggling with high employee attrition rate. 
The goal of this study is to analyze the company's employee attrition rate, identify the causes, and suggest solutions to improve the situation. All using our data!
Note that this project is restricted to the analysis side of things, so no predictive stuff here.

In order to reach our goal, we want to answer the following questions using our data:

**General statistics**:
- Number of employees.
- Calculate the overall attrition rate?
- Average Job Satisfaction.
- Average Tenure in the company.
- Distribution of Employees by age.
- Distribution of employees by Years of Service.
- Distribution of employees by Commute Distance.
- Distribution of employees by Monthly Rate (trimmed).

**Employee Information**:
- Is the commute distance a factor? (attrition vs commute distance)
- Are people who were in a lot of companies at higher risk of attrition?

**Performance and compensation**:
  - Average monthly rate by Age Group.
  - Do hikes in salary affect attrition?
  - Which departments suffer from the most attrition?
  - What about people who do overtime vs those who don't?

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

- I decided to use **Cartesian Product** self join, but I couldn't decide what subset of columns to use to determine whether the record is a duplicate or not, so I used Excel to check records based on all the columns, and showed that there were no duplicates.
    I knew that the EmployeeNumber column contained no duplicates since I set it as a primary key, but I wanted to be sure, maybe someone put in the same employee twice. <br>
- Example of the Cartesian product query using three columns as the criteria for considering the record as a duplicate (not enough by the way):
    ```
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

- We check the rest of the data using Excel because we have 21 columns. No need for any joins, but it's still quite annoying, heh.


### General statistics, for our cards:
  - **Simple count of employees** with **COUNT()**
  - **Overall Attrition rate:** The key to this is a technique called **Case Pivoting**: We turn the "Yes" or "No" answers into columns and aggregate, by a mix of a **COUNT()** function and a **CASE** statement.
    ```
    SELECT 
		  COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(CASE WHEN Attrition = "No" THEN 1 ELSE NULL END) AS 'Attrition Rate'
    FROM gd_hr_data
  The overall attrition rate is **19.22%**, it's a hefty percentage, it's good that management decided to get on this problem.
  - **Average job satisfaction level:** Simple AVG function.
  - **Average Tenure Length:** Used a simple **AVERAGE()** DAX function here.
  - **Employee Age Distribution:** The count of employees grouped by age group.
    - **Monthly Rate by Age group:** For this we'll use a **CASE** statement to divide the ages into groups. I decided to add this as a column to our table because we'll reuse it often. It's a two step process, we add the column using **ALTER TABLE** then use **UPDATE** with the case values. <br>
  This turned out to be completely unnecessary because both Tableau and Power BI allow you to bin easily with a GUI to boot, but hey you learn more everyday, right?
  <br>

    ````
    ALTER TABLE gd_hr_data
    ADD COLUMN age_group VARCHAR(5);

    UPDATE gd_hr_data
    SET age_group = (CASE WHEN gd_hr_data.age BETWEEN 18 AND 25 THEN '18-25'
          WHEN gd_hr_data.age BETWEEN 26 AND 35 THEN '26-31'
          WHEN gd_hr_data.age BETWEEN 36 AND 45 THEN '36-45'
          WHEN gd_hr_data.age BETWEEN 46 AND 55 THEN '46-55'
          WHEN gd_hr_data.age BETWEEN 56 AND 59 THEN '56-59'
          ELSE '60+'
    END);
  The average is skewed quite badly due to outliers. After having a quick look, I noticed that there are employees with over 20 years in the company and are relatively high level, but still get paid very little. The possibilities are:
    - The employees work only ~50 hours per week, which seems silly to me.
    - This is a data entry error, but it's quite common, there are 171 employees who get paid less than 5000.
  So, I tried a trimmed mean by setting lower and upper limits in my query, I set a condition that the monthly rate must be between 5000 and 10000, and noticed the same results mostly.

  I'm sticking with the trimmed mean approach, it just doesn't make sense to me that a sales representative with 1 year of experience is 23K+ while a Senior Sales Executive with 20 years of experience is paid 1/10 of that, because these non-sensical values are always extremely big. So, since it's not possible to estimate the real salary of these employees, I decided to limit the monthly rate between 5000 and 17000 to keep a big number of records. The results seem the same whether I expand or narrow the window. 
  
  The conclusion is that older employees don't see big pay raises in comparison to young professionals. To see if this affects attrition, we'll calculate attrition rate by age group as well.

  At 35.77%, the 18-25 suffers from massive attrition, but it's most likely due to the low number of employees. The 26-35 slice requires more attention however, as it has a rate of 19.14%, at 6 times the number of employees in the 18-25 slice.
  
### Employee Information:
  - **Commute Distance:** We want a scatter plot here, so there's no need to query.
  - **Number of Previous Companies:** We just count the number of employees and aggregate it by the current criterion. We'll reuse this code a few times.
    ````
    SELECT
	    numcompaniesworked,
	    COUNT(*) as num_emp,
      COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(EmployeeNumber) AS atr_rate
    FROM gd_hr_data
    GROUP BY 1
    ORDER BY 1;

  It seems the rate is quite high for employees who only worked in one company before, 18.81% of 521.

### Performance and compensation:
  - **Attrition rate by Tenure:** See visualization section.


 - **Salary Hikes**: See visualization section.

 - **Departments**: For the technique, see the code right above. <br>
Sales and R&D departments require the most attention, at 13.84% of 961 employees and 20.63% of 446 employees, respectively.
 
 - **Overtime**: For the technique, see the code right above. <br>
 30.53% of the employees that do overtime have terminated, which is quite alarming.

### Management and Career Growth
 - **Number of Previous Companies**: For the technique, see the code right above. <br>
 It seems the turnover rate is highest for people whose first company is Green Destinations, at 18.93% of 581 employees
 - **Years in Position since last promotion:** See visualization section.
 
 - **Years under current manager:** For the technique, see the code right above.
Unsurprisingly, it's highest in the first few years, especially the first at 32.32% of 263 employees, but later down the line the attrition rate becomes a zero.
- **Work-Life Balance**: See visualization section.
Seems even across the board, doesn't seem to be a factor, plus more employees are satisfied about the work-life balance than those that aren't, always a great thing.
# Visualization:
After an hour of fiddling around with the ODBC connector and adding a password to my local MySQL server and forgetting it five seconds later, I finally figured out how to create Power BI to MySQL Workbench. I will use views to import the data instead of the unbelievable pain in the neck that is exporting to CSV file! **a whole new wooooorld** I blame Colt for not teaching me this.

I also started freaking out as to whether I should call it a histogram or a bar chart. I eventually decided to stick to the simple rule of thumb of "bars for categorical data, and histograms for quantitative data. But isn't a bin *technically* a category? I can imagine some scientists in the 1800s getting into a fist fight over this.

The hardest part as usual was the color scheme. Always a pain! Lord forgive me for I used the Disco Elysium palette again.


  - **Number of Employees:** A card visual will do!
  - **Overall Attrition Rate:** Ditto.
  - **Age Distribution of Employees:** The first of many histograms in our dashboard. The age column has already been binned in SQL, so it's a matter of creating a bar chart, sorting the X-axis by the bins, and reducing the spacing between the bars, creating a histogram! To this, and most of the other distributions, I also added a line chart with the attrition rate.
  - **Tenure Distribution of Employees:** The YearsInCompany column will be binned in Power BI, but the process is largely the same as previously.
  - **Distribution of employees by Monthly Rate (trimmed)**: Ditto.
  - **Commute Distance**: Ditto, but I also added a scatter plot, which shows a positive correlation between commute distance and attrition rate. More on that in the next section.
  - **Departments**: Just a simple pie chart, the size of the slices is based on the employee count. I also replaced Human Resources and Research & Development with HR and R&D, respectively, to save on valuable space.
  - **Overtime**: A simple stacked bar chart did the trick.
  - **Work-Life Balance**: Another bar and line chart. If it's not broken, don't fix it!
  # Insights:
  - The overall attrition rate is **16.12%**, out of the 1470 employees in the survey, around 237 employees are terminated.
  - 
  - The 26-35 age group seems to suffer from the most attrition at **19.1%** of the group having been terminated.
  - A massive amount of employees leaves the company within the first five years of their tenure at **22.6%** overall.
  - The employee distribution by salary seems uniform. The attrition fluctuates within 5% of the highest and lowest values. It seems that Monthly Salary isn't a big factor in the attrition rate.
  - 








