@echo off
set JBOSS_HOME=${INSTALL_PATH}\jboss-6.1.0.Final
set JAVA_HOME=${jdkPath}

cd /d "%JBOSS_HOME%/bin"

set username=admin
set password=admin

call shutdown.bat -u %username% -p %password% -S

if ERRORLEVEL 1 pause
