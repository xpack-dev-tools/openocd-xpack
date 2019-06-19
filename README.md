
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd) 
[![license](https://img.shields.io/github/license/xpack-dev-tools/openocd-xpack.svg)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/LICENSE)
[![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)

# The xPack OpenOCD

This binary xPack installs the platform specific binaries for the
[xPack OpenOCD](https://xpack.github.io/dev-tools/openocd/).

## User info

This section is intended as a shortcut for developers who plan 
to use the OpenOCD binaries.

### Easy install

The easiest way is to install the binary xPack, available as 
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the `npmjs.com` repository.

#### Prerequisites

The only requirement is a recent 
`xpm`, which is a portable 
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions from the 
[`xpm`](https://xpack.github.io/core/xpm/install/) page.

#### Install

With `xpm` available, installing 
the latest version of the package is quite easy:

```console
$ xpm install --global @xpack-dev-tools/openocd
```

This command will always install the latest available version, 
in the central xPacks repository, which is a platform dependent folder 
(check the output of the `xpm` command or the actual folder used on 
your platform).

This location is configurable using the environment variable 
`XPACKS_REPO_FOLDER`; for more details please check the 
[xpm folders](https://xpack.github.io/core/xpm/folders/) page.

xPacks aware tools, like the **GNU MCU Eclipse plug-ins** automatically 
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

#### Uninstall

To remove the installed xPack, the command is similar:

```console
$ xpm uninstall --global @xpack-dev-tools/openocd
```

(Note: not yet implemented. As a temporary workaround, simply remove the 
`xPacks/@xpack-dev-tools/openocd` folder, or one of the the versioned 
subfolders.)

### Manual install

For all platforms, the **xPack OpenOCD** binaries are released as portable 
archives that can be installed in any location.

The archives can be downloaded from the
[GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/) page.

For more details please check the [Install](https://xpack.github.io/dev-tools/openocd/install/) page. 

### Windows drivers

Most JTAG probes require separate drivers on Windows. 
For more details please check the [Install](https://xpack.github.io/dev-tools/openocd/install/) page.

### GNU/Linux UDEV subsystem

For the JTAG probes implemented as USB devices (actually most of them), the last installation step on GNU/Linux is to configure the UDEV subsystem. 

For more details please check the [Install](https://xpack.github.io/dev-tools/openocd/install/) page.

## Developer info

- [how to build](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-BUILD.md) 
- [how to publish](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-PUBISH.md)

## Support

The quick answer is to use the [forum](https://www.tapatalk.com/groups/xpack/);
please select the correct forum.

For more details please check the [Support](https://xpack.github.io/dev-tools/openocd/support/) page.

## License

The original content is released under the 
[MIT License](https://opensource.org/licenses/MIT), with all rights 
reserved to [Liviu Ionescu](https://github.com/ilg-ul).

The binary distributions include several open-source components; the
corresponding licenses are available in the installed
`distro-info/licenses` folder.

## Download analytics

* GitHub [xpack-dev-tools/openocd.git](https://github.com/xpack-dev-tools/openocd/)
  * latest xPack release
[![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd/latest/total.svg)](https://github.com/xpack-dev-tools/openocd/releases/)
  * all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd/total.svg)](https://github.com/xpack-dev-tools/openocd/releases/)
  * previous GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd/total.svg)](https://github.com/xpack-dev-tools/openocd/releases/)
* xPack [@xpack-dev-tools/openocd](https://github.com/xpack-dev-tools/openocd-xpack/)
  * latest release, per month 
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
[![npm](https://img.shields.io/npm/dm/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
  * all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
* [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=openocd) (grouped per release)
  
Credit to [Shields IO](https://shields.io) and [Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats).

