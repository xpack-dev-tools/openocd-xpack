import CodeBlock from '@theme/CodeBlock';

## Automated install

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

To install **xpm**,
follow the instructions in the
[xpm install](https://xpack.github.io/xpm/install/) page.

If already installed, it is always a good idea to update it to the
latest version with:

```sh
npm install --location=global xpm@latest
```

:::tip

It is also a good idea to upgrade **npm** to the latest version, and
**node** to a reasonably recent version (currently **npm** requires
a **node** >=18.17.0).

:::

### Install

With **xpm** available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy.

At first use, add a `package.json` to the project, if not already there.

```sh
cd my-project
xpm init
```

then install the **openocd** package:

```sh
xpm install @xpack-dev-tools/openocd@latest --verbose
```

The main result is a set of { props.is_windows === 'True' ? (<><code>.cmd</code> forwarders</>) : 'symbolic links'}:

<CodeBlock language="console"> {
`${ props.is_windows === 'True' ? 'dir xpacks\\.bin' : 'ls -l xpacks/.bin' }`
}</CodeBlock>

The above `xpm install` command will:

* install the latest available OpenOCD version,
into the **central xPacks store** (if not already there); the central
xPacks store is a platform dependent location in the home folder
(check the output of the `xpm` command for the actual
folder used on your platform);
* add { props.is_windows === 'True' ? (<><code>.cmd</code> forwarders</>) : 'symbolic links' }
into the local `xpacks/.bin` folder, referring to the binaries in the central store;
* add `@xpack-dev-tools/openocd` to `package.json` as a
development dependency; this ties a specific OpenOCD version to the current project
and allows convenient subsequent installs via `xpm install` when the
project is cloned in a new location (for example in CI/CD environments).

:::tip

The install location can be configured using the
`XPACKS_STORE_FOLDER` environment variable; for more details please check the
[xpm folders](https://xpack.github.io/xpm/folders/) page.

:::

:::tip

**xpm** unpacks the archive content into a folder
named `.content`. On some platforms
this might be hidden for normal browsing, and seeing it requires
separate options (like `ls -A`) or, in file browsers, to enable
settings like **Show Hidden Files**.

:::

For xPacks aware tools (like the **Eclipse Embedded C/C++ plug-ins**),
it is also possible to install OpenOCD only globally in the **central
xPacks store**, without any local { props.is_windows === 'True' ? (<><code>.cmd</code> forwarders</>) : 'symbolic links' }, assuming the tool is capable of handling
the path itself.

```sh
xpm install --global @xpack-dev-tools/openocd@latest --verbose
```

After install, the package creates a folder hierarchy like the following
(only the first two depth levels are shown):
