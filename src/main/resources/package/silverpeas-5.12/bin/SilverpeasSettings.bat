@echo off

set SILVERPEAS_HOME=${INSTALL_PATH}
set JBOSS_HOME=${INSTALL_PATH}\jboss-6.1.0.Final
set JAVA_HOME=${JDKPath}

set SETUP_ROOT=%SILVERPEAS_HOME%/setup/settings
set CLASSPATH=%SILVERPEAS_HOME%\bin\jar\*

"%JAVA_HOME%\bin\java" -classpath "%CLASSPATH%" -Dsilverpeas.home="%SILVERPEAS_HOME%" org.silverpeas.settings.SilverpeasSettings
