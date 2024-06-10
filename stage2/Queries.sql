-- This query calculates the average number of students per teacher.
-- It first counts the number of students in each class for each teacher,
-- and then calculates the average number of students for each teacher.
SELECT Teacher_ID, AVG(num_students) AS avg_students_per_teacher
FROM (
    SELECT c.Teacher_ID, COUNT(sc.Student_ID) AS num_students
    FROM Class c
    LEFT JOIN StudentClass sc ON c.Class_ID = sc.Class_ID
    GROUP BY c.Class_ID, c.Teacher_ID
) student_counts
GROUP BY Teacher_ID
ORDER BY Teacher_ID;

-- This query calculates the total capacity used for each room type.
-- It sums the capacity of classrooms that are used by classes,
-- and groups the results by room type.
SELECT Room_Type, SUM(Capacity) AS total_capacity_used
FROM (
    SELECT cr.Room_Type, Capacity
    FROM Class c
    INNER JOIN Classroom cr ON c.Classroom_ID = cr.Classroom_ID
) class_room_info
GROUP BY Room_Type;

-- This query calculates the average number of classes per day for each student.
-- It first counts the number of distinct classes each student attends each day,
-- and then calculates the average number of classes per day for each student.
SELECT Student_ID, AVG(num_classes) AS avg_classes_per_day
FROM (
    SELECT s.Student_ID, COUNT(DISTINCT sch.Class_ID) AS num_classes
    FROM Student s
    LEFT JOIN Schedule sch ON s.Student_ID = sch.Student_ID
    GROUP BY s.Student_ID, sch.ClassDate
) student_classes
GROUP BY Student_ID;

-- This query finds the top 3 teachers with the highest average number of students per class.
-- It first counts the number of students in each class for each teacher,
-- and then calculates the average number of students per class for each teacher.
-- Finally, it orders the teachers by this average in descending order and selects the top 3.
SELECT Teacher.Teacher_ID, Teacher.F_Name, Teacher.L_Name, AVG(StudentCount.num_students) AS Average_Students_Per_Class
FROM Teacher
JOIN (
    SELECT Class.Teacher_ID, COUNT(StudentClass.Student_ID) AS num_students
    FROM Class
    JOIN StudentClass ON Class.Class_ID = StudentClass.Class_ID
    GROUP BY Class.Teacher_ID
) StudentCount ON Teacher.Teacher_ID = StudentCount.Teacher_ID
GROUP BY Teacher.Teacher_ID, Teacher.F_Name, Teacher.L_Name
ORDER BY Average_Students_Per_Class DESC
FETCH FIRST 3 ROWS ONLY;

-- This query deletes classes from the 'Class' table that have the 'Summer' period
-- and have fewer than 5 students enrolled in them.
DELETE FROM Class
WHERE PERIODD = 'Summer'
AND Class_ID IN (
    SELECT Class_ID
    FROM StudentClass
    GROUP BY Class_ID
    HAVING COUNT(Student_ID) < 5
);

-- This query updates the 'RANK' of teachers by incrementing it by 1,
-- for teachers who are assigned to more than 3 subjects.
UPDATE Teacher
SET RANK = RANK + 1
WHERE Teacher_ID IN (
    SELECT Teacher_ID
    FROM TeachAssign
    GROUP BY Teacher_ID
    HAVING COUNT(Subject_ID) > 3
);

-- This query updates the capacity of 'Medium' type classrooms to 30,
-- for classrooms that are used by more than 2 classes.
UPDATE Classroom
SET Capacity = 30
WHERE Room_Type = 'Medium'
AND Classroom_ID IN (
    SELECT Classroom_ID
    FROM Class
    GROUP BY Classroom_ID
    HAVING COUNT(Class_ID) > 2
);

-- This query retrieves details of students who have classes in the 'Summer' period
-- and were born in May or June. It includes the student's name, birth date, class ID,
-- subject ID, subject name, and teacher's name.
SELECT
    S.First_Name,
    S.Last_Name,
    S.Student_ID,
    S.Date_Birth,
    C.Class_ID,
    C.Subject_ID,
    Sub.Name AS Subject_Name,
    T.F_Name AS Teacher_First_Name,
    T.L_Name AS Teacher_Last_Name
FROM Student S
JOIN StudentClass SC ON S.Student_ID = SC.Student_ID
JOIN Class C ON SC.Class_ID = C.Class_ID
JOIN Subject Sub ON C.Subject_ID = Sub.Subject_ID
JOIN Teacher T ON C.Teacher_ID = T.Teacher_ID
WHERE C.PERIODD = 'Summer'
    AND EXTRACT(MONTH FROM S.Date_Birth) IN (5, 6)
ORDER BY S.Last_Name, S.First_Name;

-- This query deletes students from the 'Student' table who are not enrolled in any classes.
DELETE FROM Student
WHERE Student_ID NOT IN (SELECT Student_ID FROM StudentClass);

-- This query deletes teachers from the 'Teacher' table who do not have any teaching assignments.
DELETE FROM Teacher
WHERE Teacher_ID NOT IN (SELECT DISTINCT Teacher_ID FROM TeachAssign);

-- This query counts the number of classes scheduled on each day of the week,
-- and orders the results by the days of the week from Sunday to Saturday.
SELECT
    ClassDate,
    COUNT(Class_ID) AS Number_of_Classes
FROM Schedule
GROUP BY ClassDate
ORDER BY
    CASE
        WHEN ClassDate = 'Sunday' THEN 1
        WHEN ClassDate = 'Monday' THEN 2
        WHEN ClassDate = 'Tuesday' THEN 3
        WHEN ClassDate = 'Wednesday' THEN 4
        WHEN ClassDate = 'Thursday' THEN 5
        WHEN ClassDate = 'Friday' THEN 6
        WHEN ClassDate = 'Saturday' THEN 7
    END;

-- This query retrieves details of students who have classes in the 'Summer' period
-- and were born in May or June. It includes the student's name, birth date, class ID,
-- subject ID, subject name, and teacher's name.
SELECT
    S.First_Name,
    S.Last_Name,
    S.Student_ID,
    S.Date_Birth,
    C.Class_ID,
    C.Subject_ID,
    Sub.Name AS Subject_Name,
    T.F_Name AS Teacher_First_Name,
    T.L_Name AS Teacher_Last_Name
FROM Student S
JOIN StudentClass SC ON S.Student_ID = SC.Student_ID
JOIN Class C ON SC.Class_ID = C.Class_ID
JOIN Subject Sub ON C.Subject_ID = Sub.Subject_ID
JOIN Teacher T ON C.Teacher_ID = T.Teacher_ID
WHERE C.PERIODD = 'Summer'
    AND (EXTRACT(MONTH FROM S.Date_Birth) = 5 OR EXTRACT(MONTH FROM S.Date_Birth) = 6)
ORDER BY S.Last_Name, S.First_Name;