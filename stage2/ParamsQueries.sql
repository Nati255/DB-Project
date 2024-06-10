-- This query retrieves details of students taught by a specific teacher during a specific period.
-- It includes the student's name, ID, class ID, and subject name, and filters results by the teacher's first and last name, and the period.
SELECT
    S.First_Name,
    S.Last_Name,
    S.Student_ID,
    C.Class_ID,
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
    Teacher T ON C.Teacher_ID = T.Teacher_ID
WHERE
    T.F_Name = &<name="First Name"> AND T.L_Name = &<name="Last Name"> -- Teacher first name and last name
    AND C.PERIODD = &<name="Period" hint="4 seasons of the year" list="winter,Summer,Spring,Autumn" type="string"> -- Period (e.g., 'spring')
ORDER BY
    S.Last_Name, S.First_Name;

-- This query retrieves details of teachers with a specific title and rank.
-- It includes the teacher's ID, first name, last name, title, and rank, and filters results by the title and rank.
SELECT
    T.Teacher_ID,
    T.F_Name,
    T.L_Name,
    T.Title,
    T.Rank
FROM
    Teacher T
WHERE
    T.Title = &<name="Title" list="Professor,Doctor,Master,Bachelor" type="string"> -- Title (e.g., 'Professor')
    AND T.Rank = &<name="Level" hint="e.g., 1, 2, 3" list="1,2,3" type="integer"> -- List of ranks (e.g., 1, 2, 3)
ORDER BY
    T.Rank, T.L_Name, T.F_Name;

-- This query retrieves details of classrooms of a specific type and capacity range.
-- It includes the classroom's ID, room type, capacity, and number of classes held in the classroom,
-- and filters results by the room type and capacity range.
SELECT
    CR.Classroom_ID,
    CR.Room_Type,
    CR.Capacity,
    COUNT(C.Class_ID) AS Number_of_Classes
FROM
    Classroom CR
LEFT JOIN
    Class C ON CR.Classroom_ID = C.Classroom_ID
WHERE
    CR.Room_Type = &<name="Room Type" list="Small,Medium,Big" type="string"> -- Room type (e.g., 'large', 'medium', 'small')
    AND CR.Capacity BETWEEN &<name="min capacity" type="integer"> AND &<name="max capacity" type="integer">
GROUP BY
    CR.Classroom_ID, CR.Room_Type, CR.Capacity
ORDER BY
    CR.Capacity ASC;

-- This query retrieves details of students born in a specific month and year,
-- and includes the student's name, ID, birth date, class ID, period, class time, subject name, and teacher's name.
SELECT
    S.First_Name,
    S.Last_Name,
    S.Student_ID,
    S.Date_Birth,
    SC.Class_ID,
    C.PERIODD,
    C.Time,
    T.F_Name AS Teacher_First_Name,
    T.L_Name AS Teacher_Last_Name,
    Sub.Name AS Subject_Name
FROM
    Student S
JOIN
    StudentClass SC ON S.Student_ID = SC.Student_ID
JOIN
    Class C ON SC.Class_ID = C.Class_ID
JOIN
    Teacher T ON C.Teacher_ID = T.Teacher_ID
JOIN
    Subject Sub ON C.Subject_ID = Sub.Subject_ID
WHERE
    EXTRACT(MONTH FROM S.Date_Birth) = &<name="start date" hint="between 1-12" type="integer"> -- Birth month (e.g., 5 for May)
    AND EXTRACT(YEAR FROM S.Date_Birth) = &<name="end date" hint="between 1-12" type="integer"> -- Birth year (e.g., 2005)
ORDER BY
    S.Last_Name, S.First_Name;

-- This query retrieves details of students studying a specific subject during a specific period.
-- It includes the student's name, ID, subject name, period, and the teacher's name, and filters results by the subject name and period.
SELECT
    S.First_Name,
    S.Last_Name,
    S.Student_ID,
    Sub.Name AS Subject_Name,
    C.PERIODD,
    T.F_Name AS Teacher_First_Name,
    T.L_Name AS Teacher_Last_Name
FROM
    Student S
JOIN
    StudentClass SC ON S.Student_ID = SC.Student_ID
JOIN
    Class C ON SC.Class_ID = C.Class_ID
JOIN
    Subject Sub ON C.Subject_ID = Sub.Subject_ID
JOIN
    Teacher T ON C.Teacher_ID = T.Teacher_ID
WHERE
    Sub.Name = &<name="subject name" list="select name from subject" type="string"> -- Subject name (e.g., 'Mathematics')
    AND C.PERIODD = &<name="Period" hint="4 seasons of the year" list="winter,Summer,Spring,Autumn" type="string"> -- Period (e.g., 'autumn')
ORDER BY
    S.Last_Name, S.First_Name;