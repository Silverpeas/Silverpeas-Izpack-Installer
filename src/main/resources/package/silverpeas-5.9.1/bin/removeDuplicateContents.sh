#!/bin/bash
# ------ dbBuilder -----------

#test d'existance de la variable SILVERPEAS_HOME
if [ "x${SILVERPEAS_HOME}" = "x" -o "${SILVERPEAS_HOME}" = "" ];then
echo La variable SILVERPEAS_HOME doit etre initialisee
exit 1
fi

CLASSPATH=$SILVERPEAS_HOME/bin/jar/application-builder.jar:$SILVERPEAS_HOME/bin/jar/jdom.jar:$SILVERPEAS_HOME/bin/jar/commons-io.jar:$SILVERPEAS_HOME/bin/jar/fileutil.jar:$SILVERPEAS_HOME/bin/jar/bsh.jar:$SILVERPEAS_HOME/bin/jar/dbbuilder.jar:$SILVERPEAS_HOME/bin/jar/spring-beans.jar:$SILVERPEAS_HOME/bin/jar/spring-core.jar:$SILVERPEAS_HOME/bin/jar/spring-context.jar:$SILVERPEAS_HOME/bin/jar/spring-aop.jar:$SILVERPEAS_HOME/bin/jar/aopalliance.jar:$SILVERPEAS_HOME/bin/jar/spring-expression.jar:$SILVERPEAS_HOME/bin/jar/spring-asm.jar:$SILVERPEAS_HOME/bin/jar/commons-dbcp.jar:$SILVERPEAS_HOME/bin/jar/commons-pool.jar:$SILVERPEAS_HOME/bin/jar/commons-logging.jar:$SILVERPEAS_HOME/bin/jar/slf4j-api.jar:$SILVERPEAS_HOME/bin/jar/slf4j-log4j12.jar:$SILVERPEAS_HOME/bin/jar/jcl-over-slf4j.jar:$SILVERPEAS_HOME/bin/jar/log4j.jar:$SILVERPEAS_HOME/bin/jar/silverpeas-settings.jar:$SILVERPEAS_HOME/bin/jar/groovy-all.jar:$SILVERPEAS_HOME/bin/jar/postgresql.jar:$SILVERPEAS_HOME/bin/jar/jtds.jar:$SILVERPEAS_HOME/bin/jar/h2.jar
export CLASSPATH

echo $CLASSPATH

exec $JAVA_HOME/bin/java -classpath $CLASSPATH -Ddbbuilder.home=$SILVERPEAS_HOME org.silverpeas.migration.contentmanagement.DuplicateContentRemovingApplication 
