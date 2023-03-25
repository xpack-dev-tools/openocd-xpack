[![license](https://img.shields.io/github/license/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/LICENSE)

# Developer info

## Prerequisites

The build scripts run on GNU/Linux and macOS. The Windows binaries are
generated on Intel GNU/Linux, using [mingw-w64](https://mingw-w64.org).

For GNU/Linux, the prerequisites are:

- `npm` (shipped with Node.js; installed via nvm, not the system package manager)
- `xpm` (installed via `npm`)
- `docker` (preferably a recent one, installed from docker.com)
- `git` (installed via the system package manager)

For macOS, the prerequisites are:

- `npm` (shipped with Node.js; installed via nvm)
- `xpm` (installed via `npm`)
- the Command Line Tools from Apple

For details on installing them, please read the
[XBB prerequisites page](https://xpack.github.io/xbb/prerequisites/).

## Get project sources

The project is hosted on GitHub:

- <https://github.com/xpack-dev-tools/openocd-xpack.git>

To clone the stable branch (`xpack`), run the following commands in a
terminal (on Windows use the _Git Bash_ console):

```sh
rm -rf ~/Work/xpacks/openocd-xpack.git && \
git clone https://github.com/xpack-dev-tools/openocd-xpack.git \
  ~/Work/xpacks/openocd-xpack.git
```

For development purposes, clone the `xpack-develop` branch:

```sh
rm -rf ~/Work/xpacks/openocd-xpack.git && \
mkdir -p ~/Work/xpacks && \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/openocd-xpack.git \
  ~/Work/xpacks/openocd-xpack.git
```

## Get helper sources

The project has a dependency to a common **helper**, that is
normally installed as a read-only dependency; for development
purposes, to be able to make changes to the helper, clone the
`xpack-develop` branch and link it to the central xPacks store:

```sh
rm -rf ~/Work/xpacks/xbb-helper-xpack.git && \
mkdir -p ~/Work/xpacks && \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/xbb-helper-xpack.git \
  ~/Work/xpacks/xbb-helper-xpack.git && \
xpm link -C ~/Work/xpacks/xbb-helper-xpack.git
```

Other repositories in use are:

- <https://github.com/openocd-org/openocd.git> - a read-only mirror of the
  upstream OpenOCD (<git://git.code.sf.net/p/openocd/code>)

## How to build

The builds currently require 5 dedicated machines (Intel GNU/Linux,
Arm 32 GNU/Linux, Arm 64 GNU/Linux, Intel macOS and Apple Silicon macOS).

### Intel macOS

Run the native build on an Intel Mac:

```sh
git -C ~/Work/xpacks/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpacks/openocd-xpack.git && \
xpm install --config darwin-x64 -C ~/Work/xpacks/openocd-xpack.git

xpm run build-develop --config darwin-x64 -C ~/Work/xpacks/openocd-xpack.git
```

About 10 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpacks/openocd-xpack.git/build/darwin-x64/deploy
total 4840
-rw-r--r--  1 ilg  staff  2471148 Jan 30 11:19 xpack-openocd-0.12.0-1-darwin-x64.tar.gz
-rw-r--r--  1 ilg  staff      107 Jan 30 11:19 xpack-openocd-0.12.0-1-darwin-x64.tar.gz.sha
```

#### Apple Silicon macOS

Run the native build on an Apple Silicon Mac:

```sh
git -C ~/Work/xpacks/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpacks/openocd-xpack.git && \
xpm install --config darwin-arm64 -C ~/Work/xpacks/openocd-xpack.git

xpm run build --config darwin-arm64 -C ~/Work/xpacks/openocd-xpack.git
```

Several minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpacks/openocd-xpack.git/build/darwin-arm64/deploy
total 4800
-rw-r--r--  1 ilg  staff  2451720 Jan 30 11:17 xpack-openocd-0.12.0-1-darwin-arm64.tar.gz
-rw-r--r--  1 ilg  staff      109 Jan 30 11:17 xpack-openocd-0.12.0-1-darwin-arm64.tar.gz.sha
```

#### Intel GNU/Linux

The docker builds run on a 64-bit Intel GNU/Linux.

##### Build the GNU/Linux binaries

```sh
git -C ~/Work/xpacks/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpacks/openocd-xpack.git && \
xpm run docker-prepare --config linux-x64 -C ~/Work/xpacks/openocd-xpack.git

xpm run docker-build --config linux-x64 -C ~/Work/xpacks/openocd-xpack.git
```

Several minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpacks/openocd-xpack.git/build/linux-x64/deploy
total 2732
-rw-r--r-- 1 ilg ilg 2789919 Jan 30 09:20 xpack-openocd-0.12.0-1-linux-x64.tar.gz
-rw-r--r-- 1 ilg ilg     106 Jan 30 09:20 xpack-openocd-0.12.0-1-linux-x64.tar.gz.sha
```

##### Build the Windows binaries

Clean the build folder and prepare the docker container:

```sh
git -C ~/Work/xpacks/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpacks/openocd-xpack.git && \
xpm run docker-prepare --config win32-x64 -C ~/Work/xpacks/openocd-xpack.git

xpm run docker-build --config win32-x64 -C ~/Work/xpacks/openocd-xpack.git
```

About 5 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpacks/openocd-xpack.git/build/win32-x64/deploy
total 3088
-rw-r--r-- 1 ilg ilg 3156989 Jan 30 09:41 xpack-openocd-0.12.0-1-win32-x64.zip
-rw-r--r-- 1 ilg ilg     103 Jan 30 09:41 xpack-openocd-0.12.0-1-win32-x64.zip.sha
```

#### Arm GNU/Linux 64-bit

Run the docker build on an aarch64 machine:

```sh
git -C ~/Work/xpacks/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpacks/openocd-xpack.git && \
xpm run docker-prepare --config linux-arm64 -C ~/Work/xpacks/openocd-xpack.git

xpm run docker-build --config linux-arm64 -C ~/Work/xpacks/openocd-xpack.git
```

About 10 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpacks/openocd-xpack.git/build/linux-arm64/deploy
total 2676
-rw-r--r-- 1 ilg ilg 2732671 Jan 30 09:24 xpack-openocd-0.12.0-1-linux-arm64.tar.gz
-rw-r--r-- 1 ilg ilg     108 Jan 30 09:24 xpack-openocd-0.12.0-1-linux-arm64.tar.gz.sha
```

#### Arm GNU/Linux 32-bit

Run the docker build on an armv7 machine:

```sh
git -C ~/Work/xpacks/openocd-xpack.git pull && \
xpm run install -C ~/Work/xpacks/openocd-xpack.git && \
xpm run docker-prepare --config linux-arm -C ~/Work/xpacks/openocd-xpack.git

xpm run docker-build --config linux-arm -C ~/Work/xpacks/openocd-xpack.git
```

About 10 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpacks/openocd-xpack.git/build/linux-arm/deploy
total 2592
-rw-r--r-- 1 ilg ilg 2649660 Jan 30 09:25 xpack-openocd-0.12.0-1-linux-arm.tar.gz
-rw-r--r-- 1 ilg ilg     106 Jan 30 09:25 xpack-openocd-0.12.0-1-linux-arm.tar.gz.sha
```

### Files cache

The XBB build scripts use a local cache such that files are downloaded only
during the first run, later runs being able to use the cached files.

However, occasionally some servers may not be available, and the builds
may fail.

The workaround is to manually download the files from an alternate
location (like
<https://github.com/xpack-dev-tools/files-cache/tree/master/libs>),
place them in the XBB cache (`Work/cache`) and restart the build.

### Manual tests

For the simplest functional case, plug a common board like the
STM32F4DISCOVERY into an USB port, start the program and check
if the CPU is identified.

Note: If this is the first time openocd is executed, on GNU/Linux
it is necessary
to configure the rights, otherwise LIBUSB will issue the _libusb_open
failed: LIBUSB_ERROR_ACCESS_ error.

```sh
sudo cp ~/Downloads/xpack-openocd-0.12.0-1/contrib/60-openocd.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
```

Then it is possible to start openocd:

```console
$ .../xpack-openocd-0.12.0-1/bin/openocd -f "board/stm32f4discovery.cfg"
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
