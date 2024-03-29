# Start with latest iris image
#FROM intersystems/iris:2022.1.2.574.0
FROM intersystems/irishealth:2023.2.0.201.0
# change to root user
USER root
# Create a directory for the IRIS system files
RUN mkdir /irissys /irisdb /irisjrn \
  && chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /irissys /irisdb /irisjrn 
# change back to iris user
USER ${ISC_PACKAGE_MGRUSER}
# add key and users to image
COPY iris.key UsersExport.xml ConfigureIris.bat %ZSTART.mac /usr/irissys/mgr/
# Add Users and run Manifest
RUN iris start IRIS \
 && iris session IRIS < /usr/irissys/mgr/ConfigureIris.bat \
 && iris stop IRIS quietly


