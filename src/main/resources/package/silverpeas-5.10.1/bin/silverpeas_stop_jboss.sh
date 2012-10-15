#!/bin/sh
# ------ silverpeas_stop_jboss.sh -----------

export JBOSS_HOME=${INSTALL_PATH}/jboss-6.1.0.Final
export JAVA_HOME=${JDKPath}

cd $JBOSS_HOME/bin

username=admin
password=admin

sh shutdown.sh -u $username -p $password -S
