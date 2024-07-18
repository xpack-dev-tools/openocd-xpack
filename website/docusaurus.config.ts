import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';
import logger from '@docusaurus/logger';

// The node.js modules cannot be used in modules imported in browser code:
// webpack < 5 used to include polyfills for node.js core modules by default.
// so the entire initialisation code must be in this file, that is
// not processed by webpack.
// Also the configuration must be imported via
// import siteConfig from '@generated/docusaurus.config';

import { fileURLToPath } from 'node:url';
import path from 'node:path';
import fs from 'node:fs';

function getCustomFields() {
  const pwd = fileURLToPath(import.meta.url);
  const filePath = path.join(path.dirname(path.dirname(pwd)), 'package.json');
  // logger.info(filePath);
  const fileContent = fs.readFileSync(filePath);

  const topPackageJson = JSON.parse(fileContent.toString());
  const jsonVersion = topPackageJson.version.replace(".pre", "");

  logger.info(`package version: ${topPackageJson.version}`);

  const npmSubversion = jsonVersion.replace(/^.*[.]/, '');
  const rest1 = jsonVersion.replace(/[.][0-9]*$/, '');
  const xpackSubversion = rest1.replace(/^.*[-]/, '');
  const upstreamVersion = rest1.replace(/[-][0-9]*$/, '');

  return {
    appName: topPackageJson.xpack.properties.appName,
    appLcName: topPackageJson.xpack.properties.appLcName,
    upstreamVersion,
    xpackSubversion,
    npmSubversion,
  }
}

const customFields = getCustomFields();
logger.info(customFields);

const config: Config = {
  title: 'xPack OpenOCD',
  tagline: 'A binary distribution of OpenOCD',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://xpack-dev-tools.github.io',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/openocd-xpack',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'xpack-dev-tools', // Usually your GitHub org/user name.
  projectName: 'openocd-xpack', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'throw',

  // Useful for the sitemap.xml, to avoid redirects, since
  // GitHub redirects all to trailing slash.
  trailingSlash: true,

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/xpack-dev-tools/openocd-xpack/edit/xpack/website/',
          // showLastUpdateAuthor: true,
          showLastUpdateTime: true,
          },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/',
          showLastUpdateTime: true,
        },
        theme: {
          customCss: './src/css/custom.css',
        },
        // https://docusaurus.io/docs/api/plugins/@docusaurus/plugin-google-gtag
        // https://tagassistant.google.com
        gtag: {
          trackingID: 'G-7QE5W7V05S',
          anonymizeIP: false,
        },
      } satisfies Preset.Options,
    ],
  ],

  plugins: [
    [
      '@docusaurus/plugin-ideal-image',
      {
        quality: 70,
        max: 1030, // max resized image's size.
        min: 640, // min resized image's size. if original is lower, use that size.
        steps: 2, // the max number of images generated between min and max (inclusive)
        disableInDev: false,
      },
    ],
    './src/plugins/SelectReleasesPlugin',
  ],

  themeConfig: {
    // Replace with your project's social card
    // image: 'img/docusaurus-social-card.jpg',
    navbar: {
      title: 'The xPack Project',
      logo: {
        alt: 'xPack Logo',
        src: 'img/components-256.png',
        href: 'https://xpack.github.io/',
      },
      items: [
        {
          to: '/',
          // label: 'Home',
          className: 'header-home-link',
          position: 'left'
        },
        {
          type: 'dropdown',
          label: 'Docs',
          to: 'docs/getting-started',
          position: 'left',
          items: [
            {
              label: 'Getting Started',
              to: '/docs/getting-started'
            },
            {
              label: 'Install Guide',
              to: '/docs/install'
            },
            {
              label: 'User Info',
              to: '/docs/user-info'
            },
            {
              label: 'Help Center',
              to: '/docs/support'
            },
            {
              label: 'Releases',
              to: '/docs/releases'
            }
          ]
        },
        {
          type: 'dropdown',
          to: '/blog',
          label: 'Blog',
          position: 'left',
          items: [
            {
              label: 'Recent',
              to: '/blog'
            },
            {
              label: 'Archive',
              to: '/blog/archive'
            },
            {
              label: 'Tags',
              to: '/blog/tags'
            },
          ]
        },
        {
          href: 'https://github.com/xpack-dev-tools/openocd-xpack/',
          position: 'right',
          className: 'header-github-link',
          'aria-label': 'GitHub repository',
        },
        {
          label: `v${customFields.upstreamVersion}-${customFields.xpackSubversion}`,
          position: 'right',
          href: `https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v${customFields.upstreamVersion}-${customFields.xpackSubversion}`,
        },
        {
          href: 'https://github.com/xpack-dev-tools/',
          label: 'xpack-dev-tools',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Install',
              to: '/docs/install',
            },
            {
              label: 'Support',
              to: '/docs/support',
            },
            {
              label: 'Releases',
              to: '/docs/releases',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'Stack Overflow',
              href: 'https://stackoverflow.com/questions/tagged/xpack',
            },
            {
              label: 'Discord',
              href: 'https://discord.gg/kbzWaJerFG',
            },
            {
              label: 'Twitter',
              href: 'https://twitter.com/xpack_project',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'Blog',
              to: '/blog',
            },
            {
              label: 'GitHub',
              href: 'https://github.com/xpack-dev-tools/openocd-xpack/',
            },
            {
              label: 'xpack-dev-tools',
              href: 'https://github.com/xpack-dev-tools/',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} Liviu Ionescu. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,

  customFields: customFields,
};

export default config;
