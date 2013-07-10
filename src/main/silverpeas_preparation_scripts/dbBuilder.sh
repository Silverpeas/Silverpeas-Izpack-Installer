#!/bin/bash
# ------ dbBuilder -----------


#test the SILVERPEAS_HOME environment variable is set
if [ "x${SILVERPEAS_HOME}" = "x" -o "${SILVERPEAS_HOME}" = "" ];then
echo "The environment variable SILVERPEAS_HOME must be set!"
exit 1
fi

VERBOSEPARAM=-v
ACTIONPARAM=-I

SRV_SERVERTYPE=H2
SILVERPEAS_DATA=$SILVERPEAS_HOME/
SILVERPEAS_PROPERTIES=$SILVERPEAS_HOME/properties

LINEARGS="-T $SRV_SERVERTYPE $ACTIONPARAM $VERBOSEPARAM"

JARDIR=$SILVERPEAS_HOME/bin/jar
for jarlib in `ls $JARDIR`; do
CLASSPATH=$CLASSPATH:$JARDIR/$jarlib
done
export CLASSPATH

exec $JAVA_HOME/bin/java -classpath $CLASSPATH -Ddbbuilder.home=$SILVERPEAS_HOME -Ddbbuilder.data=$SILVERPEAS_DATA org.silverpeas.dbbuilder.DBBuilder $LINEARGS
