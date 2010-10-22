#!/bin/sh
# -------- Stop H2 ---------

export JAVA_HOME=${JAVA_HOME}
export CLASSPATH=${INSTALL_PATH}/bin/jar/h2.jar

exec $JAVA_HOME/bin/java -classpath $CLASSPATH org.h2.tools.Server -tcpShutdown tcp://localhost:9092
