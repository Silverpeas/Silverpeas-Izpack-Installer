#!/usr/bin/env bash

SILVERPEAS_VERSION=5.12

export SCRIPTS_HOME=$PWD
echo SCRIPTS_HOME = $SCRIPTS_HOME
export SILVERPEAS_HOME=$SCRIPTS_HOME/../resources/package/silverpeas-${SILVERPEAS_VERSION}

offline="-o"
test $# -gt 0 && offline=""

echo "Get Silverpeas ${SILVERPEAS_VERSION}"
wget http://www.silverpeas.org/files/silverpeas-${SILVERPEAS_VERSION}-jboss6.tar.gz
tar zxvf silverpeas-${SILVERPEAS_VERSION}-jboss6.tar.gz
cp -r silverpeas-${SILVERPEAS_VERSION}*-jboss6/bin/jar silverpeas-${SILVERPEAS_VERSION}*-jboss6/bin/scripts $SILVERPEAS_HOME/bin
rm -rf silverpeas-${SILVERPEAS_VERSION}*-jboss6*

cd "$SILVERPEAS_HOME/bin"
mvn clean install $offline
cp $SCRIPTS_HOME/config.properties $SILVERPEAS_HOME/setup/settings/.
test $? -eq 0 && $SCRIPTS_HOME/appBuilder.sh
test $? -eq 0 && $SCRIPTS_HOME/SilverpeasSettings.sh
test $? -eq 0 && $SCRIPTS_HOME/start_db.sh &
test $? -eq 0 && $SCRIPTS_HOME/dbBuilder.sh
test $? -eq 0 && $SCRIPTS_HOME/stop_db.sh &
exit $?
