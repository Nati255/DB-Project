DECLARE
    class_details_cursor SYS_REFCURSOR;
    counta INT;
BEGIN
    -- Call the function to get class details by period
    class_details_cursor := get_class_details_by_period('Summer', counta);


    -- Call the procedure to generate student enrollment report
    Generate_Student_Enrollment_Report;
    
        -- Display the results
    DBMS_OUTPUT.PUT_LINE('Number of classes in the period group: '|| counta);
    
END;
