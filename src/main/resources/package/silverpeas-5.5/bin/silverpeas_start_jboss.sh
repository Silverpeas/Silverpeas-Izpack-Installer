#!/bin/sh
# ------ silverpeas_start_jboss.sh -----------

export SILVERPEAS_HOME=${INSTALL_PATH}
export JBOSS_HOME=${INSTALL_PATH}/jboss403
export JAVA_HOME=${JAVA_HOME}

cd $JBOSS_HOME/bin

export JAVA_OPTS="-server -Xms512m -Xmx512m -XX:MaxPermSize=128m -Dorg.jboss.logging.Log4jService.catchSystemOut=false "
# Add Silverpeas Properties root repository to path
#JBOSS_CLASSPATH=$SILVERPEAS_HOME/properties
#export JBOSS_CLASSPATH

sh run.sh &
