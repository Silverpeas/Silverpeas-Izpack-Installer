#!/bin/bash
# ------Application Builder -----------

#test the SILVERPEAS_HOME environment variable is set
if [ "x${SILVERPEAS_HOME}" = "x" -o "${SILVERPEAS_HOME}" = "" ];then
echo "The environment variable SILVERPEAS_HOME must be set!"
exit 1
fi

export LIB_ROOT

JARDIR=$SILVERPEAS_HOME/bin/jar
for jarlib in `ls $JARDIR`; do
  CLASSPATH=$CLASSPATH:$JARDIR/$jarlib
done
export CLASSPATH

exec $JAVA_HOME/bin/java -classpath $CLASSPATH -Dsilverpeas.home=$SILVERPEAS_HOME org.silverpeas.applicationbuilder.ApplicationBuilder -r ext_repository $1
