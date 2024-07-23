
-- View 1
CREATE OR REPLACE VIEW Student_Class_Details AS
SELECT
    S.Student_ID,
    S.First_Name,
    S.Last_Name,
    C.Class_ID,
    C.PERIODD,
    C.Time,
    CL.Classroom_ID,
    Sub.Name AS Subject_Name
FROM
    Student S
JOIN
    StudentClass SC ON S.Student_ID = SC.Student_ID
JOIN
    Class C ON SC.Class_ID = C.Class_ID
JOIN
    Subject Sub ON C.Subject_ID = Sub.Subject_ID
JOIN
    Classroom CL ON C.Classroom_ID = CL.Classroom_ID;

-- Query 1
SELECT
    Student_ID,
    First_Name,
    Last_Name,
    Class_ID,
    PERIODD,
    Time,
    Classroom_ID,
    Subject_Name
FROM
    Student_Class_Details
ORDER BY
    Student_ID, Class_ID;

-- Query 2
SELECT
    Class_ID,
    PERIODD,
    Time,
    Subject_Name
FROM
    Student_Class_Details
WHERE
    Student_ID = &<name="id:">
ORDER BY
    Class_ID;
----------------------------------------------------------------------------
-- View 2
CREATE OR REPLACE VIEW Employee_Budget_Details AS
SELECT
    E.Employee_ID,
    E.Employee_Name,
    B.Budget_Code,
    B.Budget_Amount,
    B.Expense_Category,
    B.BUDGET_YEAR
FROM
    Employee E
JOIN
    Budget B ON E.Employee_ID = B.Employee_ID;

-- Query 1
SELECT
    Employee_ID,
    Employee_Name,
    Budget_Code,
    Budget_Amount,
    Expense_Category,
    BUDGET_YEAR
FROM
    Employee_Budget_Details
ORDER BY
    Employee_ID, Budget_Code;

-- Query 2
SELECT
    Budget_Code,
    Budget_Amount,
    Expense_Category,
    Budget_Year
FROM
    Employee_Budget_Details
WHERE
    Employee_ID = &<name="employee id:">
ORDER BY
    Budget_Year;

