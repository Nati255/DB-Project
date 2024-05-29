
[General]
Version=1

[Preferences]
Username=
Password=2587
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##DANIEL
Name=SCHEDULE
Count=400

[Record]
Name=CLASSDATE
Type=VARCHAR2
Size=10
Data=List('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
Master=

[Record]
Name=SCHEDULE_ID
Type=NUMBER
Size=
Data=Sequence(1)
Master=

[Record]
Name=STUDENT_ID
Type=NUMBER
Size=
Data=List(select student_id from student)
Master=

[Record]
Name=CLASS_ID
Type=NUMBER
Size=
Data=List(select class_id from class)
Master=

