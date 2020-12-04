import org.codehaus.plexus.util.FileUtils

import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths

String wildflyVersion = project.properties['wildfly.version'].split('\\.')[0]
String silverpeas = "silverpeas-${project.properties['silverpeas.version']}-wildfly${wildflyVersion}"
String wildfly = "wildfly-${project.properties['wildfly.version']}.Final"
AntBuilder ant = new AntBuilder()

// get the Silverpeas distribution and update the silverpeas.gradle to use the Aurora look
if (! new File("${project.build.directory}/${silverpeas}.zip").exists()) {
  ant.sequential {
    get(src: "https://www.silverpeas.org/files/${silverpeas}.zip",
        dest: "${project.build.directory}/${silverpeas}.zip",
        verbose: 'on')
    unzip(src: "${project.build.directory}/${silverpeas}.zip",
        dest: "${project.build.directory}")
    copy(file: "${project.basedir}/src/main/resources/package/bin/silverpeas.gradle",
        todir: "${project.build.directory}/${silverpeas}/bin", overwrite: true, force: true)
    replaceregexp(file: "${project.build.directory}/${silverpeas}/bin/silverpeas.gradle",
        match: 'version = \'\\$APP_VER\'',
        replace: "version = '${project.version}'",
        byline: true)
  }
}

// get the Wildfly distribution
if (! new File("${project.build.directory}/${wildfly}.zip").exists()) {
  ant.sequential {
    get(src: "https://www.silverpeas.org/files/${wildfly}.zip",
        dest: "${project.build.directory}/${wildfly}.zip",
        verbose: 'on')
    unzip(src: "${project.build.directory}/${wildfly}.zip",
        dest: "${project.build.directory}")
    move(file: "${project.build.directory}/${wildfly}",
        tofile: "${project.build.outputDirectory}/package/wildfly")
  }
}

// construct Silverpeas
Path gradleUserPath
if (System.properties['os.name'].toLowerCase().contains('windows')) {
  // we are on Windows (nobody can be perfect)
  gradleUserPath = Paths.get(System.getenv("USERPROFILE"), '.gradle')
  FileUtils.deleteDirectory(gradleUserPath.toString())
  ant.exec(executable: "${project.build.outputDirectory}/package/silverpeas/bin/silverpeas.bat",
      osfamily: 'windows') {
    env(key: 'JBOSS_HOME', value: "${project.build.outputDirectory}/package/wildfly")
    env(key: 'SILVERPEAS_HOME', value: "${project.build.outputDirectory}/package")
    arg(value: 'construct')
  }
} else {
  // we are on a more serious OS ... (Unix-like system)
  gradleUserPath = Paths.get(System.getenv("HOME"), '.gradle')
  FileUtils.deleteDirectory(gradleUserPath.toString())
  ant.chmod(file: "${project.build.directory}/${silverpeas}/bin/silverpeas",
      perm: "ugo+rx")
  ant.exec(executable: "${project.build.directory}/${silverpeas}/bin/silverpeas",
      osfamily: 'unix') {
    env(key: 'JBOSS_HOME', value: "${project.build.outputDirectory}/package/wildfly")
    arg(value: 'construct')
  }
}

ant.move(todir: "${project.build.outputDirectory}/package") {
  fileset(dir: "${project.build.directory}/${silverpeas}") {
    include(name: 'properties/**')
    include(name: 'xmlcomponents/**')
    include(name: 'resources/**')
    include(name: 'migrations/**')
    include(name: 'deployments/**')
    include(name: 'configuration/**')
    exclude(name: 'migrations/db/mssql/**')
    exclude(name: 'migrations/db/oracle/**')
    exclude(name: 'migrations/db/postgresql/**')
  }
  fileset(file: "${project.build.directory}/${silverpeas}/BUILD")
}

ant.move(todir: "${project.build.outputDirectory}/package/bin") {
  fileset(dir: "${project.build.directory}/${silverpeas}/bin") {
    include(name: '*/**')
    exclude(name: 'silverpeas*')
  }
}

ant.move(file: gradleUserPath.toString(),
    tofile: "${project.build.outputDirectory}/package/gradle")

Path h2libPath = Paths.get(project.build.outputDirectory, 'package', 'wildfly', 'modules',
    'system', 'layers', 'base', 'com', 'h2database', 'h2', 'main')
String h2lib = Files.list(h2libPath).find {it.toFile().name.startsWith('h2')}.toFile().name
ant.replaceregexp(file: "${project.build.outputDirectory}/package/bin/silverpeas.bat",
    match: '\'\\$H2_LIB\'',
    replace: h2lib)

ant.move(file: "${project.build.outputDirectory}/package/migrations/db/h2/busCore/up040/alter-table.sql",
  tofile: "${project.build.outputDirectory}/package/migrations/db/h2/busCore/up040/alter_table.sql")