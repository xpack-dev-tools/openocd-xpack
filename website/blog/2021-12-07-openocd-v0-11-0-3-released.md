---
title:  xPack OpenOCD v0.11.0-3 released

summary: "Version **0.11.0-3** is a maintenance release of **xPack OpenOCD**; it updates to the latest upstream master, **adds support for Apple Silicon** and uses the latest build scripts."

version: 0.11.0-3
npm_subversion: 1
download_url: https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.11.0-3/

date:   2021-12-07 20:11:14 +0200

authors: ilg-ul

# To be listed in the Releases page.
tags:
  - release

---

import CodeBlock from '@theme/CodeBlock';

Version **0.11.0-3** is a maintenance release of **xPack OpenOCD**; it updates to the latest upstream master, adds support for Apple Silicon and uses the latest build scripts.

<!-- truncate -->

[The xPack OpenOCD](https://xpack.github.io/dev-tools/openocd/)
is a standalone cross-platform binary distribution of
[OpenOCD](https://openocd.org).

There are separate binaries for **Windows** (Intel 32/64-bit),
**macOS** (Intel 64-bit, Apple Silicon 64-bit)
and **GNU/Linux** (Intel 32/64-bit, Arm 32/64-bit).

:::note Raspberry Pi

The main targets for the Arm binaries
are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported).

:::

## Download

The binary files are available from
<a href={frontMatter.download_url}>GitHub Releases</a>.

## Prerequisites

- Intel GNU/Linux 32/64-bit: any system with **GLIBC 2.15** or higher
  (like Ubuntu 12 or later, Debian 8 or later, RedHat/CentOS 7 later,
  Fedora 20 or later, etc)
- Arm GNU/Linux 32/64-bit: any system with **GLIBC 2.23** or higher
  (like Ubuntu 16 or later, Debian 9 or later, RedHat/CentOS 8 or later,
  Fedora 24 or later, etc)
- Intel Windows 32/64-bit: Windows 7 with the Universal C Runtime
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

To remove the links from the current project:

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

TODO: update commit id and date.

- OpenOCD version 0.11.0, the development commit
[7ed7eba](https://github.com/xpack-dev-tools/openocd/commit/7ed7eba33140d8745f3343be7752bf2b0aafb6d8)
from Dec. 4th, 2021.

## Changes

There are no functional changes.

Compared to the upstream, the following changes were applied:

- a configure option was added to configure branding (`--enable-branding`)
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

The original documentation is available in the `share/doc` folder.

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
.../xpack-openocd-0.11.0-3/bin/openocd -f board/stm32f4discovery.cfg
```

A more complex test consist in programming and debugging a simple blinky
application on the STM32F4DISCOVERY board. The binaries were
those generated by
[simple Eclipse projects](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/tree/xpack/tests/eclipse)
available in the **xPack GNU Arm Embedded GCC** project.

## Checksums

The SHA-256 hashes for the files are:

```txt
a6dce7e6e7808ce7503ff1f033ad83782566d1b7424de3635d5cae7fbf433f84
xpack-openocd-0.11.0-3-darwin-arm64.tar.gz

3000f2b942b9066e0a984f98a4f0e833bdd596c8ee20fb45e14c2ace27a9635f
xpack-openocd-0.11.0-3-darwin-x64.tar.gz

d0154dccdfb7d46056ec70c1c306a7fc8a872ab18bb84971f47b7edb7ea1610e
xpack-openocd-0.11.0-3-linux-arm.tar.gz

960e662946c13a2243c0ffbaa2a6e5ad26487cb1cf58a2265a97e1181937a28b
xpack-openocd-0.11.0-3-linux-arm64.tar.gz

8eb54a7b45125f32592dbc33de92e734d8cc9704a3293c529867104f244b1046
xpack-openocd-0.11.0-3-linux-ia32.tar.gz

983ade5cdf585c5260b3086e430ed5e21f1a5b52c45a3685078cc2b5c2e9106c
xpack-openocd-0.11.0-3-linux-x64.tar.gz

9be728d4fff63d96c6f8d9e26a1298a860c5842d54e8a678732f8b51811ee72a
xpack-openocd-0.11.0-3-win32-ia32.zip

04d3ea366ae37dbf2c767c52b19c74a606c5710c54055db795da1ab4578f18cf
xpack-openocd-0.11.0-3-win32-x64.zip

```

## Deprecation notices

### 32-bit support

Support for 32-bit Intel Linux and Intel Windows will most probably
be dropped in 2022. Support for 32-bit Arm Linux will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### Linux minimum requirements

Support for RedHat 7 will most probably be dropped in 2022, and the
minimum requirement will be raised to GLIBC 2.27, available starting
with Ubuntu 18 and RedHat 8.

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
