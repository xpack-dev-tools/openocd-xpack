
## Easy install

The easiest way to install OpenOCD is by using the **binary xPack**, available as
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the [`npmjs.com`](https://www.npmjs.com) registry.

### Prerequisites

The only requirement is a recent
[xpm](https://xpack.github.io/xpm/), which is a portable
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions from the
[xpm install](https://xpack.github.io/xpm/install/) page.

### Install

With **xpm** available, installing
the latest version of the package is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/openocd@latest --verbose
```

This command will always install the latest available version,
in **the global xPacks store**, which is a platform dependent folder
(check the output of the `xpm` command for the actual folder used on
your platform).

:::tip
The install location can be configured using the
`XPACKS_STORE_FOLDER` environment variable; for more details please check the
[xpm folders](https://xpack.github.io/xpm/folders/) page.
:::

:::tip
The archive content is unpacked into a folder
named `.content`. On some platforms
this might be hidden for normal browsing, and seeing it requires
separate options (like `ls -A`) or, in file browsers, to enable
settings like **Show Hidden Files**.
:::

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/openocd
```

To completely remove the package from the global store:

```sh
xpm uninstall --global @xpack-dev-tools/openocd --verbose
```
