import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

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
  onBrokenMarkdownLinks: 'warn',

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
          showLastUpdateAuthor: true,
          showLastUpdateTime: true,
          },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/',
        },
        theme: {
          customCss: './src/css/custom.css',
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
          to: 'docs/overview',
          position: 'left',
          items: [
            {
              label: 'Getting Started',
              to: '/docs/overview'
            },
            {
              label: 'Install',
              to: '/docs/install'
            },
            {
              label: 'Support',
              to: '/docs/support'
            },
            {
              label: 'Releases',
              to: '/docs/releases'
            }
          ]
        },
        {
          to: '/blog',
          label: 'Blog',
          position: 'left'
        },
        {
          href: 'https://github.com/xpack-dev-tools/openocd-xpack/',
          position: 'right',
          className: 'header-github-link',
          'aria-label': 'GitHub repository',
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
};

export default config;
