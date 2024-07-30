# HR-analysis
 An exploratory report of fictitious HR data meant to shed light on attrition rate, employee demographics, exploring probable drivers, and how to improve said rate.

 Access the report [here](https://app.powerbi.com/view?r=eyJrIjoiODljMTM1MjAtZTFjZi00N2Y3LWE1YjItNjg0MTgwNjJjYmNkIiwidCI6IjIzN2NkZmEwLWVmMWUtNDAxNS05ODRlLWI1NTM0YzhhNTZjYSJ9). 
 

# Goal
This project covers a fictitious dataset that covers HR data of a travel agency. Said agency is struggling with high employee attrition rate. 
The goal of this study is to analyze the company's employee attrition rate, identify the causes, and suggest solutions to improve the situation. All using our data!

In order to reach our goal, we want to answer the following questions using our data:


- Employee distribution and attrition rate by:
  - Age Groups.
  - Tenure Length.
  - Departments.
  - Gender.
  - Monthly Salary.
  - Salary Hikes.
  - Job Satisfaction.
  - Work Life Balance.
  - Overtime.
  - Commute Distance.
  - Travel Requiremnts.
- Overall attrition rate
- Average Job Satisfaction.
- Median Tenure Length in the company. I chose median because this is the only category out of the chosen set that can be affected by outliers.


  # Key Metrics:
  - The overall attrition rate is **17.81%**, out of the 713 employees in the survey, around 127 employees are terminated.
  - Average Job Satisfaction is 2.79 out of 4, where 1 is very dissatisfied and 4 is very satisfied.
  - Average Work Life Balance score is 2.8 out of 4, where 1 is very poor and 4 is very good. 
  
  - Median tenure length is 5 years.
  
  ## Demographics
  This page explores the demographic distributions in the company as well as attrition rate, by different categories such as age group, gender, etc.

  <img src="Assets\demographics.JPG" >

  ### Age Group:
  - Right off the bat,  we see a significant turnover rate of 43% among among employees that are early in their career at 43%. Note that they could be interns that didn't manage to land a full-time role, but it could also be the lack of growth opportunities.<br>
  
  - The 25-34 age bracket also suffers from considerable attrition at 21%. It's a popular age to start a family, so that might be a factor. <br>
  - Beyond that, the rest of the brackets suffer from relatively less attrition, as it stands between 10% and 13%.
  ### Departments:
    - Sales department suffers from the highest attrition at 21%, and R&D, despite having significantly more employees, has the lowest turnover rate at 16%.
    
      - Using the slicer at the top, we can notice that the sales department also struggles with significant attrition with people early in their career, which begs the theory that entry and associate level Sales positions are undercompensated.
  ### Gender
    - Men make the majority of employees within Green Destinations, with men being 62% of total workforce, and women being 38%.
      - But we notice that turnover rate is almost the same for both men and women.
    
  ### Tenure Length
    - As shown by the Age Group section, employees early in their career have the most turnover rate at 22.5%, over 10% higher than 6 years and more.
      - This is a telltale sign that many young people early in their career use GD as a stepping stone to gain experience and move on to Greener Destinations.

  ## Salaries
  This page explores the compensation of the employees, by monthly rate and salary Hikes.
  <img src="./assets/salaries.jpg">
  ### Monthly Rate
  - We notice that attrition is highest in the lowest and highest salary ranges, with 19% of the employees with salaries below 5K, and 23% of employees with salaries above 21K having left the company, with lower attrition in the ranges in between that remains high in the associate level salary.
  
    - This could mean that entry level, associate, and senior level salaries are below expectations for many employees.
  ### Salary Hikes
  - Attrition is high at 11% hike, and gradually gets lower as the hikes increase, but remains high on the way to senior salaries. With a spike at 15% hike to 22%, it bottoms out at 21% with 11% attrition. It then skyrockets to 28% attrition rate at the 22% hike, where salary is at senior to executive level. 
      - Again, it leads me to believe that both entry level, associate, and senior employees are dissatisfied with their salary hikes.

  ## Possible Drivers
  In this page we explore what I considered to be likely drivers behind the attrition, aside from what we've explored already.
  <img src="./assets/possfact.jpg">
  
  ### Job Satisfaction
  - Around 64% of employees are either satisfied or very satisfied.

  - Unsurprisingly, Very Dissatisfied employees suffer from the biggest attrition rate, at 26%. Their dissatisfaction can be attributed to multiple factors, such as salary, commute distance, and business travel.
  - What's interesting is that the satisfied group suffers from the second highest attrition rate at nearly 20%. This again leads me to think that these employees found better compensation and/or growth opportunities elsewhere, or were concerned about answering negatively to the survey, even.
  ### Commute Distance
  - As can be seen, the attrition rate among employees with commutes longer than 5KM skyrockets from 13% to 28%. It's assumed that the reason it drops back to 21% is that employees at that point likely have private transportation.
  - The second figure is a regression plot that shows positive correlation between attrition rate and commute distance.
    
    - So, it's safe to assume that commute distance is a large factor in attrition rate and is worth looking at.
  ### Travel Requirements
    - The pie chart shows that most employees in GD travel at least rarely, with 18% having to travel frequently.
    - The aforementioned group has considerably higher attrition than the group that travels rarely at 27% and 16% respectively.

    - Meanwhile, attrition is much lower among employees that don't travel, at 11%.
      - Travel requirements are definitely a large factor in employee attrition.
      

  ## Recommendations:
  - **Assuring the employees that the company is dedicated to improving the situation in Green Destinations, and showing willingness to address any complaints.**
  - **Improving communication between management and employees and taking complaints into consideration.**
  - **Conducting exit interviews for the employees that leave the company, and asking for their feedback.**

  ### Salary and Compensation
    - We have determined a few groups that struggle with attrition likely due to low salary: entry level, associate level, seniors, employees in the sales department, and employees that do overtime. 

  - It is likely that these employees don't feel adequately compensated.
    - **It would be wise to re-evaluate the compensations and benefits of the employees in these groups, and potentially reach a mutually beneficial agreement.**
  ### Turnover early in career or tenure
  - In the demographics page, we found that people early in their careers (ages 18 to 24) and in their tenure (below 5 years long) are the most likely to leave.
  
  - This could be due to lack of growth opportunities, vague career roadmap, and/or poor onboarding, 
    - **It would be beneficial to provide new employees with growth opportunities and a clear career roadmap, as well as improving onboarding, offering mentorship and training programs.**
  ### Job Satisfaction
  - The highest category in terms of attrition is, of course, very dissatisfied employees, but the second highest is satisfied employees, which can lead to theory that the survey results are somewhat questionable. 
    
    - **Aside from that, the issue of salary is still hanging, and even a satisfied employee would leave for a place with better compensation.**
  ### Commute Distance
  - It seems this one is one of the biggest contributors to attrition, there's a direct correlation between attrition rate and commute distance.
    
    - **It can be addressed by providing more remote/hybrid work opportunities, relocation packages, co-financing transportation costs, and making the workplace more attractive with amenities like a gym.**



  ### Travel Requirements
  - As we have discovered, travel requirements is also quite a large factor in attrition rate, as it is an obvious cause of stress and fatigue for employees.
    
    - **It would help to making travel more comfortable by improving travel packages and increasing allowances, study positions that require travel and determine if it is absolutely necessary, and increase the time employees get between each trip to combat fatigue.**

# Results
With this analysis, we have helped Green Destinations do the following:
- Gain a better understanding on the attrition phenomenon in the company and how bad the situation is.
- Gathered insights and identified the biggest factors in the increase of attrition rate.

- Gave actionable recommendations to mitigate and ideally eradicate the phenomenon, and thus improve the company and contribute to its growth massively. I love being a data analyst.



# Resources and tools used
The dataset can be acquired [here](https://databudd.com/s/greendestination.csv)

- Excel for preliminary examination.
- Notepad++ and its plugin CSV Lint for preprocessing.
- MySQL Workbench for setting up a database and querying.
- Power BI for visualization.
- PowerPoint for reporting.

# Building the report
## Preliminary examination

We'll use CSV Lint to convert the CSV file into a .sql script to load the data practically instantly.

## Importing and Cleaning:
- We use the SQL script to import the data into a new database in MySQL Workbench.
  - The "database" is one really wide column, terrible for performance and loaded with redundant columns
- I decided to delete any records that have different but are equal in a subset in columns, but I couldn't decide what subset of columns to use to determine whether the record is a duplicate or not, so I used Excel to check records based on all the columns, and showed that there were no duplicates.

- Example of this method using three columns as the criteria for considering the record as a duplicate (not enough by the way):
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
  We'll simply **UPDATE** the column using a **REPLACE()** statement as you can see, we'll have to repeat the process for the other two.
  ```
  UPDATE gd_hr_data
  SET BusinessTravel = REPLACE(BusinessTravel,"Travel_Frequently", "Frequently");
  ```


- We check the rest of the data using Excel because we have 21 columns. No need for any joins, but it's still quite annoying, heh.

### Creating the database:
- We query a set of columns for each table: demographics, salaries, and possible drivers.
- Import the tables into Power BI using connectors.

### General statistics, for our cards:
  - **Simple count of employees** with **COUNT()**
  - **Overall Attrition rate:** The key to this is a technique called **Case Pivoting**: We turn the "Yes" or "No" answers into columns and aggregate, by a mix of a **COUNT()** function and a **CASE** statement.
    ```
    SELECT 
		  COUNT(CASE WHEN Attrition = "Yes" THEN 1 ELSE NULL END)/COUNT(CASE WHEN Attrition = "No" THEN 1 ELSE NULL END) AS 'Attrition Rate'
    FROM gd_hr_data
  The overall attrition rate is **17.18%**, it's a hefty percentage, it's good that management decided to get on this problem.
  - **Average job satisfaction level:** Simple AVG function.
  - **Median Tenure Length:** I aggregated the field in the Build pane into a median to avoid outlers.
  - **Employee Age Distribution:** The count of employees grouped by age group.
    - **Monthly Rate by Age group:** For this we'll use a **CASE** statement to divide the ages into groups. I decided to add this as a column to our table because we'll reuse it often. It's a two-step process, we add the column using **ALTER TABLE** then use **UPDATE** with the case values. <br>
  This turned out to be completely unnecessary because both Tableau and Power BI allow you to bin easily with a GUI to boot, in the data groups button on the ribbon.
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
I scrapped this columns and switched to Data Groups in Power BI instead.
## Visualization:
  
### Demographics:
  - **Age Groups:** Histogram that shows the number of employees along with a line that shows the average attrition rate for each bin (interval).
  - **Departments:** Pie chart for employee distribution for the departments, and a simple bar chart for attrition rates.
  
  - **Gender**: Pie chart for employee distribution for the genders, and a simple bar chart for attrition rates.
  - **Tenure Length**: Histogram that shows the number of employees along with a line that shows the average attrition rate for each bin (interval).
  
### Salaries:
  - **Monthly Rate:** Histogram that shows the number of employees along with a line that shows the average attrition rate for each bin (interval).
  - **Salary Hikes**: Decided to go with a column chart to show each percentile rather than a histogram, the line is still there.

### Possible Drivers
 - **Overtime**: Pie chart for employee distribution for whether they do overtime or not, and a simple bar chart for attrition rates.
 
 - **Job Satisfaction**: Pie chart for employee distribution for each level (1 through 4, 1 being very dissatisfied), and a simple bar chart for attrition rates.
 - **Commute Distance**: Histogram that shows the number of employees per distance interval along with a line that shows the average attrition rate for each interval.
 - **Travel Requirements**: Pie chart for employee distribution for each level, and a simple bar chart for attrition rates.

