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
echo "Prepare Silverpeas $1 for packaging"

MAIN_VERSION=${SILVERPEAS_VERSION}
MINOR_VERSION=`echo ${SILVERPEAS_VERSION} | cut -d '.' -f 3`
test "${MINOR_VERSION}" != "" && MAIN_VERSION=${SILVERPEAS_VERSION%??}

cd `dirname $0`
SCRIPTS_HOME=$PWD
SETTINGS="${SCRIPTS_HOME}/../resources/package/settings"
UNIX_SETTINGS="${SETTINGS}/unix"
WINDOWS_SETTINGS="${SETTINGS}/windows"
export SILVERPEAS_HOME="${SCRIPTS_HOME}/../resources/package/silverpeas-${MAIN_VERSION}"
export JBOSS_HOME="${SCRIPTS_HOME}/jboss-6.1.0.Final"

offline="-o"
test $# -gt 0 && offline=""

echo "  -> unzip JBoss distribution..."
unzip "${SCRIPTS_HOME}/../resources/package/jboss-6.1.0.Final.zip" -d "${SCRIPTS_HOME}"

echo "  -> get Silverpeas ${SILVERPEAS_VERSION} for both Unix and Windows..."
rm -rf ${SILVERPEAS_HOME}/../silverpeas-*
rm ${SILVERPEAS_HOME}/../h2/*
pushd ${UNIX_SETTINGS}
rm *
wget -c https://github.com/Silverpeas/Silverpeas-installer-package/raw/installation-${SILVERPEAS_VERSION}/src/main/config/settings/jboss6/linux/JBossSettings.xml
wget -c https://github.com/Silverpeas/Silverpeas-installer-package/raw/installation-${SILVERPEAS_VERSION}/src/main/config/settings/jboss6/linux/SilverpeasSettings.xml
popd
pushd ${WINDOWS_SETTINGS}
rm *
wget -c https://github.com/Silverpeas/Silverpeas-installer-package/raw/installation-${SILVERPEAS_VERSION}/src/main/config/settings/jboss6/windows/JBossSettings.xml
wget -c https://github.com/Silverpeas/Silverpeas-installer-package/raw/installation-${SILVERPEAS_VERSION}/src/main/config/settings/jboss6/windows/SilverpeasSettings.xml
popd
wget -c http://www.silverpeas.org/files/silverpeas-${SILVERPEAS_VERSION}-jboss6.tar.gz
test $? -eq 0 && tar zxvf silverpeas-${SILVERPEAS_VERSION}-jboss6.tar.gz
test $? -eq 0 && cp -r silverpeas-${SILVERPEAS_VERSION}*-jboss6 ${SILVERPEAS_HOME}
test $? -eq 0 && rm -rf silverpeas-${SILVERPEAS_VERSION}*-jboss6*
status=$?
test ${status} -eq 0 || exit ${status}
echo "println 'Nothing to do'" > ${SILVERPEAS_HOME}/bin/scripts/configureSpnego.groovy

echo "  -> copy Silverpeas binaries and settings..."
cp ${SETTINGS}/config.properties ${SILVERPEAS_HOME}/setup/settings/
cp ${SETTINGS}/CustomerSettings.xml ${SETTINGS}/config.properties ${WINDOWS_SETTINGS}/
cp ${SETTINGS}/CustomerSettings.xml ${SETTINGS}/config.properties ${UNIX_SETTINGS}/

echo "  -> build Silverpeas..."
mkdir -p "${SCRIPTS_HOME}/../resources/package/h2" &> /dev/null
cd "${SILVERPEAS_HOME}/bin"
mvn clean install ${offline}
test $? -eq 0 && ${SCRIPTS_HOME}/appBuilder.sh
test $? -eq 0 && ${SCRIPTS_HOME}/SilverpeasSettings.sh
test $? -eq 0 && ${SCRIPTS_HOME}/start_db.sh &
test $? -eq 0 && ${SCRIPTS_HOME}/dbBuilder.sh
test $? -eq 0 && ${SCRIPTS_HOME}/stop_db.sh &
res=$?

rm -rf "${JBOSS_HOME}"

exit $res
