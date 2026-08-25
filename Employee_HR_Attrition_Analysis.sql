CREATE DATABASE hr_analytics;
USE hr_analytics;
CREATE TABLE employees (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(30),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(30),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

SELECT COUNT(*) AS total_employees
FROM employees;

SELECT *
FROM employees
LIMIT 5;

SELECT DISTINCT Department
FROM employees;

SELECT COUNT(*) AS total_employees
FROM employees;

SELECT 
    Department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Department
ORDER BY employee_count DESC;

SELECT 
    JobRole,
    COUNT(*) AS employee_count
FROM employees
GROUP BY JobRole
ORDER BY employee_count DESC;

SELECT 
    Department,
    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income
FROM employees
GROUP BY Department
ORDER BY average_monthly_income DESC;

SELECT 
    Department,
    ROUND(AVG(Age), 1) AS average_age
FROM employees
GROUP BY Department
ORDER BY average_age DESC;

SELECT 
    Attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Attrition;

SELECT 
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 
        2
    ) AS attrition_rate
FROM employees;

SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;

SELECT 
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY OverTime
ORDER BY attrition_rate DESC;

SELECT 
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobRole
ORDER BY attrition_rate DESC;

SELECT
    JobRole,
    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income
FROM employees
GROUP BY JobRole
ORDER BY average_monthly_income DESC;

SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM employees
ORDER BY MonthlyIncome DESC
LIMIT 10;

SELECT
    Department,
    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company
FROM employees
GROUP BY Department
ORDER BY average_years_at_company DESC;

SELECT
    CASE
        WHEN YearsAtCompany <= 2 THEN '0-2 Years'
        WHEN YearsAtCompany <= 5 THEN '3-5 Years'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS experience_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY experience_group
ORDER BY attrition_rate DESC;

SELECT
    JobSatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

SELECT
    WorkLifeBalance,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;

CREATE TABLE department_info (
    Department VARCHAR(50) PRIMARY KEY,
    DepartmentHead VARCHAR(100),
    Location VARCHAR(50)
);

INSERT INTO department_info (Department, DepartmentHead, Location)
VALUES
('Sales', 'Sales Director', 'New York'),
('Research & Development', 'R&D Director', 'Boston'),
('Human Resources', 'HR Director', 'Chicago');

SELECT
    e.Department,
    d.DepartmentHead,
    d.Location,
    COUNT(*) AS employee_count
FROM employees e
JOIN department_info d
    ON e.Department = d.Department
GROUP BY
    e.Department,
    d.DepartmentHead,
    d.Location
ORDER BY employee_count DESC;

SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM employees
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome)
    FROM employees
)
ORDER BY MonthlyIncome DESC;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    YearsAtCompany,
    OverTime,
    Attrition
FROM employees
WHERE OverTime = 'Yes'
  AND YearsAtCompany <= 2
  AND Attrition = 'Yes'
ORDER BY YearsAtCompany;