---
title:  xPack OpenOCD v0.12.0-1 released

summary: "Version **0.12.0-1** is a new release; it follows the upstream release."

version: "0.12.0-1"
npm_subversion: "1"
upstream_version: "0.12.0"
upstream_commit: "9ea7f3d"
upstream_release_date: "15 Jan 2022"
download_url: https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.12.0-1/

date:   2023-01-30 18:00:11 +0200

authors: ilg-ul

# To be listed in the Releases page.
tags:
  - release

---

import CodeBlock from '@theme/CodeBlock';

Version **0.12.0-1** is a new release of **xPack OpenOCD**, following the upstream OpenOCD release.

<!-- truncate -->

[The xPack OpenOCD](https://xpack.github.io/dev-tools/openocd/)
is a standalone cross-platform binary distribution of
[OpenOCD](https://openocd.org).

There are separate binaries for **Windows** (Intel 64-bit),
**macOS** (Intel 64-bit, Apple Silicon 64-bit)
and **GNU/Linux** (Intel 64-bit, Arm 32/64-bit).

:::note Raspberry Pi

The main targets for the Arm binaries
are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported).

:::

## Download

The binary files are available from GitHub
<a href={frontMatter.download_url}>Releases</a>.

## Prerequisites

- GNU/Linux Intel 64-bit: any system with **GLIBC 2.27** or higher
  (like Ubuntu 18 or later, Debian 10 or later, RedHat 8 later,
  Fedora 29 or later, etc)
- GNU/Linux Arm 32/64-bit: any system with **GLIBC 2.27** or higher
  (like Raspberry Pi OS, Ubuntu 18 or later, Debian 10 or later, RedHat 8 later,
  Fedora 29 or later, etc)
- Intel Windows 64-bit: Windows 7 with the Universal C Runtime
  ([UCRT](https://support.microsoft.com/en-us/topic/update-for-universal-c-runtime-in-windows-c0514201-7fe6-95a3-b0a5-287930f3560c)),
  Windows 8, Windows 10
- Intel macOS 64-bit: 10.13 or later
- Apple Silicon macOS 64-bit: 11.6 or later

## Install

The full details of installing the **xPack OpenOCD** on various platforms
are presented in the separate
[Install](/docs/install/) page.

### Easy install

The easiest way to install OpenOCD is with
[`xpm`](https://xpack.github.io/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a dependency for a project is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/openocd@latest

ls -l xpacks/.bin
```

To install this specific version, use:

<CodeBlock language="sh">
{'xpm install @xpack-dev-tools/openocd@' + frontMatter.version + '.' + frontMatter.npm_subversion + ' --verbose'}
</CodeBlock>

For xPacks aware tools, like the **Eclipse Embedded C/C++ plug-ins**,
it is also possible to install OpenOCD globally, in the user home folder.

```sh
xpm install --global @xpack-dev-tools/openocd@latest --verbose
```

Eclipse will automatically
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/openocd
```

To completely remove the package from the central xPacks store:

```sh
xpm uninstall --global @xpack-dev-tools/openocd
```

## Compliance

The xPack OpenOCD generally follows the official
[OpenOCD](https://openocd.org) releases.

The current version is based on:

- OpenOCD version {frontMatter.upstream_version}, the development commit
<a href={'https://github.com/xpack-dev-tools/openocd/commit/' + frontMatter.upstream_commit + '/'}>{frontMatter.upstream_commit}</a>
from {frontMatter.upstream_release_date}.

## Changes

There are no functional changes.

Compared to the upstream, the following changes were applied:

- the `src/openocd.c` file was edited to display the branding string
- the `contrib/60-openocd.rules` file was simplified to avoid protection
  related issues.

## Bug fixes

- none

## Enhancements

- none

## Known problems

- none

## Shared libraries

On all platforms the packages are standalone, and expect only the standard
runtime to be present on the host.

All dependencies that are build as shared libraries are copied locally
in the `libexec` folder (or in the same folder as the executable for Windows).

### `DT_RPATH` and `LD_LIBRARY_PATH`

On GNU/Linux the binaries are adjusted to use a relative path:

```console
$ readelf -d library.so | grep runpath
 0x000000000000001d (RPATH)            Library rpath: [$ORIGIN]
```

In the GNU ld.so search strategy, the `DT_RPATH` has
the highest priority, higher than `LD_LIBRARY_PATH`, so if this later one
is set in the environment, it should not interfere with the xPack binaries.

Please note that previous versions, up to mid-2020, used `DT_RUNPATH`, which
has a priority lower than `LD_LIBRARY_PATH`, and does not tolerate setting
it in the environment.

### `@rpath` and `@loader_path`

Similarly, on macOS, the binaries are adjusted with `install_name_tool` to use a
relative path.

## Documentation

The original documentation is available online:

- https://openocd.org/doc/pdf/openocd.pdf

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/openocd-xpack/builds/)

## Tests

The binaries were testes on Windows 10 Pro 32/64-bit, Intel Ubuntu 18
LTS 64-bit, Intel Xubuntu 18 LTS 32-bit and macOS 10.15.

Install the package with xpm.

The simple test, consists in starting the binaries
only to identify the STM32F4DISCOVERY board.

```sh
.../xpack-openocd-0.12.0-1/bin/openocd -f board/stm32f4discovery.cfg
```

A more complex test consist in programming and debugging a simple blinky
application on the STM32F4DISCOVERY board. The binaries were
those generated by
[simple Eclipse projects](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/tree/xpack/tests/eclipse)
available in the **xPack GNU Arm Embedded GCC** project.

## Checksums

The SHA-256 hashes for the files are:

```txt
db4b501a059944551365ee6f6dad95f5a7d0808654939f747c167c5da743fdb7
xpack-openocd-0.12.0-1-darwin-arm64.tar.gz

ca569b6bfd9b3cd87a5bc88b3a33a5c4fe854be3cf95a3dcda1c194e8da9d7bb
xpack-openocd-0.12.0-1-darwin-x64.tar.gz

886f65ffd4761619d86f492e1d72086992e72f379b90f9d1a1bcf124f88dcc57
xpack-openocd-0.12.0-1-linux-arm.tar.gz

a86b3ecc256cb870f074a8e633e791ed09102c8ed0d639ae49782c51a404dfbc
xpack-openocd-0.12.0-1-linux-arm64.tar.gz

940f22eccddb0946b69149d227948f77d5917a2c5f1ab68e5d84d614c2ceed20
xpack-openocd-0.12.0-1-linux-x64.tar.gz

5cba78c08ad03aa38549e94186cbb4ec34c384565a40a6652715577e4f1a458f
xpack-openocd-0.12.0-1-win32-x64.zip

```

## Deprecation notices

### 32-bit support

Support for 32-bit Intel Linux and Intel Windows was
dropped in 2022. Support for 32-bit Arm Linux (armv7l) will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### Linux minimum requirements

Support for RedHat 7 was dropped in 2022 and the
minimum requirement was raised to GLIBC 2.27, available starting
with Ubuntu 18, Debian 10 and RedHat 8.

## Download analytics

import Image from '@theme/IdealImage';

- GitHub [xpack-dev-tools/openocd-xpack](https://github.com/xpack-dev-tools/openocd-xpack/)
  - this release <a href={ 'https://github.com/xpack-dev-tools/openocd-xpack/releases/v' + frontMatter.version + '/' }><Image img={ 'https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/v' + frontMatter.version + '/total.svg' } alt='Github Release'/></a>
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
  - all GNU MCU Eclipse releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/openocd/total.svg)](https://github.com/gnu-mcu-eclipse/openocd/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=openocd-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/openocd](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
  - all @gnu-mcu-eclipse releases [![npm](https://img.shields.io/npm/dt/@gnu-mcu-eclipse/openocd.svg)](https://www.npmjs.com/package/@gnu-mcu-eclipse/openocd/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
