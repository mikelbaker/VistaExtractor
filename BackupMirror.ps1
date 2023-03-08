docker exec -it v08 iris stop IRIS quietly
docker exec -it bay iris stop IRIS quietly
$current_directory = (pwd).path
Copy-Item "$current_directory\bay\db\rou\IRIS.DAT" -Destination "$current_directory\v08\db\v08\bay\rou\IRIS.DAT"
docker exec -it --user root v08 chown irisowner:irisowner /irisdb/v08/bay/rou/IRIS.DAT
docker exec -it bay iris start IRIS

docker exec -it tam iris stop IRIS quietly
Copy-Item "$current_directory\tam\db\rou\IRIS.DAT" -Destination "$current_directory\v08\db\v08\tam\rou\IRIS.DAT"
docker exec -it --user root v08 chown irisowner:irisowner /irisdb/v08/tam/rou/IRIS.DAT
docker exec -it tam iris start IRIS

docker exec -it wpb iris stop IRIS quietly
Copy-Item "$current_directory\wpb\db\rou\IRIS.DAT" -Destination "$current_directory\v08\db\v08\wpb\rou\IRIS.DAT"
docker exec -it --user root v08 chown irisowner:irisowner /irisdb/v08/wpb/rou/IRIS.DAT
docker exec -it wpb iris start IRIS
docker exec -it v08 iris start IRIS