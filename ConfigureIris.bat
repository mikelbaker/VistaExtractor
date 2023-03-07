ZN "%SYS"

Set sc=##class(Security.Users).Import("/usr/irissys/mgr/UsersExport.xml",.tNumImported)

Write !,"Number of users Imported: ",$GET(tNumImported),!

Write !,"Install %ZSTART"
do $SYSTEM.OBJ.Load("/usr/irissys/mgr/%ZSTART.mac","cuk")

Halt