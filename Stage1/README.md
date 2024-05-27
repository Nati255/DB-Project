
---

# Project Report


---

## Presenters
- **Daniel Shalom Cohen** - ID: 212991749
- **Nati Stern** - ID: 322879255


## Table of Contents
1. [Introduction](#introduction)
2. [ERD and DSD Diagrams](#erd-and-dsd-diagrams)
3. [Design Decisions](#design-decisions)
4. [Create Table Commands](#create-table-commands)
5. [Data Entry Methods](#data-entry-methods)
6. [Data Backup and Restoration](#data-backup-and-restoration)

---

### Introduction 

This system serves as a comprehensive database management tool for managing students, teachers, classes, schedules, subjects, and classrooms in an educational institution. It enables efficient organization and tracking of academic data, including student information, class schedules, teacher assignments, and classroom details.

#### Data Description:

1. **Student:**
   - **Description:** Represents individual students enrolled in the educational institution.
   - **Attributes:**
     - First_Name: First name of the student.
     - Last_Name: Last name of the student.
     - Student_ID: Unique identifier for each student.
     - Date_Birth: Date of birth of the student.
     - Gradesheats: Grade level or academic year of the student.
     - Address: Address of the student.
   - **Purpose:** Tracks student demographics, academic records, and enrollment details.

2. **Teacher:**
   - **Description:** Represents educators employed by the educational institution.
   - **Attributes:**
     - Teacher_ID: Unique identifier for each teacher.
     - F_Name: First name of the teacher.
     - L_Name: Last name of the teacher.
     - Title: Title or designation of the teacher.
     - Level: Level or rank of the teacher (e.g., junior, senior).
   - **Purpose:** Stores information about teachers' profiles, qualifications, and assignments.

3. **Subject:**
   - **Description:** Represents academic subjects offered by the educational institution.
   - **Attributes:**
     - Subject_ID: Unique identifier for each subject.
     - Name: Name or title of the subject.
     - Detail: Additional details or description of the subject.
   - **Purpose:** Catalogs information about the curriculum, course offerings, and academic disciplines.

4. **Classroom:**
   - **Description:** Represents physical spaces used for conducting classes.
   - **Attributes:**
     - Classroom_ID: Unique identifier for each classroom.
     - Room_Type: Type or category of the classroom (e.g., lecture hall, laboratory).
     - Capacity: Maximum seating capacity of the classroom.
   - **Purpose:** Maintains details about classroom facilities, capacities, and availability.

5. **TeachAssign:**
   - **Description:** Represents assignments of teachers to specific subjects.
   - **Attributes:**
     - Subject_ID: Foreign key referencing the Subject table.
     - Teacher_ID: Foreign key referencing the Teacher table.
     - DateAssign: Date of assignment.
   - **Purpose:** Establishes relationships between teachers and subjects they are assigned to teach.

6. **Class:**
   - **Description:** Represents individual classes or courses offered by the educational institution.
   - **Attributes:**
     - Class_ID: Unique identifier for each class.
     - PERIODD: Period or session of the class.
     - Time: Time schedule of the class.
     - Classroom_ID: Foreign key referencing the Classroom table.
     - Subject_ID: Foreign key referencing the Subject table.
     - Teacher_ID: Foreign key referencing the Teacher table.
   - **Purpose:** Organizes class schedules and links them to specific subjects, teachers, and classrooms.

7. **Schedule:**
   - **Description:** Represents schedules or timetables for classes.
   - **Attributes:**
     - Schedule_ID: Unique identifier for each schedule entry.
     - ClassDate: Date of the class.
     - Hour: Time of the class.
     - Student_ID: Foreign key referencing the Student table.
     - Class_ID: Foreign key referencing the Class table.
   - **Purpose:** Records class schedules for individual students.

8. **StudentClass:**
   - **Description:** Represents the enrollment of students in specific classes.
   - **Attributes:**
     - Student_ID: Foreign key referencing the Student table.
     - Class_ID: Foreign key referencing the Class table.
   - **Purpose:** Establishes relationships between students and classes they are enrolled in.

The system aims to facilitate efficient management of academic data and streamline processes related to student enrollment, class scheduling, teacher assignments, and curriculum management.

### ERD and DSD Diagrams

![img_1.png](img_1.png)
![img_2.png](img_2.png)

### Design Decisions

In designing the database schema, careful consideration was given to the establishment of foreign keys to enforce referential integrity and maintain relationships between different tables. Here's an explanation of each foreign key and its related table:

#### TeachAssign Foreign Keys:
- **Subject_ID:** This foreign key references the `Subject` table's `Subject_ID` column, establishing a relationship between the `TeachAssign` table and the `Subject` table to indicate which subjects are assigned to teachers.
- **Teacher_ID:** This foreign key references the `Teacher` table's `Teacher_ID` column, establishing a relationship between the `TeachAssign` table and the `Teacher` table to indicate which teachers are assigned to teach specific subjects.

#### Class Foreign Keys:
- **Classroom_ID:** This foreign key references the `Classroom` table's `Classroom_ID` column, establishing a relationship between the `Class` table and the `Classroom` table to indicate which classroom is assigned to a particular class.
- **Subject_ID:** This foreign key references the `Subject` table's `Subject_ID` column, establishing a relationship between the `Class` table and the `Subject` table to indicate which subject is being taught in a particular class.
- **Teacher_ID:** This foreign key references the `Teacher` table's `Teacher_ID` column, establishing a relationship between the `Class` table and the `Teacher` table to indicate which teacher is assigned to teach a particular class.

#### Schedule Foreign Keys:
- **Student_ID:** This foreign key references the `Student` table's `Student_ID` column, establishing a relationship between the `Schedule` table and the `Student` table to indicate which student is enrolled in a particular class schedule.
- **Class_ID:** This foreign key references the `Class` table's `Class_ID` column, establishing a relationship between the `Schedule` table and the `Class` table to indicate which class the schedule is associated with.

#### StudentClass Foreign Keys:
- **Student_ID:** This foreign key references the `Student` table's `Student_ID` column, establishing a relationship between the `StudentClass` table and the `Student` table to indicate which student is enrolled in a particular class.
- **Class_ID:** This foreign key references the `Class` table's `Class_ID` column, establishing a relationship between the `StudentClass` table and the `Class` table to indicate which class the student is enrolled in.

These foreign key relationships ensure the integrity of the database and maintain consistency between related tables, enabling accurate data retrieval and manipulation.

### Create Table Commands

```sql
CREATE TABLE Student
(
  First_Name VARCHAR(10) NOT NULL,
  Student_ID INT NOT NULL,
  Date_Birth DATE NOT NULL,
  Gradesheats INT NOT NULL,
  Address VARCHAR(20) NOT NULL,
  Last_Name VARCHAR(10) NOT NULL,
  PRIMARY KEY (Student_ID)
);

CREATE TABLE Teacher
(
  Teacher_ID INT NOT NULL,
  L_Name VARCHAR(10) NOT NULL,
  F_Name VARCHAR(10) NOT NULL,
  Title VARCHAR(10) NOT NULL,
  Level INT NOT NULL,
  PRIMARY KEY (Teacher_ID)
);

CREATE TABLE Subject
(
  Subject_ID INT NOT NULL,
  Name VARCHAR(10) NOT NULL,
  Detail VARCHAR(10) NOT NULL,
  PRIMARY KEY (Subject_ID)
);

CREATE TABLE Classroom
(
  Room_Type VARCHAR(10) NOT NULL,
  Capacity INT NOT NULL,
  Classroom_ID INT NOT NULL,
  PRIMARY KEY (Classroom_ID)
);

CREATE TABLE TeachAssign
(
  DateAssign VARCHAR(10) NOT NULL,
  Subject_ID INT NOT NULL,
  Teacher_ID INT NOT NULL,
  PRIMARY KEY (Subject_ID, Teacher_ID),
  FOREIGN KEY (Subject_ID) REFERENCES Subject(Subject_ID),
  FOREIGN KEY (Teacher_ID) REFERENCES Teacher(Teacher_ID)
);

CREATE TABLE Class
(
  Class_ID INT NOT NULL,
  PERIODD VARCHAR(10) NOT NULL,
  Time VARCHAR(10) NOT NULL,
  Classroom_ID INT NOT NULL,
  Subject_ID INT NOT NULL,
  Teacher_ID INT NOT NULL,
  PRIMARY KEY (Class_ID),
  FOREIGN KEY (Classroom_ID) REFERENCES Classroom(Classroom_ID),
  FOREIGN KEY (Subject_ID) REFERENCES Subject(Subject_ID),
  FOREIGN KEY (Teacher_ID) REFERENCES Teacher(Teacher_ID)
);

CREATE TABLE Schedule
(
  ClassDate DATE NOT NULL,
  Hour VARCHAR(10) NOT NULL,
  Schedule_ID INT NOT NULL,
  Student_ID INT NOT NULL,
  Class_ID INT NOT NULL,
  PRIMARY KEY (Schedule_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Class_ID) REFERENCES Class(Class_ID)
);

CREATE TABLE StudentClass
(
  Student_ID INT NOT NULL,
  Class_ID INT NOT NULL,
  PRIMARY KEY (Student_ID, Class_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Class_ID) REFERENCES Class(Class_ID)
);
```

### Data Entry Methods

[Insert screenshots of three selected data entry methods here]

### Data Backup and Restoration

[Insert screenshots of performing data backup and restoration here]

---
