DECLARE
    student_cursor SYS_REFCURSOR;
    min_age NUMBER := 18;
    max_age NUMBER := 19;
    counta INT;
BEGIN
    -- Call the function
    student_cursor := get_students_by_age_group(min_age, max_age, counta);

    -- Print the number of records
    DBMS_OUTPUT.PUT_LINE('Number of students in the age group ' || min_age || ' to ' || max_age || ': ' || counta);
    
    update_teacher_rank;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;

