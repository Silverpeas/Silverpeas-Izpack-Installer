#!/bin/sh
# -------- Start H2 ---------

export CLASSPATH=${INSTALL_PATH}/bin/jar/h2.jar
exec ${jdkPath}/bin/java -classpath $CLASSPATH org.h2.tools.Server -tcp -baseDir ${INSTALL_PATH}/h2 -trace


