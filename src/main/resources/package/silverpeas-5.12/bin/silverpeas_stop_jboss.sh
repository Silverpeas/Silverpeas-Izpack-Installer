#!/bin/sh
# ------ silverpeas_stop_jboss.sh -----------
export SILVERPEAS_HOME=${INSTALL_PATH}
export JBOSS_HOME=${INSTALL_PATH}/jboss-6.1.0.Final/
export JAVA_HOME=${JDKPath}

cd $JBOSS_HOME/bin

username=vtkxeotnm
password=008a3948-219a-4983-927a-68767f079fec

sh shutdown.sh -u $username -p $password -S
