ZN "%SYS"

Set sc=##class(Security.Users).Import("/usr/irissys/mgr/UsersExport.xml",.tNumImported)

Write !,"Number of users Imported: ",$GET(tNumImported),!

Write !,"Load Install Manifest."
do $SYSTEM.OBJ.Load("/usr/irissys/mgr/Installer.cls","cuk")

Write !,"Run Install Manifest."
do ##class(VX130.Installer).setup()

Write !,"Install %ZSTART"
do $SYSTEM.OBJ.Load("/usr/irissys/mgr/%ZSTART.mac","cuk")

Halt