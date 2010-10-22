#!/bin/sh
# ------ silverpeas_stop_jboss.sh -----------

export SILVERPEAS_HOME=${INSTALL_PATH}
export JBOSS_HOME=${INSTALL_PATH}/jboss403
export JAVA_HOME=${JAVA_HOME}

cd $JBOSS_HOME/bin

sh shutdown.sh -S