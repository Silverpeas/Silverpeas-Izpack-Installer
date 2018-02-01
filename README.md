Silverpeas-Izpack-Installer
===========================

Izpack Installer for Silverpeas

To build a new Izpack installation archive of Silverpeas, follow the below statements:
- Change the project version in the <code>pom.xml</code> to match the version of Silverpeas to pack.
- Change the <code>wildfly.version</code> property to the version of the Wildfly distribution that is supported by the version of Silverpeas to pack.
- Build the Izpack installation archive:
```
$ mvn clean install
```
