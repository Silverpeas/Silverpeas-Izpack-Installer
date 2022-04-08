@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  Gradle startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

@rem Set NOPAUSE for JBoss/Wildfly command files to avoid they pause after execution
set NOPAUSE=1

@rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Set SILVERPEAS_HOME, JBOSS_HOME and JAVA_HOME
set SILVERPEAS_HOME=${INSTALL_PATH}
set JBOSS_HOME=${INSTALL_PATH}\wildfly
set JAVA_HOME=${jdkPath}
set H2_JAR=%JBOSS_HOME%\modules\system\layers\base\com\h2database\h2\main\'$H2_LIB'
set APP_HOME=${INSTALL_PATH}\bin
set APP_BASE_NAME=Silverpeas

@rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\gradle\wrapper\gradle-wrapper.jar

@rem Start H2 database
set stopAfter=0
for %%O in (%CMD_LINE_ARGS%) do (
  if "%%O" == "start" (
    echo Start H2 database...
    start /b "" "%JAVA_EXE%" -classpath "%H2_JAR%" org.h2.tools.Server -tcp -baseDir "%SILVERPEAS_HOME%\h2"
  ) else if "%%O" == "stop" (
    set stopAfter=1
  ) else if "%%O" == "migrate" (
    echo Start H2 database for DB migration....
    start /b "" "%JAVA_EXE%" -classpath "%H2_JAR%" org.h2.tools.Server -tcp -baseDir "%SILVERPEAS_HOME%\h2"
    set stopAfter=1
  ) else if "%%O" == "install" (
    echo Start H2 database for DB migration....
    start /b "" "%JAVA_EXE%" -classpath "%H2_JAR%" org.h2.tools.Server -tcp -baseDir "%SILVERPEAS_HOME%\h2"
    set stopAfter=1
  )
)

@rem Execute Gradle
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %GRADLE_OPTS% "-Dorg.gradle.appname=%APP_BASE_NAME%" -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain --no-daemon %CMD_LINE_ARGS%

@rem Stop H2 database
if %stopAfter% == 1 (
  echo Stop H2 database...
  call "%JAVA_EXE%" -classpath "%H2_JAR%" org.h2.tools.Server -tcpShutdown tcp://localhost:9092
)

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable GRADLE_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%GRADLE_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
