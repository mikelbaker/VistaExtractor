# VistaExtractor


This project will create three VISTA mirrors, and an Async RO mirror that will act as the source for the VISTA extractor.  It will also add a database server to hold the extracted data and the VX130 code.

To start you will need a couple of things A copy of the VISTA database from FOIA and if you want to run a seperate database server you will need an IRIS key that allows for ECP use.  YOu will also need an IRIS image from Intersystems, and a Web Gateway image from intersystems.

IRIS Images: 
https://container.intersystems.com/

FOIA Database:
wget https://foia-vista.worldvista.org/DBA_VistA_FOIA_System_Files/DBA_VISTA_FOIA_2024/DBA_VISTA_FOIA_20240531.zip
unzip DBA_VISTA_FOIA_20240531.zip

Once you have the required pieces you can run the CleanUp script that will set up the directories so that your data and code will be persisted from one session to another.  

    ./CleanUp

Next you should start the stack by running

    docker-compose up -d

This will start the three VISTA containers, the Async mirror, the VX130 database server and the webgateway.  Before it starts the containers it will build the images using the Dockerfile.  So all images will start with a base image of IRIS and then diverge based on thier role and enevironment.

It will take a few minutes to get everything running but once it is all up you should be able to reach each instances System Management Portal using these urls:

bay         : http://localhost/bay/csp/sys/UtilHome.csp
tam         : http://localhost/tam/csp/sys/UtilHome.csp
wpb         : http://localhost/wpb/csp/sys/UtilHome.csp
v08         : http://localhost/v08/csp/sys/UtilHome.csp
vx130       : http://localhost/vx130/csp/sys/UtilHome.csp
web gateway : http://localhost/csp/bin/Systems/Module.cxw

Next you add the VISTA databases to the three VISTA systems using the CopyVista script.  This will stop IRIS on each of the VISTA containers and copy the VISTA database to thier persistent storea and then start VISTA back up.

    ./CopyVista

Now you will need to mount the databases and then add them to the VISTA mirror.  This can be done easily using the SMP:

First mount the databases:
bay : http://localhost/bay/csp/sys/op/%25CSP.UI.Portal.DatabaseDetails.zen?$ID1=/irisdb/rou/&DBName=ROU
tam : http://localhost/tam/csp/sys/op/%25CSP.UI.Portal.DatabaseDetails.zen?$ID1=/irisdb/rou/&DBName=ROU
wpb : http://localhost/wpb/csp/sys/op/%25CSP.UI.Portal.DatabaseDetails.zen?$ID1=/irisdb/rou/&DBName=ROU

then add the database to the VISTA mirror:

bay : http://localhost/bay/csp/sys/mgr/%25CSP.UI.Portal.Databases.zen
tam : http://localhost/tam/csp/sys/mgr/%25CSP.UI.Portal.Databases.zen
wpb : http://localhost/wpb/csp/sys/mgr/%25CSP.UI.Portal.Databases.zen

with the databases setup as primary mirror now you can get a backup of each of the databases and restore it the the Async RO mirror v08.  To do this you just run the BackupMirror script.  This stops the VISTA and v08 instances and then copies the mirrored database from the VISTA systems to the mirror.

    ./BackupMirror

Now you will need to configure the Async RO mirror using the SMP.

v08 : http://localhost/v08/csp/sys/%25CSP.Portal.Home.zen

Select the Join as Async for each of the VISTA systems.
Be sure to make the system a ReadOnly Reporting mirror.

Next you have to activate and catchup each of the mirrored databases:

v08: http://localhost/v08/csp/sys/op/%25CSP.UI.Portal.Mirror.Monitor.zen

next you will need to load the VistaExtractor code into the VX130 database server.  You can run the script CopyVXCode

    ./CopyVXCode


Create the ClassBuilder APIS
1.  docker exec -it vx130 iris session iris -U %SYS "##class(vx130.Installer).AddAPI()"

to run the attributeMap:

http://localhost


Populate VISTA Systems Patient Files

    ./PopulatePatient

To get a VX130 Patient as SDA object

docker exec -it vx130 iris session iris -U VX130
d ##class(SPatient.SPatient2v001).ToSDA("516||1").ToQuickXML()


SELECT * FROM SDA.AttributeMap

RUN SOME QUERIES:

http://localhost/vx130/csp/sys/exp/%25CSP.UI.Portal.SQL.Home.zen?$NAMESPACE=VX130

SELECT * from VX130.IRISInstance

SELECT * FROM VX130.JournalFile

SELECT * from VX130.JournalReaderStatus

SELECT * from VX130.JournalReaderHistory

SELECT * FROM VX130.GlobalsToWatch


SELECT Sta3n,COUNT(*) FROM Dim.VistaFieldv001 GROUP BY Sta3n


SELECT * FROM Dim.VistaFieldv001 WHERE VistaFileNumber='2' AND VistaFieldNumber='.01'
