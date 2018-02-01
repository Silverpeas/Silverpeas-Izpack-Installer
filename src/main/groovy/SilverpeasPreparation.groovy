import org.codehaus.plexus.util.FileUtils
import java.nio.file.Path
import java.nio.file.Paths

String wildflyVersion = project.properties['wildfly.version'].split('\\.')[0]
String silverpeas = "silverpeas-${project.properties['silverpeas.version']}-wildfly${wildflyVersion}"
String wildfly = "wildfly-${project.properties['wildfly.version']}.Final"
def ant = new AntBuilder()

// get the Silverpeas distribution
if (! new File("${project.build.directory}/${silverpeas}.zip").exists()) {
  ant.get(src: "https://www.silverpeas.org/files/${silverpeas}.zip",
      dest: "${project.build.directory}/${silverpeas}.zip",
      verbose: 'on')
  ant.unzip(src: "${project.build.directory}/${silverpeas}.zip",
      dest: "${project.build.directory}")
  ant.move(file: "${project.build.directory}/${silverpeas}",
      tofile: "${project.build.outputDirectory}/package/silverpeas")
}

// get the Wildfly distribution
if (! new File("${project.build.directory}/${wildfly}.zip").exists()) {
  ant.get(src: "https://www.silverpeas.org/files/${wildfly}.zip",
      dest: "${project.build.directory}/${wildfly}.zip",
      verbose: 'on')
  ant.unzip(src: "${project.build.directory}/${wildfly}.zip",
      dest: "${project.build.directory}")
  ant.move(file: "${project.build.directory}/${wildfly}",
      tofile: "${project.build.outputDirectory}/package/silverpeas/wildfly")
}

// assemble Silverpeas
Path gradleUserPath
if (System.properties['os.name'].toLowerCase().contains('windows')) {
  gradleUserPath = Paths.get(System.getenv("USERPROFILE"), '.gradle')
  FileUtils.deleteDirectory(gradleUserPath.toString())
  ant.exec(executable: "${project.build.outputDirectory}/package/silverpeas/bin/silverpeas.bat",
      osfamily: 'windows') {
    arg(value: 'assemble')
  }
} else {
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

