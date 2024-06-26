CREATE OR REPLACE FUNCTION get_students_by_age_group(
    min_age IN NUMBER,
    max_age IN NUMBER,
    counta OUT INT
) RETURN SYS_REFCURSOR IS
    student_cursor SYS_REFCURSOR;
    current_year NUMBER := EXTRACT(YEAR FROM SYSDATE);
    student_age NUMBER;
    fname VARCHAR(20);
    lname VARCHAR(20);
    count_record INT := 0;
BEGIN
    OPEN student_cursor FOR
    SELECT First_Name, Last_Name, EXTRACT(YEAR FROM Date_Birth) AS Birth_Year
    FROM Student;

    LOOP
        FETCH student_cursor INTO fname, lname, student_age;
        EXIT WHEN student_cursor%NOTFOUND;

        student_age := current_year - student_age;

        IF student_age >= min_age AND student_age <= max_age THEN
            count_record := count_record + 1;
            DBMS_OUTPUT.PUT_LINE('Student ' || fname || ' ' || lname || ' Age: ' || student_age);
        END IF;
    END LOOP;
    CLOSE student_cursor;

    -- Set the OUT parameter
    counta := count_record;

    -- Reopen the cursor to return the results
    OPEN student_cursor FOR
    SELECT First_Name, Last_Name, EXTRACT(YEAR FROM Date_Birth) AS Birth_Year
    FROM Student
    WHERE (current_year - EXTRACT(YEAR FROM Date_Birth)) BETWEEN min_age AND max_age;

    RETURN student_cursor;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No students found in the specified age group');
        counta := 0;  -- Set OUT parameter to 0 in case of no data found
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
        counta := -1;  -- Set OUT parameter to -1 in case of an error
        RETURN NULL;
END get_students_by_age_group;
/
