[![license](https://img.shields.io/github/license/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/xpack-dev-tools/openocd-xpack.svg)](https://github.com/xpack-dev-tools/openocd-xpack/issues/)
[![GitHub pulls](https://img.shields.io/github/issues-pr/xpack-dev-tools/openocd-xpack.svg)](https://github.com/xpack-dev-tools/openocd-xpack/pulls)

# Maintainer info

## Prerequisites

The prerequisites are listed in the
[README-DEVELOPER](README-DEVELOPER.md) page.

For details on installing them, please read the
[XBB prerequisites page](https://xpack.github.io/xbb/prerequisites/).

## Get project sources

The project is hosted on GitHub:

- <https://github.com/xpack-dev-tools/openocd-xpack.git>

To clone the stable branch (`xpack`), run the following commands in a
terminal (on Windows use the _Git Bash_ console):

```sh
rm -rf ~/Work/xpack-dev-tools/openocd-xpack.git && \
git clone https://github.com/xpack-dev-tools/openocd-xpack.git \
  ~/Work/xpack-dev-tools/openocd-xpack.git
```

For development purposes, clone the `xpack-develop` branch:

```sh
rm -rf ~/Work/xpack-dev-tools/openocd-xpack.git && \
mkdir -p ~/Work/xpack-dev-tools && \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/openocd-xpack.git \
  ~/Work/xpack-dev-tools/openocd-xpack.git
```

Or, if the repo was already cloned:

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull
```

## Get helper sources

The project has a dependency to a common **helper**, that is
normally installed as a read-only dependency; for development
purposes, to be able to make changes to the helper, clone the
`xpack-develop` branch and link it to the central xPacks store:

```sh
rm -rf ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
mkdir -p ~/Work/xpack-dev-tools && \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/xbb-helper-xpack.git \
  ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git
```

Or, if the repo was already cloned:

```sh
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git
```

Other repositories in use are:

- <https://github.com/openocd-org/openocd.git> - a read-only mirror of the
  upstream OpenOCD (<git://git.code.sf.net/p/openocd/code>)

## Release schedule

In the past, the OpenOCD had no release schedule, and very rare
[releases](https://github.com/openocd-org/openocd/releases).
The xPack OpenOCD releases also had no schedules, and were done on an
as-needed basis. As a general rule, it is planned to follow the upstream
releases and add releases from the repo HEAD from time to time.

## How to make new releases

Before starting the build, perform some checks and tweaks.

### Download the build scripts

The build scripts are available in the `scripts` folder of the
[`xpack-dev-tools/openocd-xpack`](https://github.com/xpack-dev-tools/openocd-xpack)
Git repo.

To download them on a new machine, clone the `xpack-develop` branch,
as seen above.

### Check Git

In the `xpack-dev-tools/openocd-xpack` Git repo:

- switch to the `xpack-develop` branch
- pull new changes
- if needed, merge the `xpack` branch

No need to add a tag here, it'll be added when the release is created.

### Update helper & other dependencies

Check the latest versions at <https://github.com/xpack-dev-tools/> and
update the dependencies in `package.json`.

### Check the latest upstream release

The current release must be announced in the [OpenOCD](https://openocd.org)
web, and reflected in the Git
[tags](https://sourceforge.net/p/openocd/code/ci/master/tree/).
Compare the latest tag with the current xPack
[release](https://github.com/xpack-dev-tools/openocd-xpack/releases).
If necessary, update the triplet, otherwise increase the fourth number,
as below.

### Increase the version

Determine the version (like `0.12.0`) and update the `scripts/VERSION`
file; the format is `0.12.0-2`. The fourth number is the xPack release number
of this version. A fifth number will be added when publishing
the package on the `npm` server.

### Fix possible open issues

Check GitHub issues and pull requests:

- <https://github.com/xpack-dev-tools/openocd-xpack/issues/>

and fix them; assign them to a milestone (like `0.12.0-2`).

### Check `README.md`

Normally `README.md` should not need changes, but better check.
Information related to the new version should not be included here,
but in the version specific release page.

### Update versions in `README` files

- update version in `README-MAINTAINER.md`
- update version in `README.md`

### Update version in `package.json` to a pre-release

Use a new version, suffixed by `.pre`.

### Update `CHANGELOG.md`

- open the `CHANGELOG.md` file
- check if all previous fixed issues are in
- add a new entry like _* v0.12.0-2 prepared_
- commit with a message like _prepare v0.12.0-2_

### Update the version specific code

- open the `scripts/versioning.sh` file
- add a new `if` with the new version before the existing code
- update `XBB_OPENOCD_GIT_COMMIT` to the desired commit id

## Build

The builds currently run on 5 dedicated machines (Intel GNU/Linux,
Arm 32 GNU/Linux, Arm 64 GNU/Linux, Intel macOS and Apple Silicon macOS).

### Development run the build scripts

Before the real build, run test builds on all platforms.

#### Visual Studio Code

All actions are defined as **xPack actions** and can be conveniently
triggered via the VS Code graphical interface, using the
[xPack extension](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack).

#### Intel macOS

For Intel macOS, first run the build on the development machine
(`wksi`, a recent macOS):

```sh
# Update the build scripts.
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull

xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git

git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull
xpm run link-deps -C ~/Work/xpack-dev-tools/openocd-xpack.git

# For backup overhead reasons, on the development machine
# the builds happen on a separate Work folder.
rm -rf ~/Work/xpack-dev-tools-build/openocd-[0-9]*-*

xpm install --config darwin-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run build-develop --config darwin-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

For a debug build:

```sh
xpm run build-develop-debug --config darwin-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

When functional, push the `xpack-develop` branch to GitHub.

Run the native build on the production machine
(`xbbmi`, an older macOS);
start a VS Code remote session, or connect with a terminal:

```sh
caffeinate ssh xbbmi
```

Repeat the same steps as before.

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm run link-deps -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run deep-clean --config darwin-x64  -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm install --config darwin-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run build-develop --config darwin-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

About 10 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpack-dev-tools/openocd-xpack.git/build/darwin-x64/deploy
total 4840
-rw-r--r--  1 ilg  staff  2471148 Jan 30 11:19 xpack-openocd-0.12.0-2-darwin-x64.tar.gz
-rw-r--r--  1 ilg  staff      107 Jan 30 11:19 xpack-openocd-0.12.0-2-darwin-x64.tar.gz.sha
```

#### Apple Silicon macOS

Run the native build on the production machine
(`xbbma`, an older macOS);
start a VS Code remote session, or connect with a terminal:

```sh
caffeinate ssh xbbma
```

Update the build scripts (or clone them at the first use):

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm run link-deps -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run deep-clean --config darwin-arm64  -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm install --config darwin-arm64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run build-develop --config darwin-arm64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

Several minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpack-dev-tools/openocd-xpack.git/build/darwin-arm64/deploy
total 4800
-rw-r--r--  1 ilg  staff  2451720 Jan 30 11:17 xpack-openocd-0.12.0-2-darwin-arm64.tar.gz
-rw-r--r--  1 ilg  staff      109 Jan 30 11:17 xpack-openocd-0.12.0-2-darwin-arm64.tar.gz.sha
```

#### Intel GNU/Linux

Run the docker build on the production machine (`xbbli`);
start a VS Code remote session, or connect with a terminal:

```sh
caffeinate ssh xbbli
```

##### Build the GNU/Linux binaries

Update the build scripts (or clone them at the first use):

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm run link-deps -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run deep-clean --config linux-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-prepare --config linux-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-link-deps --config linux-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run docker-build-develop --config linux-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

Several minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpack-dev-tools/openocd-xpack.git/build/linux-x64/deploy
total 2732
-rw-r--r-- 1 ilg ilg 2789919 Jan 30 09:20 xpack-openocd-0.12.0-2-linux-x64.tar.gz
-rw-r--r-- 1 ilg ilg     106 Jan 30 09:20 xpack-openocd-0.12.0-2-linux-x64.tar.gz.sha
```

##### Build the Windows binaries

Clean the build folder and prepare the docker container:

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm run link-deps -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run deep-clean --config win32-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-prepare --config win32-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-link-deps --config win32-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run docker-build-develop --config win32-x64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

About 5 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpack-dev-tools/openocd-xpack.git/build/win32-x64/deploy
total 3088
-rw-r--r-- 1 ilg ilg 3156989 Jan 30 09:41 xpack-openocd-0.12.0-2-win32-x64.zip
-rw-r--r-- 1 ilg ilg     103 Jan 30 09:41 xpack-openocd-0.12.0-2-win32-x64.zip.sha
```

#### Arm GNU/Linux 64-bit

Run the docker build on the production machine (`xbbla64`);
start a VS Code remote session, or connect with a terminal:

```sh
caffeinate ssh xbbla64
```

Update the build scripts (or clone them at the first use):

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm run link-deps -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run deep-clean --config linux-arm64 -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-prepare --config linux-arm64 -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-link-deps --config linux-arm64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run docker-build-develop --config linux-arm64 -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

About 10 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpack-dev-tools/openocd-xpack.git/build/linux-arm64/deploy
total 2676
-rw-r--r-- 1 ilg ilg 2732671 Jan 30 09:24 xpack-openocd-0.12.0-2-linux-arm64.tar.gz
-rw-r--r-- 1 ilg ilg     108 Jan 30 09:24 xpack-openocd-0.12.0-2-linux-arm64.tar.gz.sha
```

#### Arm GNU/Linux 32-bit

Run the docker build on the production machine (`xbbla32`);
start a VS Code remote session, or connect with a terminal:

```sh
caffeinate ssh xbbla32
```

Update the build scripts (or clone them at the first use):

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm run link-deps -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run deep-clean --config linux-arm -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-prepare --config linux-arm -C ~/Work/xpack-dev-tools/openocd-xpack.git && \
xpm run docker-link-deps --config linux-arm -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run docker-build-develop --config linux-arm -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

About 10 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpack-dev-tools/openocd-xpack.git/build/linux-arm/deploy
total 2592
-rw-r--r-- 1 ilg ilg 2649660 Jan 30 09:25 xpack-openocd-0.12.0-2-linux-arm.tar.gz
-rw-r--r-- 1 ilg ilg     106 Jan 30 09:25 xpack-openocd-0.12.0-2-linux-arm.tar.gz.sha
```

### Build a debug version

In some cases it is necessary to run a debug session in the binaries,
or even in the libraries functions.

For these cases, the build script accepts the `--debug` options.

There are also xPack actions that use this option (`build-develop-debug`
and `docker-build-develop-debug`).

### Files cache

The XBB build scripts use a local cache such that files are downloaded only
during the first run, later runs being able to use the cached files.

However, occasionally some servers may not be available, and the builds
may fail.

The workaround is to manually download the files from an alternate
location (like
<https://github.com/xpack-dev-tools/files-cache/tree/master/libs>),
place them in the XBB cache (`Work/cache`) and restart the build.

## Run the CI build

The automation is provided by GitHub Actions and three self-hosted runners.

### Generate the GitHub workflows

Run the `generate-workflows` to re-generate the
GitHub workflow files; commit and push if necessary.

### Start the self-hosted runners

- on the development machine (`wksi`) open ssh sessions to the build
machines (`xbbma`, `xbbli`, `xbbla64` and `xbbla32`):

```sh
caffeinate ssh xbbma
caffeinate ssh xbbli
caffeinate ssh xbbla64
caffeinate ssh xbbla32
```

For `xbbli` & `xbbla64` start two runners:

```sh
screen -S ga

~/actions-runners/xpack-dev-tools/1/run.sh &
~/actions-runners/xpack-dev-tools/2/run.sh &

# Ctrl-a Ctrl-d
```

On all other machines start a single runner:

```sh
screen -S ga

~/actions-runners/xpack-dev-tools/run.sh &

# Ctrl-a Ctrl-d
```

### Push the build scripts

- push the `xpack-develop` branch to GitHub
- possibly push the helper project too

From here it'll be cloned on the production machines.

### Check for disk space

Check if the build machines have enough free space and eventually
do some cleanups (`df -BG -H /` on Linux, `df -gH /` on macOS).

### Manually trigger the build GitHub Actions

To trigger the GitHub Actions build, use the xPack action:

- `trigger-workflow-build-xbbmi`
- `trigger-workflow-build-xbbma`
- `trigger-workflow-build-xbbli`
- `trigger-workflow-build-xbbla64`
- `trigger-workflow-build-xbbla32`

This is equivalent to:

```sh
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-build.sh --machine xbbmi
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-build.sh --machine xbbma
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-build.sh --machine xbbli
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-build.sh --machine xbbla64
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-build.sh --machine xbbla32
```

These scripts require the `GITHUB_API_DISPATCH_TOKEN` variable to be present
in the environment, and the organization `PUBLISH_TOKEN` to be visible in the
Settings → Action →
[Secrets](https://github.com/xpack-dev-tools/openocd-xpack/settings/secrets/actions)
page.

These commands use the `xpack-develop` branch of this repo.

## Durations & results

The builds take about 10 minutes to complete:

- `xbbmi`: 7 min
- `xbbma`: 4 min
- `xbbli`: 5 min (4 min Linux, 5 min Windows)
- `xbbla64`: 11 min
- `xbbla32`: 12 min

The workflow result and logs are available from the
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions/) page.

The resulting binaries are available for testing from
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/).

## Testing

### CI tests

The automation is provided by GitHub Actions.

To trigger the GitHub Actions tests, use the xPack actions:

- `trigger-workflow-test-prime`
- `trigger-workflow-test-docker-linux-intel`
- `trigger-workflow-test-docker-linux-arm`

These are equivalent to:

```sh
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-test-prime.sh
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-test-docker-linux-intel.sh
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-workflow-test-docker-linux-arm.sh
```

These scripts require the `GITHUB_API_DISPATCH_TOKEN` variable to be present
in the environment.

These actions use the `xpack-develop` branch of this repo and the
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/)
binaries.

The tests results are available from the
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions/) page.

Since GitHub Actions provides a single version of macOS, the
multi-version macOS tests run on Travis.

To trigger the Travis test, use the xPack action:

- `trigger-travis-macos`

This is equivalent to:

```sh
bash ~/Work/xpack-dev-tools/openocd-xpack.git/xpacks/@xpack-dev-tools/xbb-helper/github-actions/trigger-travis-macos.sh
```

This script requires the `TRAVIS_COM_TOKEN` variable to be present
in the environment.

The test results are available from
[Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/openocd-xpack/builds/).

### Manual tests

To download the pre-released archive for the specific platform
and run the tests, use:

```sh
git -C ~/Work/xpack-dev-tools/openocd-xpack.git pull
xpm run install -C ~/Work/xpack-dev-tools/openocd-xpack.git
xpm run test-pre-release -C ~/Work/xpack-dev-tools/openocd-xpack.git
```

For even more tests, on each platform (MacOS, GNU/Linux, Windows),
download the archive from
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/)
and check the binaries.

On macOS, remove the `com.apple.quarantine` flag:

```sh
xattr -cr ${HOME}/Downloads/xpack-*
```

Functional tests cannot run on CI since they require physical hardware.

For the simplest functional case, plug a common board like the
STM32F4DISCOVERY into an USB port, start the program and check
if the CPU is identified.

Note: If this is the first time openocd is executed, on GNU/Linux
it is necessary
to configure the rights, otherwise LIBUSB will issue the _libusb_open
failed: LIBUSB_ERROR_ACCESS_ error.

```sh
sudo cp ~/Downloads/xpack-openocd-0.12.0-2/contrib/60-openocd.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
```

Then it is possible to start openocd:

```console
$ .../xpack-openocd-0.12.0-2/bin/openocd -f "board/stm32f4discovery.cfg"
xPack Open On-Chip Debugger 0.12.0-01004-g9ea7f3d64-dirty (2023-01-30-16:23)
Licensed under GNU GPL v2
For bug reports, read
	https://openocd.org/doc/doxygen/bugs.html
Info : The selected transport took over low-level target control. The results might differ compared to plain JTAG/SWD
srst_only separate srst_nogate srst_open_drain connect_deassert_srst

Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Info : clock speed 2000 kHz
Info : STLINK V2J39S0 (API v2) VID:PID 0483:3748
Info : Target voltage: 2.901598
Info : [stm32f4x.cpu] Cortex-M4 r0p1 processor detected
Info : [stm32f4x.cpu] target has 6 breakpoints, 4 watchpoints
Info : starting gdb server for stm32f4x.cpu on 3333
Info : Listening on port 3333 for gdb connections
[stm32f4x.cpu] halted due to breakpoint, current mode: Handler HardFault
xPSR: 0x61000003 pc: 0x080002d6 msp: 0x2001ff78
^C
shutdown command invoked
```

Note: on recent macOS systems it might be necessary to allow individual
programs to run.

For a more thorough test, run a debug session with
the Eclipse STM32F4DISCOVERY blinky test
available in the xpack-arm-none-eabi-openocd package, which uses
the `-f "board/stm32f4discovery.cfg"` configuration file
(import the `arm-f4b-fs` project and start the `arm-f4b-fs-debug-oocd`
launcher).

## Create a new GitHub pre-release draft

- in `CHANGELOG.md`, add the release date and a message like _* v0.12.0-2 released_
- commit with _CHANGELOG update_
- check and possibly update the `templates/body-github-release-liquid.md`
- push the `xpack-develop` branch
- run the xPack action `trigger-workflow-publish-release`

The workflow result and logs are available from the
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions/) page.

The result is a
[draft pre-release](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
tagged like **v0.12.0-2** (mind the dash in the middle!) and
named like **xPack OpenOCD v0.12.0-2** (mind the dash),
with all binaries attached.

- edit the draft and attach it to the `xpack-develop` branch (important!)
- save the draft (do **not** publish yet!)

## Prepare a new blog post

- check and possibly update the `templates/body-jekyll-release-*-liquid.md`
- run the xPack action `generate-jekyll-post`; this will leave a file
on the Desktop.

In the `xpack/web-jekyll` GitHub repo:

- select the `develop` branch
- copy the new file to `_posts/releases/openocd`

If any, refer to closed
[issues](https://github.com/xpack-dev-tools/openocd-xpack/issues/).

## Update the preview Web

- commit the `develop` branch of `xpack/web-jekyll` GitHub repo;
  use a message like _xPack OpenOCD v0.12.0-2 released_
- push to GitHub
- wait for the GitHub Pages build to complete
- the preview web is <https://xpack.github.io/web-preview/news/>

## Create the pre-release

- go to the GitHub [Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/) page
- perform the final edits and check if everything is fine
- temporarily fill in the _Continue Reading »_ with the URL of the
  web-preview release
- **keep the pre-release button enabled**
- do not enable Discussions yet
- publish the release

Note: at this moment the system should send a notification to all clients
watching this project.

## Update the READMEs listings and examples

- check and possibly update the `ls -l` output
- check and possibly update the output of the `--version` runs
- check and possibly update the output of `tree -L 2`
- commit changes

## Check the list of links

- open the `package.json` file
- check if the links in the `bin` property cover the actual binaries
- if necessary, also check on Windows

## Update package.json binaries

- select the `xpack-develop` branch
- run the xPack action `update-package-binaries`
- open the `package.json` file
- check the `baseUrl:` it should match the file URLs (including the tag/version);
  no terminating `/` is required
- from the release, check the SHA & file names
- compare the SHA sums with those shown by `cat *.sha`
- check the executable names
- commit all changes, use a message like
  _package.json: update urls for 0.12.0-2.1 release_ (without _v_)

## Publish on the npmjs.com server

- select the `xpack-develop` branch
- check the latest commits `npm run git-log`
- update `CHANGELOG.md`, add a line like _* v0.12.0-2 published on npmjs.com_
- commit with a message like _CHANGELOG: publish npm v0.12.0-2.1_
- `npm pack` and check the content of the archive, which should list
  only the `package.json`, the `README.md`, `LICENSE` and `CHANGELOG.md`;
  possibly adjust `.npmignore`
- `npm version 0.12.0-2.1`; the first 4 numbers are the same as the
  GitHub release; the fifth number is the npm specific version
- the commits and the tag should have been pushed by the `postversion` script;
  if not, push them with `git push origin --tags`
- `npm publish --tag next` (use `npm publish --access public`
  when publishing for the first time; add the `next` tag)

After a few moments the version will be visible at:

- <https://www.npmjs.com/package/@xpack-dev-tools/openocd?activeTab=versions>

## Test if the binaries can be installed with xpm

Run the xPack action `trigger-workflow-test-xpm`, this
will install the package via `xpm install` on all supported platforms.

The tests results are available from the
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions/) page.

## Update the repo

- merge `xpack-develop` into `xpack`
- push to GitHub

## Tag the npm package as `latest`

When the release is considered stable, promote it as `latest`:

- `npm dist-tag ls @xpack-dev-tools/openocd`
- `npm dist-tag add @xpack-dev-tools/openocd@0.12.0-2.1 latest`
- `npm dist-tag ls @xpack-dev-tools/openocd`

In case the previous version is not functional and needs to be unpublished:

- `npm unpublish @xpack-dev-tools/openocd@0.12.0-2.1`

## Update the Web

- in the `master` branch, merge the `develop` branch
- wait for the GitHub Pages build to complete
- the result is in <https://xpack.github.io/news/>
- remember the post URL, since it must be updated in the release page

## Create the final GitHub release

- go to the GitHub [Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/) page
- check the download counter, it should match the number of tests
- add a link to the Web page `[Continue reading »]()`; use an same blog URL
- remove the _tests only_ notice
- **disable** the **pre-release** button
- click the **Update Release** button

## Share on Twitter

- in a separate browser windows, open [TweetDeck](https://tweetdeck.twitter.com/)
- using the `@xpack_project` account
- paste the release name like **xPack OpenOCD v0.12.0-2 released**
- paste the link to the Web page
  [release](https://xpack.github.io/openocd/releases/)
- click the **Tweet** button

## Check SourceForge mirror

- <https://sourceforge.net/projects/openocd-xpack/files/>

## Remove the pre-release binaries

- go to <https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/>
- remove the test binaries

## Clean the work area

Run the xPack action `trigger-workflow-deep-clean`, this
will remove the build folders on all supported platforms.

The results are available from the
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions/) page.
