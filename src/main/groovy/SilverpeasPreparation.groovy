import org.codehaus.plexus.util.FileUtils
import java.nio.file.Path
import java.nio.file.Paths

String wildflyVersion = project.properties['wildfly.version'].split('\\.')[0]
String silverpeas = "silverpeas-${project.properties['silverpeas.version']}-wildfly${wildflyVersion}"
String wildfly = "wildfly-${project.properties['wildfly.version']}.Final"
def ant = new AntBuilder()

// get the Silverpeas distribution and update the silverpeas.gradle to use the Aurora look
if (! new File("${project.build.directory}/${silverpeas}.zip").exists()) {
  ant.sequential {
    get(src: "https://www.silverpeas.org/files/${silverpeas}.zip",
        dest: "${project.build.directory}/${silverpeas}.zip",
        verbose: 'on')
    unzip(src: "${project.build.directory}/${silverpeas}.zip",
        dest: "${project.build.directory}")
    move(file: "${project.build.directory}/${silverpeas}",
        tofile: "${project.build.outputDirectory}/package/silverpeas")
    copy(file: "${project.basedir}/src/main/resources/package/bin/silverpeas.gradle",
        tofile: "${project.build.outputDirectory}/package/silverpeas/bin/silverpeas.gradle")
    replaceregexp(file: "${project.build.outputDirectory}/package/silverpeas/bin/silverpeas.gradle",
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
        tofile: "${project.build.outputDirectory}/package/silverpeas/wildfly")
  }
}

// assemble Silverpeas
Path gradleUserPath
if (System.properties['os.name'].toLowerCase().contains('windows')) {
  // we are on Windows (nobody can be perfect)
  gradleUserPath = Paths.get(System.getenv("USERPROFILE"), '.gradle')
  FileUtils.deleteDirectory(gradleUserPath.toString())
  ant.exec(executable: "${project.build.outputDirectory}/package/silverpeas/bin/silverpeas.bat",
      osfamily: 'windows') {
    arg(value: 'assemble')
  }
} else {
  // we are on a more serious OS ... (Unix-like system)
  gradleUserPath = Paths.get(System.getenv("HOME"), '.gradle')
  FileUtils.deleteDirectory(gradleUserPath.toString())
  ant.chmod(file: "${project.build.outputDirectory}/package/silverpeas/bin/silverpeas",
      perm: "ugo+rx")
  ant.exec(executable: "${project.build.outputDirectory}/package/silverpeas/bin/silverpeas",
      osfamily: 'unix') {
    arg(value: 'assemble')
  }
}
ant.move(file: gradleUserPath.toString(),
    tofile: "${project.build.outputDirectory}/package/gradle")

