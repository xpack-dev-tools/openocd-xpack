import { usePluginData } from '@docusaurus/useGlobalData';
import logger from '@docusaurus/logger'

export function ReleasesList({ items }): JSX.Element {
  const pluginData = usePluginData('select-releases');

  pluginData.releasesTable.forEach((item) => logger.info(item))
  return (
    <ul>
      {
        pluginData.releasesTable.map(release => (
          <li>
            <a href={release.permalink}>{release.title}</a> (<a href={release.downloadUrl}>download</a>)
          </li>
        ))
      }
    </ul>
  )
}
