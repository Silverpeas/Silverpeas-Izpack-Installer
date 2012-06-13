#!/bin/sh
# -------- Stop H2 ---------

export JAVA_HOME=${INSTALL_PATH}
export CLASSPATH=/home/ehugonnet/tmp/Silverpeas/bin/jar/h2.jar

exec ${JDKPath}/bin/java -classpath $CLASSPATH org.h2.tools.Server -tcpShutdown tcp://localhost:9092
