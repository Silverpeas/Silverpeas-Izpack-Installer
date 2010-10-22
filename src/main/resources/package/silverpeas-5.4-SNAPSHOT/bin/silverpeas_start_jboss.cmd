@echo off

set SILVERPEAS_HOME=${INSTALL_PATH}
set JBOSS_HOME=${INSTALL_PATH}\jboss403
set JAVA_HOME=%{JAVA_HOME}%

cd "%JBOSS_HOME%\server\default\deploy"

del silverpeas.ear.bak*
del silverpeas-ds.xml.bak*

cd "%JBOSS_HOME%\server\default\deploy\jms"

del silverpeas-destinations-service.xml.bak*

cd "%JBOSS_HOME%/bin"

rem Add Silverpeas Properties root repository to path
rem SET JBOSS_CLASSPATH=%SILVERPEAS_HOME%/properties
SET JAVA_OPTS=-Xms512m -Xmx512m -XX:MaxPermSize=128m -Dorg.jboss.logging.Log4jService.catchSystemOut=false

call run.bat

if ERRORLEVEL 1 pause
