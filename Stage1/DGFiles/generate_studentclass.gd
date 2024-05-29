
[General]
Version=1

[Preferences]
Username=
Password=2706
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##DANIEL
Name=STUDENTCLASS
Count=400

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

