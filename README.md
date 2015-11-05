Silverpeas-Izpack-Installer
===========================

Izpack Installer for Silverpeas

To build a new Izpack installation archive of Silverpeas, follow the below statements:
- Go to the src/main/silverpeas_preparation_scripts/ folder
- Run the Bash script buildsilverpeas.sh with as argument the version number of Silverpeas to prepare. For example:
```
$ ./buildsilverpeas.sh 5.14
```
- Go back the main project directory
- Build of the Izpack installation archive:
```
$ mvn clean install
```
