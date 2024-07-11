---
title:  xPack OpenOCD v0.12.0-3 released

date:   2024-04-02 10:43:52 +0300

authors: ilg-ul

# To be listed in the Releases page.
tags:
  - release

# Custom properties.
upstream_version: "0.12.0"
upstream_commit: "dd175827"
upstream_release_date: "1 Apr 2024"

version: "0.12.0-3"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.12.0-3/

---

import CodeBlock from '@theme/CodeBlock';

Version **0.12.0-3** is a maintenance release of **xPack OpenOCD**; it updates to
the latest upstream master.

<!--truncate-->

The [xPack OpenOCD](https://xpack.github.io/openocd/)
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

The binary files are available from
<a href={frontMatter.download_url}>GitHub Releases</a>.

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
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/openocd@latest --verbose

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

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/openocd
```

## Compliance

The **xPack OpenOCD** generally follows the official
[OpenOCD](https://openocd.org) releases.

The current version is based on:

- OpenOCD version {frontMatter.upstream_version}, the development commit
[{frontMatter.upstream_commit}](https://github.com/xpack-dev-tools/openocd/commit/{frontMatter.upstream_commit}/)
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

<CodeBlock language="sh">
{'~/Library/xPacks/@xpack-dev-tools/openocd/' + frontMatter.version + '.' + frontMatter.npm_subversion + '/.content/bin/openocd -f board/stm32f4discovery.cfg'}
</CodeBlock>

A more complex test consist in programming and debugging a simple blinky
application on the STM32F4DISCOVERY board. The binaries were
those generated by
[simple Eclipse projects](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/tree/xpack/tests/eclipse)
available in the **xPack GNU Arm Embedded GCC** project.

## Checksums

The SHA-256 hashes for the files are:

```txt
0084761ef77a5c3f2e098993f17cb4225819462b90c1378a1b35cea9cd466288
xpack-openocd-0.12.0-3-darwin-arm64.tar.gz

47931a1adde58ae6a7d99e4b0db5b9a62c568ce8e5232e958325d733f09e9995
xpack-openocd-0.12.0-3-darwin-x64.tar.gz

8f956ed0c5027c5e655fe590712aef2dbd21a01777b5c008f772b2d1b45fb095
xpack-openocd-0.12.0-3-linux-arm.tar.gz

892b2ecc624521e5947e4857d7dfd4af03e19ef37da73ae91215a1001864ed75
xpack-openocd-0.12.0-3-linux-arm64.tar.gz

98c07aa34c6e02ac6ef0794494bc3bd9e2409d587723c5191ee4f0a4d179e39b
xpack-openocd-0.12.0-3-linux-x64.tar.gz

94b51be5e5b38ac1c5814972eee9b062f0805bcd3ecc3bad5190fd659f6a3ab3
xpack-openocd-0.12.0-3-win32-x64.zip

```

## Deprecation notices

### Linux minimum requirements

The minimum requirement is **GLIBC 2.27**, available starting
with Ubuntu 18, Debian 10 and RedHat 8.
Support for RedHat 7 was dropped in 2022.

### 32-bit support

Support for 32-bit Intel Linux and Intel Windows was
dropped in 2022.

### Pre-deprecation notice for 32-bit Arm Linux

Due to the large user base of 32-bit Raspberry Pi systems,
support for 32-bit Arm Linux (armv7l) will be preserved
for a little while, but expect it to be dropped by 2025,
so it is recommended to consider an upgrade to a RPi 4 or 5 with
at least 4 GB (preferably 8 GB) of RAM.

## Pre-deprecation notice for Ubuntu 18.04

Ubuntu 18.04 LTS _Bionic Beaver_ reached the end of the standard five-year
maintenance window for Long-Term Support (LTS) release on 31 May 2023.

As a courtesy, the xPack GNU/Linux releases will continue to be based on
Ubuntu 18.04 for another year.

From 2025 onwards, the GNU/Linux binaries will be built on **Debian 10**,
(**GLIBC 2.28**), and are also expected to run on RedHat 8.

Users are urged to update their build and test infrastructure to
ensure a smooth transition to the next xPack releases.

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
