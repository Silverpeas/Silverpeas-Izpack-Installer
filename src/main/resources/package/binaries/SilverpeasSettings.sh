#!/bin/sh
# -------- Active Settings ---------
export SILVERPEAS_HOME=${INSTALL_PATH}
export JBOSS_HOME=${INSTALL_PATH}/jboss-6.1.0.Final/

#test d'existance de la variable SILVERPEAS_HOME
if [ "x${SILVERPEAS_HOME}" = "x" -o "${SILVERPEAS_HOME}" = "" ];then
  echo La variable SILVERPEAS_HOME doit etre initialisee
  exit 1
fi

SETUP_ROOT=$SILVERPEAS_HOME/setup/settings

JARDIR=$SILVERPEAS_HOME/bin/jar
for jarlib in `ls $JARDIR`; do
  CLASSPATH=$CLASSPATH:$JARDIR/$jarlib
done
export CLASSPATH


exec ${JDKPath}/bin/java -classpath $CLASSPATH -Dsilverpeas.home=$SILVERPEAS_HOME org.silverpeas.settings.SilverpeasSettings

