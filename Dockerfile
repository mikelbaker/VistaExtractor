# Start with latest iris image
FROM intersystems/iris:2022.1.2.574.0
# change to root user
USER root
# Create a directory for the IRIS system files
RUN mkdir /irissys /irisdb /irisjrn /irisdb/rou \
  && chown 51773:51773 /irissys /irisdb /irisjrn /irisdb/rou
# change back to iris user
USER 51773
# add key and users to image
COPY iris.key UsersExport.xml ConfigureIris.bat Installer.cls %ZSTART.mac /usr/irissys/mgr/
# Add Users and run Manifest
RUN iris start IRIS \
 && iris session IRIS < /usr/irissys/mgr/ConfigureIris.bat \
 && iris stop IRIS quietly


