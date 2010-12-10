@echo off

set SILVERPEAS_HOME=${INSTALL_PATH}
set JBOSS_HOME=${INSTALL_PATH}\jboss403
set JAVA_HOME=%{JAVA_HOME}%

cd "%JBOSS_HOME%/bin"

call shutdown.bat -S

if ERRORLEVEL 1 pause
