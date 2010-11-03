#!/bin/sh
# -------- Start H2 ---------

export JAVA_HOME=${JAVA_HOME}
export CLASSPATH=${INSTALL_PATH}/bin/jar/h2.jar

exec $JAVA_HOME/bin/java -classpath $CLASSPATH org.h2.tools.Server -tcp -baseDir ${INSTALL_PATH}/h2 -trace
