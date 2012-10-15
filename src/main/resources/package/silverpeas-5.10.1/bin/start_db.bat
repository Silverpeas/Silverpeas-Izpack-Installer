set CLASSPATH=${INSTALL_PATH}/bin/jar/h2.jar
set JAVA_HOME=${JDKPath}
"%JAVA_HOME%/bin/java" -classpath "%CLASSPATH%" org.h2.tools.Server -tcp -baseDir "${INSTALL_PATH}/h2" -trace