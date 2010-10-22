@echo off

set VERBOSEPARAM=-v
set ACTIONPARAM=-I

set SRV_SERVERTYPE=postgres
set SILVERPEAS_DATA=%SILVERPEAS_HOME%
set SILVERPEAS_PROPERTIES=%SILVERPEAS_HOME%\properties

set LINEARGS=-T %SRV_SERVERTYPE% %ACTIONPARAM% %VERBOSEPARAM%

set LIB_ROOT=%SILVERPEAS_HOME%\bin\jar

set CLASSPATH=%SILVERPEAS_HOME%\bin\jar\h2.jar;%SILVERPEAS_HOME%\bin\jar\application-builder.jar;%SILVERPEAS_HOME%\bin\jar\dbbuilder.jar;%SILVERPEAS_HOME%\bin\jar\fileutil.jar;%SILVERPEAS_HOME%\bin\jar\silverpeas-settings.jar;%SILVERPEAS_HOME%\bin\jar\commons-dbcp.jar;%SILVERPEAS_HOME%\bin\jar\commons-io.jar;%SILVERPEAS_HOME%\bin\jar\commons-logging.jar;%SILVERPEAS_HOME%\bin\jar\commons-pool.jar;%SILVERPEAS_HOME%\bin\jar\activation.jar;%SILVERPEAS_HOME%\bin\jar\mail.jar;%SILVERPEAS_HOME%\bin\jar\log4j.jar;%SILVERPEAS_HOME%\bin\jar\jtds.jar;%SILVERPEAS_HOME%\bin\jar\bsh.jar;%SILVERPEAS_HOME%\bin\jar\jdom.jar;%SILVERPEAS_HOME%\bin\jar\jcl-over-slf4j.jar;%SILVERPEAS_HOME%\bin\jar\slf4j-api.jar;%SILVERPEAS_HOME%\bin\jar\slf4j-log4j12.jar;%SILVERPEAS_HOME%\bin\jar\spring.jar;%SILVERPEAS_HOME%\bin\jar\postgresql.jar

java -classpath "%CLASSPATH%" -Ddbbuilder.home="%SILVERPEAS_HOME%" -Ddbbuilder.data="%SILVERPEAS_DATA%" com.silverpeas.dbbuilder.DBBuilder %LINEARGS%

echo.

pause