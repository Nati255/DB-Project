
[General]
Version=1

[Preferences]
Username=
Password=2569
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##DANIEL
Name=CLASSROOM
Count=400

[Record]
Name=ROOM_TYPE
Type=VARCHAR2
Size=10
Data=List('Small', 'Medium', 'Big')
Master=

[Record]
Name=CAPACITY
Type=NUMBER
Size=
Data=Random(15, 30)
Master=

[Record]
Name=CLASSROOM_ID
Type=NUMBER
Size=
Data=Sequence(1)
Master=

