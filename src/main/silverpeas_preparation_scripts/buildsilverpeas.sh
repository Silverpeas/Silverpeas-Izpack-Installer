#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Error, expected one argument: the version of silverpeas to prepare"
  echo "$0 [SILVERPEAS_VERSION]"
  exit 1
elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
  echo "$0 [SILVERPEAS_VERSION]"
  exit 0
fi

SILVERPEAS_VERSION="$1"
echo "Prepare Silverpeas $1"

MAIN_VERSION=$SILVERPEAS_VERSION
MINOR_VERSION=`echo $SILVERPEAS_VERSION | cut -d '.' -f 3`
test "$MINOR_VERSION" != "" && MAIN_VERSION=${SILVERPEAS_VERSION%??}

cd `dirname $0`
export SCRIPTS_HOME=$PWD
echo SCRIPTS_HOME = $SCRIPTS_HOME
export SILVERPEAS_HOME=$SCRIPTS_HOME/../resources/package/silverpeas-$MAIN_VERSION

offline="-o"
test $# -gt 0 && offline=""

echo "Get Silverpeas ${SILVERPEAS_VERSION}"
wget http://www.silverpeas.org/files/silverpeas-${SILVERPEAS_VERSION}-jboss6.tar.gz
test $? -eq 0 && tar zxvf silverpeas-${SILVERPEAS_VERSION}-jboss6.tar.gz
test $? -eq 0 && cp -r silverpeas-${SILVERPEAS_VERSION}*-jboss6/bin/pom.xml silverpeas-${SILVERPEAS_VERSION}*-jboss6/bin/jar silverpeas-${SILVERPEAS_VERSION}*-jboss6/bin/scripts $SILVERPEAS_HOME/bin
rm -rf $SILVERPEAS_HOME/setup/appserver/jboss6
cp -r silverpeas-${SILVERPEAS_VERSION}*-jboss6/setup/appserver/jboss6 $SILVERPEAS_HOME/setup/appserver
test $? -eq 0 && rm -rf silverpeas-${SILVERPEAS_VERSION}*-jboss6*
status=$?
test $status -eq 0 || exit $status

cd "$SILVERPEAS_HOME/bin"
mvn clean install $offline
cp $SCRIPTS_HOME/config.properties $SILVERPEAS_HOME/setup/settings/.
test $? -eq 0 && $SCRIPTS_HOME/appBuilder.sh
test $? -eq 0 && $SCRIPTS_HOME/SilverpeasSettings.sh
test $? -eq 0 && $SCRIPTS_HOME/start_db.sh &
test $? -eq 0 && $SCRIPTS_HOME/dbBuilder.sh
test $? -eq 0 && $SCRIPTS_HOME/stop_db.sh &
exit $?
