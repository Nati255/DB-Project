/*
 This function retrieves the details of classes held in a specific period.
 */
CREATE OR REPLACE FUNCTION get_class_details_by_period(
    p_period IN VARCHAR2
) RETURN SYS_REFCURSOR IS
    class_cursor SYS_REFCURSOR;
    class_id NUMBER;
    subject_name VARCHAR2(50);
    teacher_name VARCHAR2(30);
BEGIN
    OPEN class_cursor FOR
    SELECT C.Class_ID, Sub.Name AS Subject_Name, T.F_Name || ' ' || T.L_Name AS Teacher_Name
    FROM Class C
    JOIN Subject Sub ON C.Subject_ID = Sub.Subject_ID
    JOIN Teacher T ON C.Teacher_ID = T.Teacher_ID
    WHERE C.PERIODD = p_period;

    LOOP
        FETCH class_cursor INTO class_id, subject_name, teacher_name;
        EXIT WHEN class_cursor%NOTFOUND;

        IF subject_name IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('Subject name is missing for class ID: ' || class_id);
        ELSIF teacher_name IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('Teacher name is missing for class ID: ' || class_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Class ID: ' || class_id || ', Subject: ' || subject_name || ', Teacher: ' || teacher_name);
        END IF;
    END LOOP;
    CLOSE class_cursor;

    OPEN class_cursor FOR
    SELECT C.Class_ID, Sub.Name AS Subject_Name, T.F_Name || ' ' || T.L_Name AS Teacher_Name
    FROM Class C
    JOIN Subject Sub ON C.Subject_ID = Sub.Subject_ID
    JOIN Teacher T ON C.Teacher_ID = T.Teacher_ID
    WHERE C.PERIODD = p_period;

    RETURN class_cursor;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No classes found for the specified period');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
        RETURN NULL;
END get_class_details_by_period;
