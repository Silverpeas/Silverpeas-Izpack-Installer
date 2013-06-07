#!/bin/sh
# -------- Start H2 ---------

#export SILVERPEAS_HOME=/home/ehugonnet/silver-dev/tools/Silverpeas-Izpack-Installer/src/main/resources/package/silverpeas-5.12
echo $SILVERPEAS_HOME
exec $JAVA_HOME/bin/java -classpath $SILVERPEAS_HOME/bin/jar/h2.jar org.h2.tools.Server -tcp -baseDir $SILVERPEAS_HOME/../h2 -trace
