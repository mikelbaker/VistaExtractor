# Start with latest iris image
#FROM intersystems/iris:2022.1.2.574.0
FROM container.intersystems.com/intersystems/irishealth:2024.1
# change to root user
USER root
# add key and users to image
COPY iris.key UsersExport.xml ConfigureIris.bat %ZSTART.mac /usr/irissys/mgr/
# Create a directory for the IRIS system files
RUN mkdir /irissys /irisdb /irisjrn \
  && chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /irissys /irisdb /irisjrn \
  && chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /usr/irissys/mgr/ 
# change back to iris user
USER ${ISC_PACKAGE_MGRUSER}

# Add Users and run Manifest
RUN iris start IRIS \
 && iris session IRIS < /usr/irissys/mgr/ConfigureIris.bat \
 && iris stop IRIS quietly


