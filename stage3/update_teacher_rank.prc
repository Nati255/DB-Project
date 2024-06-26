CREATE OR REPLACE PROCEDURE update_teacher_rank IS
    CURSOR teacher_cursor IS
        SELECT Teacher_ID, COUNT(Class_ID) AS Num_Classes
        FROM Class
        GROUP BY Teacher_ID;

    v_teacher_id Teacher.Teacher_ID%TYPE;
    v_num_classes NUMBER;
BEGIN
    OPEN teacher_cursor;
    LOOP
        FETCH teacher_cursor INTO v_teacher_id, v_num_classes;
        EXIT WHEN teacher_cursor%NOTFOUND;

        IF v_num_classes >= 5 THEN
            UPDATE Teacher SET Rank = 3 WHERE Teacher_ID = v_teacher_id;
        ELSIF v_num_classes >= 3 THEN
            UPDATE Teacher SET Rank = 2 WHERE Teacher_ID = v_teacher_id;
        END IF;
    END LOOP;
    CLOSE teacher_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END update_teacher_rank;
