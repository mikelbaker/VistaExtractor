
docker exec -it bay iris stop IRIS quietly
docker exec -it tam iris stop IRIS quietly
docker exec -it wpb iris stop IRIS quietly

$current_directory = (pwd).path
Copy-Item "$current_directory\IRIS.DAT" -Destination "$current_directory\bay\db\rou\IRIS.DAT"
Copy-Item "$current_directory\IRIS.DAT" -Destination "$current_directory\tam\db\rou\IRIS.DAT"
Copy-Item "$current_directory\IRIS.DAT" -Destination "$current_directory\wpb\db\rou\IRIS.DAT"

docker exec -it --user root bay chown irisowner:irisowner /irisdb/rou/IRIS.DAT
docker exec -it --user root tam chown irisowner:irisowner /irisdb/rou/IRIS.DAT
docker exec -it --user root wpb chown irisowner:irisowner /irisdb/rou/IRIS.DAT

docker exec -it bay iris start IRIS
docker exec -it tam iris start IRIS
docker exec -it wpb iris start IRIS