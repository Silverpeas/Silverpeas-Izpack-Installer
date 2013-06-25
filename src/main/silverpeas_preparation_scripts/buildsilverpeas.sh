#!/usr/bin/env bash

export SCRIPTS_HOME=$PWD
echo SCRIPTS_HOME = $SCRIPTS_HOME
export SILVERPEAS_HOME=$SCRIPTS_HOME/../resources/package/silverpeas-5.12

offline="-o"
test $# -gt 0 && offline=""

cd "$SILVERPEAS_HOME/bin"
mvn clean install $offline
cp $SCRIPTS_HOME/config.properties $SILVERPEAS_HOME/setup/setttings/.
test $? -eq 0 && $SCRIPTS_HOME/appBuilder.sh
test $? -eq 0 && $SCRIPTS_HOME/SilverpeasSettings.sh
test $? -eq 0 && $SCRIPTS_HOME/start_db.sh &
test $? -eq 0 && $SCRIPTS_HOME/dbBuilder.sh
test $? -eq 0 && $SCRIPTS_HOME/stop_db.sh &
exit $?
