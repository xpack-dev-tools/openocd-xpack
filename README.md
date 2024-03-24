
[![GitHub package.json version](https://img.shields.io/github/package-json/v/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/package.json)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg?color=blue)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
[![license](https://img.shields.io/github/license/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/LICENSE)

# The xPack OpenOCD

A standalone cross-platform (Windows/macOS/Linux) **OpenOCD**
binary distribution, intended for reproducible builds.

In addition to the the binary archives and the package meta data,
this project also includes the build scripts.

## Overview

This open source project is hosted on GitHub as
[`xpack-dev-tools/openocd-xpack`](https://github.com/xpack-dev-tools/openocd-xpack)
and provides the platform specific binaries for the
[xPack OpenOCD](https://xpack.github.io/openocd/).

This distribution follows the official [OpenOCD](https://openocd.org).

The binaries can be installed automatically as **binary xPacks** or manually as
**portable archives**.

## Release schedule

This distribution generally follows the official
[OpenOCD](https://openocd.org), with
additional releases based on the current Git form time to time.

## User info

This section is intended as a shortcut for those who plan
to use the OpenOCD binaries. For full details please read the
[xPack OpenOCD](https://xpack.github.io/openocd/) pages.

### Easy install

The easiest way to install OpenOCD is using the **binary xPack**, available as
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the [`npmjs.com`](https://www.npmjs.com) registry.

#### Prerequisites

A recent [xpm](https://xpack.github.io/xpm/),
which is a portable [Node.js](https://nodejs.org/) command line application
that complements [npm](https://docs.npmjs.com)
with several extra features specific to
**C/C++ projects**.

It is recommended to install/update to the latest version with:

```sh
npm install --location=global xpm@latest
```

For details please follow the instructions in the
[xPack install](https://xpack.github.io/install/) page.

#### Install

With the `xpm` tool available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/openocd@latest --verbose

ls -l xpacks/.bin
```

This command will:

- install the latest available version,
into the central xPacks store, if not already there
- add symbolic links to the central store
(or `.cmd` forwarders on Windows) into
the local `xpacks/.bin` folder.

The central xPacks store is a platform dependent
location in the home folder;
check the output of the `xpm` command for the actual
folder used on your platform.
This location is configurable via the environment variable
`XPACKS_STORE_FOLDER`; for more details please check the
[xpm folders](https://xpack.github.io/xpm/folders/) page.

For xPacks aware tools, like the **Eclipse Embedded C/C++ plug-ins**,
it is also possible to install OpenOCD globally, in the user home folder:

```sh
xpm install --global @xpack-dev-tools/openocd@latest --verbose
```

Eclipse will automatically
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

After install, the package should create a structure like this (macOS files;
only the first two depth levels are shown):

```console
$ tree -L 2 /Users/ilg/Library/xPacks/\@xpack-dev-tools/openocd/0.12.0-3.1/.content/
/Users/ilg/Library/xPacks/\@xpack-dev-tools/openocd/0.12.0-3.1/.content/
├── README.md
├── bin
│   └── openocd
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── libexec
│   ├── libftdi1.2.5.0.dylib
│   ├── libftdi1.2.dylib -> libftdi1.2.5.0.dylib
│   ├── libhidapi.0.14.0.dylib
│   └── libusb-1.0.0.dylib
└── openocd
    ├── OpenULINK
    ├── angie
    ├── contrib
    └── scripts

12 directories, 7 files
```

No other files are installed in any system folders or other locations.

#### Uninstall

The binaries are distributed as portable archives; thus they do not need
to run a setup and do not require an uninstall; simply removing the
folder is enough.

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/openocd
```

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/openocd
```

### Manual install

For all platforms, the **xPack OpenOCD**
binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
page.

For more details please read the
[Install](https://xpack.github.io/openocd/install/) page.

### Versioning

The version strings used by the OpenOCD project are three number strings
like `0.12.0`; to this string the xPack distribution adds a four number,
but since semver allows only three numbers, all additional ones can
be added only as pre-release strings, separated by a dash,
like `0.12.0-3`. When published as a npm package, the version gets
a fifth number, like `0.12.0-3.1`.

Since adherence of third party packages to semver is not guaranteed,
it is recommended to use semver expressions like `^0.12.0` and `~0.12.0`
with caution, and prefer exact matches, like `0.12.0-3.1`.

### Windows drivers

Most JTAG probes require separate drivers on Windows.
For more details please read the
[Install](https://xpack.github.io/openocd/install/) page.

### GNU/Linux UDEV subsystem

For the JTAG probes implemented as USB devices (actually most of them),
the last installation step on GNU/Linux is to configure the UDEV subsystem.

For more details please read the
[Install](https://xpack.github.io/openocd/install/) page.

## Developer & Maintainer info

For information on how to build the binaries, please see the
[README-DEVELOPER](README-DEVELOPER.md) page.

For information on the workflow used to make releases, please see the
[README-MAINTAINER](README-MAINTAINER.md) page.

## Support

The quick advice for getting support is to use the GitHub
[Discussions](https://github.com/xpack-dev-tools/openocd-xpack/discussions/).

For more details please read the
[Support](https://xpack.github.io/openocd/support/) page.

## License

Unless otherwise stated, the content is released under the terms of the
[MIT License](https://opensource.org/licenses/mit/),
with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul).

The binary distributions include several open-source components; the
corresponding licenses are available in the installed
`distro-info/licenses` folder.

## Download analytics

- GitHub [`xpack-dev-tools/openocd-xpack`](https://github.com/xpack-dev-tools/openocd-xpack/) repo
  - latest xPack release
[![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/latest/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
  - previous GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/openocd/total.svg)](https://github.com/gnu-mcu-eclipse/openocd/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=openocd-xpack) (grouped per release)
- npmjs.com [`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd/) xPack
  - latest release, per month
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
[![npm](https://img.shields.io/npm/dm/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
