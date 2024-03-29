
#docker exec -it vx130 iris session iris -U vx130 '##class(%SYSTEM.OBJ).LoadDir("/code/src/","cku",,1)'
docker cp .\loadcode vx130:/tmp/
docker exec -it --user root vx130 chmod +x /tmp/loadcode
docker exec -it vx130 /tmp/loadcode

docker exec -it v08 iris session iris -U vx130 "##class(VX130.IRISInstance).Init()"
docker exec -it v08 iris session iris -U vx130 "##class(VX130.VistaSite).Init()"
docker exec -it v08 iris session iris -U vx130 "##class(VX130.GlobalsToWatch).Init()"
docker exec -it v08 iris session iris -U vx130 "##class(VX130Task.AddJournalFileTask).ScheduleEveryMinute()"
docker exec -it v08 iris session iris -U vx130 "##class(VX130Task.JournalReaderTask).ScheduleEveryMinute()"
docker exec -it v08 iris session iris -U vx130 "##class(VX130Task.DataFilerTask).ScheduleEveryMinute()"

docker exec -it v08 iris session iris -U vx130 "##class(VX130.JournalReaderStatus).Init()"

docker exec -it v08 iris session iris -U vx130 "##class(Dim.VistaFilev001).BuildSite(516)"
docker exec -it v08 iris session iris -U vx130 "##class(Dim.VistaFilev001).BuildSite(548)"
docker exec -it v08 iris session iris -U vx130 "##class(Dim.VistaFilev001).BuildSite(673)"

docker exec -it v08 iris session iris -U vx130 "##class(Dim.VistaFieldv001).BuildSite(516)"
docker exec -it v08 iris session iris -U vx130 "##class(Dim.VistaFieldv001).BuildSite(548)"
docker exec -it v08 iris session iris -U vx130 "##class(Dim.VistaFieldv001).BuildSite(673)"