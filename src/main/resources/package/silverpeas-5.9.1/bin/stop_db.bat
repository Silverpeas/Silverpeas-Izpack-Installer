set CLASSPATH=D:\Silverpeas/bin/jar/h2.jar
set JAVA_HOME=C:\Program Files (x86)\Java\jre7
"%JAVA_HOME%/bin/java" -classpath %CLASSPATH% org.h2.tools.Server -tcpShutdown tcp://localhost:9092