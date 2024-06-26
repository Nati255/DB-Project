CREATE OR REPLACE PROCEDURE Generate_Student_Enrollment_Report AS
    TYPE Enrollment_Record IS RECORD (
        Teacher_ID Teacher.Teacher_ID%TYPE,
        Teacher_Name VARCHAR2(50),
        Subject_Name Subject.Name%TYPE,
        Num_Students INT
    );
    TYPE Enrollment_Table IS TABLE OF Enrollment_Record INDEX BY PLS_INTEGER;
    v_Enrollment_Table Enrollment_Table;

    CURSOR c_Enrollment_Data IS
        SELECT t.Teacher_ID, t.F_Name || ' ' || t.L_Name AS Teacher_Name, sub.Name AS Subject_Name, COUNT(sc.Student_ID) AS Num_Students
        FROM Teacher t
        JOIN Class c ON t.Teacher_ID = c.Teacher_ID
        JOIN Subject sub ON c.Subject_ID = sub.Subject_ID
        LEFT JOIN StudentClass sc ON c.Class_ID = sc.Class_ID
        GROUP BY t.Teacher_ID, t.F_Name, t.L_Name, sub.Name;
BEGIN
    OPEN c_Enrollment_Data;
    FETCH c_Enrollment_Data BULK COLLECT INTO v_Enrollment_Table;
    CLOSE c_Enrollment_Data;

    -- Output the report
    FOR i IN v_Enrollment_Table.FIRST .. v_Enrollment_Table.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Teacher: ' || v_Enrollment_Table(i).Teacher_Name ||
                             ', Subject: ' || v_Enrollment_Table(i).Subject_Name ||
                             ', Number of Students: ' || v_Enrollment_Table(i).Num_Students);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END Generate_Student_Enrollment_Report;
/
