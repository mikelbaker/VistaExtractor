
docker exec -it bay iris stop IRIS quietly
docker cp IRIS.DAT bay:/irisdb/rou/
docker exec -it --user root bay chown irisowner:irisowner /irisdb/rou/IRIS.DAT
docker exec -it bay iris start IRIS

docker exec -it tam iris stop IRIS quietly
docker cp IRIS.DAT tam:/irisdb/rou/
docker exec -it --user root tam chown irisowner:irisowner /irisdb/rou/IRIS.DAT
docker exec -it tam iris start IRIS

docker exec -it wpb iris stop IRIS quietly
docker cp IRIS.DAT wpb:/irisdb/rou/
docker exec -it --user root wpb chown irisowner:irisowner /irisdb/rou/IRIS.DAT
docker exec -it wpb iris start IRIS