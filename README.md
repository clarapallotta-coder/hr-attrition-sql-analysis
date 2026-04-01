# hr-attrition-sql-analysis
SQL analysis of employee attrition identifying key drivers such as tenure, income, and satisfaction, with a focus on risk vs overall impact.
 HR Attrition Analysis (SQL Project)

## Overview
This project analyzes employee attrition using SQL, focusing on identifying key drivers behind employee turnover.

The analysis explores how different factors such as tenure, income, and job satisfaction influence attrition rates.


## Objectives
- Calculate overall attrition rate
- Segment employees by:
  - Tenure
  - Income
  - Job Satisfaction
- Compare attrition rates across segments
- Identify high-risk groups
- Distinguish between **risk (attrition rate)** and **impact (share of total attrition)**


## Tools
- SQL (SQLite)
  

## Key Insights

- Overall attrition rate is ~16%

- **Tenure is the strongest predictor of risk**
  - Employees with ≤2 years: ~30% attrition
  - Employees with higher tenure: ~12%

- **Income is the largest contributor to total attrition**
  - Low income employees account for ~9.3% of total attrition

- **Job satisfaction has a moderate impact**
  - Low satisfaction: ~20% attrition
  - High satisfaction: ~14%

- High-risk profiles (low tenure + low income + low satisfaction) exist but represent a smaller portion of the workforce


## Key Takeaway

Attrition is not driven by a single profile, but by multiple independent factors.

While low-tenure employees show the highest risk, low-income employees contribute the most to overall attrition due to their larger population size.


## 📂 Dataset
IBM HR Analytics Employee Attrition Dataset (Kaggle)
