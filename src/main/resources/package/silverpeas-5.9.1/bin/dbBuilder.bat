@echo off

set SILVERPEAS_HOME=${INSTALL_PATH}

set VERBOSEPARAM=-v
set ACTIONPARAM=-I

set SRV_SERVERTYPE=H2
set SILVERPEAS_DATA=D:\Silverpeas
set SILVERPEAS_PROPERTIES=%SILVERPEAS_HOME%/properties

set LINEARGS=-T %SRV_SERVERTYPE% %ACTIONPARAM% %VERBOSEPARAM%

set LIB_ROOT=%SILVERPEAS_HOME%/bin/jar

set CLASSPATH=%SILVERPEAS_HOME%\bin\jar\application-builder.jar;%SILVERPEAS_HOME%\bin\jar\jdom.jar;%SILVERPEAS_HOME%\bin\jar\commons-io.jar;%SILVERPEAS_HOME%\bin\jar\fileutil.jar;%SILVERPEAS_HOME%\bin\jar\bsh.jar;%SILVERPEAS_HOME%\bin\jar\dbbuilder.jar;%SILVERPEAS_HOME%\bin\jar\spring-beans.jar;%SILVERPEAS_HOME%\bin\jar\spring-core.jar;%SILVERPEAS_HOME%\bin\jar\spring-context.jar;%SILVERPEAS_HOME%\bin\jar\spring-aop.jar;%SILVERPEAS_HOME%\bin\jar\aopalliance.jar;%SILVERPEAS_HOME%\bin\jar\spring-expression.jar;%SILVERPEAS_HOME%\bin\jar\spring-asm.jar;%SILVERPEAS_HOME%\bin\jar\commons-dbcp.jar;%SILVERPEAS_HOME%\bin\jar\commons-pool.jar;%SILVERPEAS_HOME%\bin\jar\commons-logging.jar;%SILVERPEAS_HOME%\bin\jar\slf4j-api.jar;%SILVERPEAS_HOME%\bin\jar\slf4j-log4j12.jar;%SILVERPEAS_HOME%\bin\jar\jcl-over-slf4j.jar;%SILVERPEAS_HOME%\bin\jar\log4j.jar;%SILVERPEAS_HOME%\bin\jar\silverpeas-settings.jar;%SILVERPEAS_HOME%\bin\jar\groovy-all.jar;%SILVERPEAS_HOME%\bin\jar\postgresql.jar;%SILVERPEAS_HOME%\bin\jar\jtds.jar;%SILVERPEAS_HOME%\bin\jar\h2.jar

${JDKPath}\bin\java -classpath "%CLASSPATH%" -Ddbbuilder.home="%SILVERPEAS_HOME%" -Ddbbuilder.data="%SILVERPEAS_DATA%" org.silverpeas.dbbuilder.DBBuilder %LINEARGS%

echo.

pause
