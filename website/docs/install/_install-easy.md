import CodeBlock from '@theme/CodeBlock';

## Easy install

The easiest way to install OpenOCD is by using the **binary xPack**, available as
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the [`npmjs.com`](https://www.npmjs.com) registry.

### Prerequisites

The only requirement is a recent
[xpm](https://xpack.github.io/xpm/), which is a portable
[Node.js](https://nodejs.org) command line application
that complements [npm](https://docs.npmjs.com)
with several extra features specific to
**C/C++ projects**.

To install it,
follow the instructions in the
[xpm install](https://xpack.github.io/xpm/install/) page.

It is always a good idea to install/update to the latest version with:

```sh
npm install --location=global xpm@latest
```

### Install

With **xpm** available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

At first use, add a `package.json` to the project, if not already there.

```sh
cd my-project
xpm init
```

then install the package and add it as a dependency for convenient subsequent installs:

```sh
xpm install @xpack-dev-tools/openocd@latest --verbose
```

The main result is a set of { props.is_windows === 'True' ? (<><code>.cmd</code> forwarders</>) : 'symbolic links'}:

<CodeBlock language="console"> {
`${ props.is_windows === 'True' ? 'dir xpacks\\.bin' : 'ls -l xpacks/.bin' }`
}</CodeBlock>

The `xpm install` command will:

* install the latest available version,
into the **central xPacks store**, if not already there
* add { props.is_windows === 'True' ? (<><code>.cmd</code> forwarders</>) : 'symbolic links' }
to the central store into the local `xpacks/.bin` folder.

The central xPacks store is a platform dependent
location in the home folder;
check the output of the `xpm` command for the actual
folder used on your platform.

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

For xPacks aware tools (like the **Eclipse Embedded C/C++ plug-ins**),
it is also possible to install OpenOCD globally, in the user home folder:

```sh
xpm install --global @xpack-dev-tools/openocd@latest --verbose
```

After install, the package should create a structure like the following
(only the first two depth levels are shown):
