# How to build the xPack OpenOCD?

## Introduction

This project also includes the scripts and additional files required to 
build and publish the
[xPack OpenOCD](https://github.com/xpack-dev-tools/openocd-xpack) binaries.

The build scripts use the
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), 
a set of elaborate build environments based on GCC 7.4 (Docker containers
for GNU/Linux and Windows or a custom folder for MacOS).

## Repository URLs

- `https://github.com/xpack-dev-tools/openocd.git` - the URL of the 
  [xPack OpenOCD fork](https://github.com/xpack-dev-tools/openocd)
- `git://git.code.sf.net/p/openocd/code` - the URL of the 
  [upstream OpenOCD](http://openocd.org).

The build scripts use the first; to merge
changes from upstream it is necessary to add a remote named
`upstream`, and merge the upstream master into the local master.

## Branches

- `xpack` - the updated content, used during the builds
- `master` - the original content; it follows the upstream master.

## Download the build scripts

The build scripts are available in the `scripts` folder of the 
[`xpack-dev-tools/openocd-xpack`](https://github.com/xpack-dev-tools/openocd-xpack) 
Git repo.

To download them, the following shortcut is available: 

```console
$ curl -L https://github.com/xpack-dev-tools/openocd-xpack/raw/xpack/scripts/git-clone.sh | bash
```

The small script issues the following two commands:

```console
$ rm -rf ~/Downloads/openocd-xpack.git
$ git clone --recurse-submodules https://github.com/xpack-dev-tools/openocd-xpack.git \
~/Downloads/openocd-xpack.git
```

> Note: the repository uses submodules; for a successful build it is 
> mandatory to recurse the submodules.

To use the `develop` branch of the build scripts, use:

```console
$ rm -rf ~/Downloads/openocd-xpack.git
$ git clone --recurse-submodules -b develop https://github.com/xpack-dev-tools/openocd-xpack.git \
~/Downloads/openocd-xpack.git
```

## The `Work` folder

The scripts create a temporary build `Work/openocd-${version}` folder in 
the user home. Although not recommended, if for any reasons you need to 
change the location of the `Work` folder, 
you can redefine `WORK_FOLDER_PATH` variable before invoking the script.

## Changes

Compared to the original OpenOCD distribution, there should be no 
functional changes. 

The actual changes for each version are documented in the 
`scripts/README-<version>.md` files.

## How to build local/native binaries

TBD

## How to build distributions

### Prerequisites

The prerequisites are common to all binary builds. Please follow the 
instructions in the separate 
[Prerequisites for building binaries](https://gnu-mcu-eclipse.github.io/developer/build-binaries-prerequisites-xbb/) 
page and return when ready.

### Update git repos

To keep the development repository in sync with the original OpenOCD 
repository and the RISC-V repository:

- checkout `master`
- merge from `upstream/master`
- checkout `xpack`
- merge `master`
- add a tag like `v0.10.0-8` after each public release (mind the 
inner version `-8`)

### Prepare release

To prepare a new release, first determine the OpenOCD version 
(like `0.10.0`) and update the `scripts/VERSION` file. The format is 
`0.10.0-8`. The fourth digit is the xPack release number 
of this version. A fifth digit will be used when publishing 
the package on the npm server.

Add a new set of definitions in the `scripts/container-build.sh`, with 
the versions of various components.

### Update `README.md`

If necessary, update the main `README.md` with informations related to the
build. Information related to the new version should not be included here,
but in the version specific file (below).

### Create `README-<version>.md`

In the `scripts` folder create a copy of the previous one and update the
Git commit and possible other details.

### Update `CHANGELOG.md`

Check `CHANGELOG.md` and add the new release.

### Build

Although it is perfectly possible to build all binaries in a single step 
on a macOS system, due to Docker specifics, it is faster to build the 
GNU/Linux and Windows binaries on a GNU/Linux system and the macOS binary 
separately on a macOS system.

#### Build the GNU/Linux and Windows binaries

The current platform for GNU/Linux and Windows production builds is an 
Ubuntu Server 18 LTS, running on an Intel NUC8i7BEH mini PC with 32 GB of RAM 
and 512 GB of fast M.2 SSD.

```console
$ ssh ilg-xbb-linux.local
```

Before starting a build, check if Docker is started:

```console
$ docker info
```

Before running a build for the first time, it is recommended to preload the
docker images.

```console
$ bash ~/Downloads/openocd-xpack.git/scripts/build.sh preload-images
```

The result should look similar to:

```console
$ docker images
REPOSITORY TAG IMAGE ID CREATED SIZE
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ilegeul/centos32    6-xbb-v2.2          956eb2963946        5 weeks ago         3.03GB
ilegeul/centos      6-xbb-v2.2          6b1234f2ac44        5 weeks ago         3.12GB
hello-world         latest              fce289e99eb9        5 months ago        1.84kB
```

Since the build takes a while, use `screen` to isolate the build session
from unexpected events, like a broken
network connection or a computer entering sleep.

```console
$ screen -S openocd

$ sudo rm -rf ~/Work/openocd-*
$ bash ~/Downloads/openocd-xpack.git/scripts/build.sh --all
```

To detach from the session, use `Ctrl-a` `Ctrl-d`; to reattach use
`screen -r openocd`; to kill the session use `Ctrl-a` `Ctrl-\` and confirm.

About 10-15 minutes later, the output of the build script is a set of 4 
archives and their SHA signatures, created in the `deploy` folder:

```console
$ ls -l deploy
total 12952
-rw-rw-rw- 1 ilg ilg 3542064 Jun 19 14:21 xpack-openocd-0.10.0-12-linux-x32.tgz
-rw-rw-rw- 1 ilg ilg     104 Jun 19 14:21 xpack-openocd-0.10.0-12-linux-x32.tgz.sha
-rw-rw-rw- 1 ilg ilg 3465777 Jun 19 14:14 xpack-openocd-0.10.0-12-linux-x64.tgz
-rw-rw-rw- 1 ilg ilg     104 Jun 19 14:14 xpack-openocd-0.10.0-12-linux-x64.tgz.sha
-rw-rw-rw- 1 ilg ilg 3117732 Jun 19 14:24 xpack-openocd-0.10.0-12-win32-x32.zip
-rw-rw-rw- 1 ilg ilg     104 Jun 19 14:24 xpack-openocd-0.10.0-12-win32-x32.zip.sha
-rw-rw-rw- 1 ilg ilg 3109501 Jun 19 14:18 xpack-openocd-0.10.0-12-win32-x64.zip
-rw-rw-rw- 1 ilg ilg     104 Jun 19 14:18 xpack-openocd-0.10.0-12-win32-x64.zip.sha
```

To copy the files from the build machine to the current development 
machine, either use NFS to mount the entire folder, or open the `deploy` 
folder in a terminal and use `scp`:

```console
$ cd ~/Work/openocd-*/deploy
$ scp * ilg@ilg-mbp.local:Downloads/xpack-binaries/openocd
```

#### Build the macOS binary

The current platform for macOS production builds is a macOS 10.10.5 
VirtualBox image running on a macMini with 16 GB of RAM and a 
fast SSD.

To build the latest macOS version:

```console
$ rm -rf ~/Work/openocd-*
$ caffeinate bash ~/Downloads/openocd-xpack.git/scripts/build.sh --osx
```

Several minutes later, the output of the build script is a compressed 
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l deploy
total 6280
-rw-r--r--  1 ilg  staff  2855153 Jun 17 20:19 xpack-openocd-0.10.0-12-darwin-x64.tgz
-rw-r--r--  1 ilg  staff      105 Jun 17 20:19 xpack-openocd-0.10.0-12-darwin-x64.tgz.sha
```

To copy the files from the build machine to the current development 
machine, either use NFS to mount the entire folder, or open the `deploy` 
folder in a terminal and use `scp`:

```console
$ cd ~/Work/openocd-*/deploy
$ scp * ilg@ilg-mbp.local:Downloads/xpack-binaries/openocd
```

### Subsequent runs

#### Separate platform specific builds

Instead of `--all`, you can use any combination of:

```
--win32 --win64 --linux32 --linux64
```

#### `clean`

To remove most build temporary files, use:

```console
$ bash ~/Downloads/openocd-xpack.git/scripts/build.sh --all clean
```

To also remove the library build temporary files, use:

```console
$ bash ~/Downloads/openocd-xpack.git/scripts/build.sh --all cleanlibs
```

To remove all temporary files, use:

```console
$ bash ~/Downloads/openocd-xpack.git/scripts/build.sh --all cleanall
```

Instead of `--all`, any combination of `--win32 --win64 --linux32 --linux64`
will remove the more specific folders.

For production builds it is recommended to completely remove the build folder.

#### `--develop`

For performance reasons, the actual build folders are internal to each 
Docker run, and are not persistent. This gives the best speed, but has 
the disadvantage that interrupted builds cannot be resumed.

For development builds, it is possible to define the build folders in 
the host file system, and resume an interrupted build.

#### `--debug`

For development builds, it is also possible to create everything with 
`-g -O0` and be able to run debug sessions.

#### Interrupted builds

The Docker scripts run with root privileges. This is generally not a 
problem, since at the end of the script the output files are reassigned 
to the actual user.

However, for an interrupted build, this step is skipped, and files in 
the install folder will remain owned by root. Thus, before removing 
the build folder, it might be necessary to run a recursive `chown`.

## Test

A simple test is performed by the script at the end, by launching the 
executable to check if all shared/dynamic libraries are correctly used.

For a true test you need to first install the package and then run the 
program from the final location. For example on macOS the output should 
look like:

```console
$ xpm install --global @xpack-dev-tools/openocd

$ /Users/ilg/Library/xPacks/\@xpack-dev-tools/openocd/0.10.0-8.1/.content/bin/openocd --version
xPack 64-bit Open On-Chip Debugger 0.10.0+dev-00487-gaf359c18 (2018-05-12-23:16)
```

## Installed folders

After install, the package should create a structure like this (only the 
first two depth levels are shown):

```console
$ tree -L 2 /Users/ilg/Library/xPacks/\@xpack-dev-tools/openocd/0.10.0-8.1/.content/
/Users/ilg/Library/xPacks/\@xpack-dev-tools/openocd/0.10.0-8.1/.content/
├── OpenULINK
│   └── ulink_firmware.hex
├── README.md
├── bin
│   └── openocd
├── contrib
│   ├── 60-openocd.rules
│   └── libdcc
├── distro-info
│   ├── CHANGELOG.txt
│   ├── licenses
│   ├── patches
│   └── scripts
├── scripts
│   ├── bitsbytes.tcl
│   ├── board
│   ├── chip
│   ├── cpld
│   ├── cpu
│   ├── fpga
│   ├── interface
│   ├── mem_helper.tcl
│   ├── memory.tcl
│   ├── mmr_helpers.tcl
│   ├── target
│   ├── test
│   └── tools
└── share
└── doc
```

No other files are installed in any system folders or other locations.

## Uninstall

The binaries are distributed as portable archives; thus they do not need 
to run a setup and do not require an uninstall.

## More build details

The build process is split into several scripts. The build starts on 
the host, with `build.sh`, which runs `container-build.sh` several 
times, once for each target, in one of the two docker containers. 
Both scripts include several other helper scripts. The entire process 
is quite complex, and an attempt to explain its functionality in a few 
words would not be realistic. Thus, the authoritative source of details 
remains the source code.
