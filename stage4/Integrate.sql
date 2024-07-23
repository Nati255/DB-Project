drop table TEACH;
drop table SUBJECTS_TAUGHT;

ALTER TABLE Teacher
ADD Employee_ID INT;

ALTER TABLE Teacher
ADD CONSTRAINT fk_employee
FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID);


--update Teacher with Employee_IDs between 1500 and 2000

-- First, create a temporary table to store valid Employee_IDs
CREATE GLOBAL TEMPORARY TABLE Temp_Employee_IDs (
    Employee_ID INT
) ON COMMIT DELETE ROWS;

-- Insert valid Employee_IDs into the temporary table
INSERT INTO Temp_Employee_IDs (Employee_ID)
SELECT Employee_ID
FROM Employee
WHERE Job_Title = 'worker'
  AND Employee_ID BETWEEN 1500 AND 2000;

-- Update Teacher table with these Employee_IDs
UPDATE Teacher T
SET Employee_ID = (
    SELECT TE.Employee_ID
    FROM Temp_Employee_IDs TE
    WHERE TE.Employee_ID = T.Teacher_ID
)
WHERE EXISTS (
    SELECT 1
    FROM Temp_Employee_IDs TE
    WHERE TE.Employee_ID = T.Teacher_ID
);

-- Drop the temporary table as it is no longer needed
DROP TABLE Temp_Employee_IDs;

