-- This query modifies the Teacher table to set a default value of 1 for the RANK column.
ALTER TABLE teacher
MODIFY RANK DEFAULT 1;

-- This query modifies the TeachAssign table to make the DateAssign column NOT NULL.
ALTER TABLE teachassign
MODIFY DateAssign DATE NOT NULL;

-- This query adds a constraint to the Student table to ensure that the Gradesheats column cannot have negative values.
ALTER TABLE Student
ADD CONSTRAINT chk_Gradesheats_nonnegative CHECK (Gradesheats >= 0);

-- This query adds a constraint to the Classroom table to ensure that the Capacity column values are between 15 and 30.
ALTER TABLE Classroom
ADD CONSTRAINT chk_Capacity_range CHECK (Capacity >= 15 AND Capacity <= 30);