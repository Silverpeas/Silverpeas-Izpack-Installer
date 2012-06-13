#!/bin/sh
# -------- Start H2 ---------

export CLASSPATH=${INSTALL_PATH}/bin/jar/h2.jar

exec ${JDKPath}/bin/java -classpath $CLASSPATH org.h2.tools.Server -tcp -baseDir /home/ehugonnet/tmp/Silverpeas/h2 -trace
