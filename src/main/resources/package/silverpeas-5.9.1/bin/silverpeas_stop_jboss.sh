#!/bin/sh
# ------ silverpeas_stop_jboss.sh -----------

export JBOSS_HOME=${INSTALL_PATH}/jboss-6.1.0.Final
export JAVA_HOME=${JDKPath}

cd $JBOSS_HOME/bin

username=uixfeofrn
password=1ae50098-10ba-4699-8daf-13d09a4261bf

sh shutdown.sh -u $username -p $password -S
