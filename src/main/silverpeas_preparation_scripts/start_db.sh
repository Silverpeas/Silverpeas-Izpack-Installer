#!/bin/sh
# -------- Start H2 ---------

#test the SILVERPEAS_HOME environment variable is set
if [ "x${SILVERPEAS_HOME}" = "x" -o "${SILVERPEAS_HOME}" = "" ];then
echo "The environment variable SILVERPEAS_HOME must be set!"
exit 1
fi

exec $JAVA_HOME/bin/java -classpath $SILVERPEAS_HOME/bin/jar/h2.jar org.h2.tools.Server -tcp -baseDir $SILVERPEAS_HOME/../h2 -trace
