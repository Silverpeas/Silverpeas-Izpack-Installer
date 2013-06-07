#!/bin/sh
# -------- Stop H2 ---------
exec $JAVA_HOME/bin/java -classpath $SILVERPEAS_HOME/bin/jar/h2.jar org.h2.tools.Server -tcpShutdown tcp://localhost:9092
