docker-compose down
docker image rm vistaextractor-bay vistaextractor-tam vistaextractor-wpb vistaextractor-v08 vistaextractor-vx130


Remove-Item -LiteralPath "bay" -Force -Recurse | Out-Null
Remove-Item -LiteralPath "tam" -Force -Recurse | Out-Null
Remove-Item -LiteralPath "wpb" -Force -Recurse | Out-Null
Remove-Item -LiteralPath "v08" -Force -Recurse | Out-Null
Remove-Item -LiteralPath "vx130" -Force -Recurse | Out-Null

New-Item -ItemType Directory -Path bay/code -Force | Out-Null
New-Item -ItemType Directory -Path bay/db/rou -Force | Out-Null
New-Item -ItemType Directory -Path bay/jrn/jrn -Force | Out-Null
New-Item -ItemType Directory -Path bay/jrn/alt -Force | Out-Null
New-Item -ItemType Directory -Path bay/sys -Force | Out-Null
New-Item -ItemType Directory -Path tam/code -Force | Out-Null
New-Item -ItemType Directory -Path tam/db/rou -Force | Out-Null
New-Item -ItemType Directory -Path tam/jrn/jrn -Force | Out-Null
New-Item -ItemType Directory -Path tam/jrn/alt -Force | Out-Null
New-Item -ItemType Directory -Path tam/sys -Force | Out-Null
New-Item -ItemType Directory -Path wpb/code -Force | Out-Null
New-Item -ItemType Directory -Path wpb/db/rou -Force | Out-Null
New-Item -ItemType Directory -Path wpb/jrn/jrn -Force | Out-Null
New-Item -ItemType Directory -Path wpb/jrn/alt -Force | Out-Null
New-Item -ItemType Directory -Path wpb/sys -Force | Out-Null

New-Item -ItemType Directory -Path v08/code -Force | Out-Null
New-Item -ItemType Directory -Path v08/db/v08/bay/rou -Force | Out-Null
New-Item -ItemType Directory -Path v08/db/v08/tam/rou -Force | Out-Null
New-Item -ItemType Directory -Path v08/db/v08/wpb/rou -Force | Out-Null
New-Item -ItemType Directory -Path v08/jrn/jrn -Force | Out-Null
New-Item -ItemType Directory -Path v08/jrn/alt -Force | Out-Null
New-Item -ItemType Directory -Path v08/sys -Force | Out-Null

New-Item -ItemType Directory -Path vx130/code -Force | Out-Null
New-Item -ItemType Directory -Path vx130/db/vx130/vx130data -Force | Out-Null
New-Item -ItemType Directory -Path vx130/db/vx130/vx130code -Force | Out-Null
New-Item -ItemType Directory -Path vx130/jrn/jrn -Force | Out-Null
New-Item -ItemType Directory -Path vx130/jrn/alt -Force | Out-Null
New-Item -ItemType Directory -Path vx130/sys -Force | Out-Null

$current_directory = (pwd).path
docker run -v $current_directory\bay\code:/code -v $current_directory\bay\sys:/irissys -v $current_directory\bay\db:/irisdb -v $current_directory\bay\jrn:/irisjrn --name bay -d intersystems/iris:2023.1.0.218.0
docker run -v $current_directory\tam\code:/code -v $current_directory\tam\sys:/irissys -v $current_directory\tam\db:/irisdb -v $current_directory\tam\jrn:/irisjrn --name tam -d intersystems/iris:2023.1.0.218.0
docker run -v $current_directory\wpb\code:/code -v $current_directory\wpb\sys:/irissys -v $current_directory\wpb\db:/irisdb -v $current_directory\wpb\jrn:/irisjrn --name wpb -d intersystems/iris:2023.1.0.218.0
docker run -v $current_directory\v08\code:/code -v $current_directory\v08\sys:/irissys -v $current_directory\v08\db:/irisdb -v $current_directory\v08\jrn:/irisjrn --name v08 -d intersystems/iris:2023.1.0.218.0
docker run -v $current_directory\vx130\code:/code -v $current_directory\vx130\sys:/irissys -v $current_directory\vx130\db:/irisdb -v $current_directory\vx130\jrn:/irisjrn --name vx130 -d intersystems/iris:2023.1.0.218.0
sleep 20

docker exec -it --user root bay chown -R irisowner:irisowner /irisdb /irisjrn /irissys /code
docker exec -it --user root tam chown -R irisowner:irisowner /irisdb /irisjrn /irissys /code
docker exec -it --user root wpb chown -R irisowner:irisowner /irisdb /irisjrn /irissys /code
docker exec -it --user root v08 chown -R irisowner:irisowner /irisdb /irisjrn /irissys /code
docker exec -it --user root vx130 chown -R irisowner:irisowner /irisdb /irisjrn /irissys /code

docker cp vistaInstaller.cls bay:/code/
docker cp vistaInstaller.cls tam:/code/
docker cp vistaInstaller.cls wpb:/code/
docker cp v08Installer.cls v08:/code/
docker cp vx130Installer.cls vx130:/code/
docker cp src vx130:/code/

docker stop bay
docker stop tam
docker stop wpb
docker stop v08
docker stop vx130

docker rm bay
docker rm tam
docker rm wpb
docker rm v08
docker rm vx130







