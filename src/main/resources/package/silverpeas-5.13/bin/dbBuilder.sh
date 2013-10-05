#!/bin/bash
# ------ dbBuilder -----------

#test d'existance de la variable SILVERPEAS_HOME
if [ "x${SILVERPEAS_HOME}" = "x" -o "${SILVERPEAS_HOME}" = "" ];then
echo La variable SILVERPEAS_HOME doit etre initialisee
exit 1
fi

VERBOSEPARAM=-v
ACTIONPARAM=-I

SRV_SERVERTYPE=H2
SILVERPEAS_DATA=/home/mmoquillon/Projets/silverpeas-integration/Silverpeas-Izpack-Installer/src/main/silverpeas_preparation_scripts/../resources/package/silverpeas-5.13
SILVERPEAS_PROPERTIES=$SILVERPEAS_HOME/properties

LINEARGS="-T $SRV_SERVERTYPE $ACTIONPARAM $VERBOSEPARAM"

JARDIR=$SILVERPEAS_HOME/bin/jar
for jarlib in `ls $JARDIR`; do
CLASSPATH=$CLASSPATH:$JARDIR/$jarlib
done
export CLASSPATH

exec $JAVA_HOME/bin/java -classpath $CLASSPATH -Ddbbuilder.home=$SILVERPEAS_HOME -Ddbbuilder.data=$SILVERPEAS_DATA org.silverpeas.dbbuilder.DBBuilder $LINEARGS
