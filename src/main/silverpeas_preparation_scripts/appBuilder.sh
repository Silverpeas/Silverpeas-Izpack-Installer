#!/bin/bash
# ------Application Builder -----------
#export SILVERPEAS_HOME=/home/ehugonnet/silver-dev/tools/Silverpeas-Izpack-Installer/src/main/resources/package/silverpeas-5.12

#test d'existance de la variable SILVERPEAS_HOME
if [ "x${SILVERPEAS_HOME}" = "x" -o "${SILVERPEAS_HOME}" = "" ];then
  echo La variable SILVERPEAS_HOME doit etre initialisee
  exit 1
fi

export LIB_ROOT

JARDIR=$SILVERPEAS_HOME/bin/jar
for jarlib in `ls $JARDIR`; do
  CLASSPATH=$CLASSPATH:$JARDIR/$jarlib
done
export CLASSPATH

exec $JAVA_HOME/bin/java -classpath $CLASSPATH -Dsilverpeas.home=$SILVERPEAS_HOME org.silverpeas.applicationbuilder.ApplicationBuilder -r ext_repository $1
