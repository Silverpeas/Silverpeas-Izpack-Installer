@echo off
set SILVERPEAS_HOME=${INSTALL_PATH}
set VERBOSEPARAM=-v
set ACTIONPARAM=-I

set SRV_SERVERTYPE=H2
set SILVERPEAS_DATA=%SILVERPEAS_HOME%
set SILVERPEAS_PROPERTIES=%SILVERPEAS_HOME%/properties

set LINEARGS=-T %SRV_SERVERTYPE% %ACTIONPARAM% %VERBOSEPARAM%

set LIB_ROOT=%SILVERPEAS_HOME%/bin/jar

set CLASSPATH=%SILVERPEAS_HOME%\bin\jar\*

${JDKPath}\bin\java -classpath "%CLASSPATH%" -Ddbbuilder.home="%SILVERPEAS_HOME%" -Ddbbuilder.data="%SILVERPEAS_DATA%" org.silverpeas.dbbuilder.DBBuilder %LINEARGS%

echo.

pause
