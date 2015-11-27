#!/bin/sh
# -------- Stop H2 ---------

CLASSPATH=${INSTALL_PATH}/bin/jar/h2.jar

exec ${jdkPath}/bin/java -classpath $CLASSPATH org.h2.tools.Server -tcpShutdown tcp://localhost:9092
