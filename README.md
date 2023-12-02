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
**Performance and compensation**:
- Do hikes in salary affect attrition?
- Which departments suffer from the most attrition?
- What about people who do overtime vs those who don't?
- Performance level?
**Management and career growth**:
- How long has been the employee in their current position without getting promoted?
- Do people who stay under the same manager for longer resign more often?
- Is work-life balance a factor?


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
- Set the data type for each column.
- Get rid of redundant and other useless columns like EmployeeCount, DailyRate, Over18Y, to name a few.
- The EmployeeHours column is useless too because every one in this business apparently works 80 hours. That alone counts for a lot of the attrition, I'd say.





