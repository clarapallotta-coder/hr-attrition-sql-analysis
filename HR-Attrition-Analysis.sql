-- HR Attrition Analysis
-- Author: Clara Pallotta
-- Goal: Identify key drivers of attrition




-- HACER INT LOS DATOS QUE NOS INTERESAN 
CREATE TABLE hr_finale AS
SELECT 
   CAST(TRIM(Age) AS INTEGER) AS Age,
    Attrition,
    Department,
    JobRole,
    CAST(TRIM(MonthlyIncome) AS INTEGER) AS MonthlyIncome,
    CAST(TRIM(JobSatisfaction) AS INTEGER) AS JobSatisfaction,
    CAST(TRIM(YearsAtCompany) AS INTEGER) AS YearsAtCompany
FROM hr_int;

--chequeamos que hayan quedado como ints
SELECT 
    YearsAtCompany,
    typeof(YearsAtCompany)
FROM hr_finale
LIMIT 10;


SELECT 
    MonthlyIncome,
    typeof(MonthlyIncome)
FROM hr_finale
LIMIT 10;


SELECT 
    JobSatisfaction,
    typeof(JobSatisfaction)
FROM hr_finale
LIMIT 10;

-- ACA YA CONVERTI EN INT A TODOS LOS NUMEROS QUE NECESITO

-- Calculo attrition rate total
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS attrition_rate
FROM hr_finale;


-- attrition distribution
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS attrition_rate
FROM hr_finale
GROUP BY Department
ORDER BY attrition_rate DESC;





--clasificacion satisfaction
SELECT 
    CASE 
        WHEN JobSatisfaction <= 2 THEN 'Low Satisfaction'
        ELSE 'High Satisfaction'
    END AS satisfaction_group,
    COUNT(*) AS total_employees,
    COUNT(*) * 1.0 / (SELECT COUNT(*) FROM hr_int) AS percentage
FROM hr_finale
GROUP BY satisfaction_group;



-- clasificacion antiguedad
SELECT 
    CASE 
        WHEN YearsAtCompany <= 2 THEN 'Low Tenure'
        ELSE 'High Tenure'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    COUNT(*) * 1.0 / (SELECT COUNT(*) FROM hr_int) AS percentage
FROM hr_int
GROUP BY tenure_group;



--clasificacion income
SELECT 
    CASE 
        WHEN MonthlyIncome < 4000 THEN 'Low Income'
        WHEN MonthlyIncome BETWEEN 4000 AND 9000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_group,
    COUNT(*) AS total_employees,
    COUNT(*) * 1.0 / (SELECT COUNT(*) FROM hr_int) AS percentage
FROM hr_int
GROUP BY income_group
ORDER BY percentage DESC;









-- attrition por grupo de satisfacción
SELECT 
    CASE 
        WHEN CAST(JobSatisfaction AS INTEGER) <= 2 THEN 'Low Satisfaction'
        ELSE 'High Satisfaction'
    END AS satisfaction_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS attrition_rate
FROM hr_int
GROUP BY satisfaction_group
ORDER BY attrition_rate DESC;


-- attrition por grupo de antigüedad
SELECT 
    CASE 
        WHEN YearsAtCompany <= 2 THEN 'Low Tenure'
        ELSE 'High Tenure'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS attrition_rate
FROM hr_int
GROUP BY tenure_group
ORDER BY attrition_rate DESC;


-- attrition por grupo de income
SELECT 
    CASE 
        WHEN MonthlyIncome < 4000 THEN 'Low Income'
        WHEN MonthlyIncome BETWEEN 4000 AND 9000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS attrition_rate
FROM hr_int
GROUP BY income_group
ORDER BY attrition_rate DESC;












--porcentaje sobre el total de empleados, que son low satisfaction
SELECT 
    SUM(CASE WHEN CAST(JobSatisfaction AS INTEGER) <= 2 THEN 1 ELSE 0 END) * 1.0 
    / COUNT(*) AS pct_low_satisfaction
FROM hr_int;


--porcentaje sobre el total de empleados, que son low antiguedad
SELECT 
    SUM(CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END) * 1.0 
    / COUNT(*) AS pct_low_tenure
FROM hr_int;

--porcentaje sobre el total de empleados, que son low income
-- % de empleados con bajo ingreso
SELECT 
    SUM(CASE WHEN MonthlyIncome < 4000 THEN 1 ELSE 0 END) * 1.0 
    / COUNT(*) AS pct_low_income
FROM hr_int;







-- PERFIL DE RIESGO DE ATTRITION % POR SEPARAO

-- % de empleados que son low satisfaction + low tenure + low income
SELECT 
    SUM(CASE 
        WHEN CAST(JobSatisfaction AS INTEGER) <= 2
        AND YearsAtCompany <= 2
        AND MonthlyIncome < 4000
    THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS pct_all_low
FROM hr_int;






-- % de empleados low satisfaction + low tenure
SELECT 
    SUM(CASE 
        WHEN CAST(JobSatisfaction AS INTEGER) <= 2
        AND YearsAtCompany <= 2
    THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS pct_low_sat_low_tenure
FROM hr_int;


-- % de empleados low satisfaction + low income
SELECT 
    SUM(CASE 
        WHEN CAST(JobSatisfaction AS INTEGER) <= 2
        AND MonthlyIncome < 4000
    THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS pct_low_sat_low_income
FROM hr_int;

-- % de empleados low tenure + low income
SELECT 
    SUM(CASE 
        WHEN YearsAtCompany <= 2
        AND MonthlyIncome < 4000
    THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS pct_low_tenure_low_income
FROM hr_int;










-- P(Low Satisfaction ∩ Attrition)
SELECT 
    (SUM(CASE WHEN CAST(JobSatisfaction AS INTEGER) <= 2 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) *
    (SUM(CASE WHEN CAST(JobSatisfaction AS INTEGER) <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 /
     SUM(CASE WHEN CAST(JobSatisfaction AS INTEGER) <= 2 THEN 1 ELSE 0 END)) 
AS pct_low_satisfaction_attrition_total
FROM hr_int;


-- P(Low Income ∩ Attrition)
SELECT 
    (SUM(CASE WHEN MonthlyIncome < 4000 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) *
    (SUM(CASE WHEN MonthlyIncome < 4000 AND Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 /
     SUM(CASE WHEN MonthlyIncome < 4000 THEN 1 ELSE 0 END)) 
AS pct_low_income_attrition_total
FROM hr_int;



-- P(Low Tenure ∩ Attrition)
SELECT 
    (SUM(CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) *
    (SUM(CASE WHEN YearsAtCompany <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 /
     SUM(CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END)) 
AS pct_low_tenure_attrition_total
FROM hr_int;





