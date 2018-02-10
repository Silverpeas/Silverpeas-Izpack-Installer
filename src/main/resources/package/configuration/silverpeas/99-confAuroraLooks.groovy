import java.nio.file.Files
import java.nio.file.Path

log.info 'Add the look Aurora as the default one'
Path lookSettings = "${settings.SILVERPEAS_HOME}/properties/org/silverpeas/util/viewGenerator/settings/lookSettings.properties".asPath()
if (! Files.exists(lookSettings)) {
  Properties lookProps = new Properties()
  lookProps.put('Initial', 'org.silverpeas.util.viewGenerator.settings.Aurora')
  lookProps.put('Sobre', 'org.silverpeas.util.viewGenerator.settings.Sobre')
  lookProps.store(lookSettings.newOutputStream(), null)
}

log.info 'Update the settings of the Aurora look to take into account the current Silverpeas platform applications'
def auroraProps = [
    'projects.spaceId': 'WA5',
    'home.news': 'quickInfo3',
    'home.events.appId': 'almnanach5',
    'home.faq.appId': 'questionReply7',
    'zoom.componentId': 'kmelia4',
    'Shortcut.home.1.Url': 'http://localhost:8000/silverpeas/Component/kmelia4',
    'Shortcut.home.2.Url': 'http://localhost:8000/silverpeas/Component/gallery9',
    'Shortcut.home.2.AltText': 'M&eacute;diath&egrave;que',
    'Shortcut.home.3.Url': 'http://localhost:8000/silverpeas/Rdirectory/jsp/Main?Sort=NEWEST',
    'Shortcut.home.4.Url': 'http://localhost:8000/silverpeas/Space/WA3',
    'Shortcut.home.4.AltText': 'Demandes en ligne',
    'Shortcut.home.5.Url': 'http://localhost:8000/silverpeas/Component/forums11',
    'Shortcut.home.5.AltText': 'Forums',
    'Shortcut.home.6.Url': 'http://localhost:8000/silverpeas/Component/suggestionBox12',
    'Shortcut.home.6.AltText': 'Vos id&eacute;es',
]
service.updateProperties(
    "${settings.SILVERPEAS_HOME}/properties/org/silverpeas/util/viewGenerator/settings/Aurora.properties",
    auroraProps)
