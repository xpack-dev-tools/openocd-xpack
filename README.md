
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
[![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)

# The xPack OpenOCD

This open source project is hosted on GitHub as
[`xpack-dev-tools/openocd-xpack`](https://github.com/xpack-dev-tools/openocd-xpack)
and provides the platform specific binaries for the
[xPack OpenOCD](https://xpack.github.io/openocd/).

This distribution follows the official [OpenOCD](http://openocd.org).

The binaries can be installed automatically as **binary xPacks** or manually as
**portable archives**.

In addition to the package meta data, this project also includes
the build scripts.

## User info

This section is intended as a shortcut for those who plan
to use the OpenOCD binaries. For full details please read the
[xPack OpenOCD](https://xpack.github.io/openocd/) pages.

### Easy install

The easiest way to install OpenOCD is using the **binary xPack**, available as
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the [`npmjs.com`](https://www.npmjs.com) registry.

#### Prerequisites

The only requirement is a recent
`xpm`, which is a portable
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions from the
[xpm](https://xpack.github.io/xpm/install/) page.

#### Install

With the `xpm` tool available, installing
the latest version of the package is quite easy:

```sh
xpm install --global @xpack-dev-tools/openocd@latest
```

This command will always install the latest available version,
into the central xPacks store, which is a platform dependent folder
(check the output of the `xpm` command for the actual folder used on
your platform).

This location is configurable using the environment variable
`XPACKS_REPO_FOLDER`; for more details please check the
[xpm folders](https://xpack.github.io/xpm/folders/) page.

xPacks aware tools, like the **Eclipse Embedded C/C++ plug-ins** automatically
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

#### Uninstall

To remove the installed xPack, the command is similar:

```sh
xpm uninstall --global @xpack-dev-tools/openocd
```

### Manual install

For all platforms, the **xPack OpenOCD** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
page.

For more details please read the
[Install](https://xpack.github.io/openocd/install/) page.

### Windows drivers

Most JTAG probes require separate drivers on Windows.
For more details please read the
[Install](https://xpack.github.io/openocd/install/) page.

### GNU/Linux UDEV subsystem

For the JTAG probes implemented as USB devices (actually most of them),
the last installation step on GNU/Linux is to configure the UDEV subsystem.

For more details please read the
[Install](https://xpack.github.io/openocd/install/) page.

## Maintainer info

- [How to build](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-BUILD.md)
- [How to make new releases](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-RELEASE.md)
- [Developer info](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-DEVELOP.md)

## Support

The quick answer is to use the
[xPack forums](https://www.tapatalk.com/groups/xpack/);
please select the correct forum.

For more details please read the
[Support](https://xpack.github.io/openocd/support/) page.

## License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT), with all rights
reserved to [Liviu Ionescu](https://github.com/ilg-ul).

The binary distributions include several open-source components; the
corresponding licenses are available in the installed
`distro-info/licenses` folder.

## Download analytics

- GitHub [`xpack-dev-tools/openocd-xpack`](https://github.com/xpack-dev-tools/openocd-xpack/) repo
  - latest xPack release
[![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/latest/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
  - previous GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/openocd/total.svg)](https://github.com/gnu-mcu-eclipse/openocd/releases/)
  - [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=openocd-xpack) (grouped per release)
- npmjs.com [`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd/) xPack
  - latest release, per month
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
[![npm](https://img.shields.io/npm/dm/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
