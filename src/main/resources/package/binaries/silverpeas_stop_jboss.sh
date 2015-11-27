#!/bin/sh
# ------ silverpeas_stop_jboss.sh -----------
export SILVERPEAS_HOME=${INSTALL_PATH}
export JBOSS_HOME=${INSTALL_PATH}/jboss-6.1.0.Final/
export JAVA_HOME=${jdkPath}

cd $JBOSS_HOME/bin

username=bmegukldl
password=5e7e3440-36bd-42a2-99f6-1feda6a7dc73

sh shutdown.sh -u $username -p $password -S
