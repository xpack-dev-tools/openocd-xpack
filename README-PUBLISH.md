# How to publish the xPack OpenOCD

## Build

Before starting the build, perform some checks.

### Check possible open issues

Check GitHub [issues](https://github.com/xpack-dev-tools/openocd-xpack/issues)
and fix them; do not close them yet.

### Check the `CHANGELOG.md` file

Open the `CHANGELOG.md` file and and check if all
new entries are in.

Generally, apart from packing, there should be no local changes compared
to the original OpenOCD distribution.

Note: if you missed to update the `CHANGELOG.md` before starting the build,
edit the file and rerun the build, it should take only a few minutes to
recreate the archives with the correct file.

### Check the version

The `VERSION` file should refer to the actual release.

### Push the build script

In this Git repo:

- if necessary, merge the `xpack-develop` branch into `xpack`.
- push it to GitHub.
- possibly push the helper project too.

### Run the build scripts

When everything is ready, follow the instructions in the
[build](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-BUILD.md)
page.

## Test

Install the binaries on all supported platforms and check if they are
functional, using the Eclipse STM32F4DISCOVERY blinky test
available in the xpack-arm-none-eabi-gcc package, which uses
the `-f "board/stm32f4discovery.cfg"` configuration file
(import the `arm-f4b-fs` project and start the `arm-f4b-fs-debug-oocd` 
launcher).

For platforms where Eclipse is not yet available (like Arm), simply start the
program and check if the CPU is identified.

If this is the first time openocd is executed, on GNU/Linux it is necessary
to configure the rights, otherwise LIBUSB will issue the _libusb_open
failed: LIBUSB_ERROR_ACCESS_ error.

```
sudo cp ~Downloads/xpack-openocd-0.10.0-14/contrib/60-openocd.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
```

Than it is possible to start openocd:

```
$ .../xpack-openocd-0.10.0-14/bin/openocd -f "board/stm32f4discovery.cfg"
xPack OpenOCD, x86_64 Open On-Chip Debugger 0.10.0+dev-00378-ge5be992df (2020-06-26-12:31)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : The selected transport took over low-level target control. The results might differ compared to plain JTAG/SWD
srst_only separate srst_nogate srst_open_drain connect_deassert_srst

Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Info : clock speed 2000 kHz
Info : STLINK V2J14S0 (API v2) VID:PID 0483:3748
Info : Target voltage: 2.894743
Info : stm32f4x.cpu: hardware has 6 breakpoints, 4 watchpoints
Info : starting gdb server for stm32f4x.cpu on 3333
Info : Listening on port 3333 for gdb connections
target halted due to breakpoint, current mode: Thread 
xPSR: 0x21000000 pc: 0x080010ec msp: 0x2001ff80
^C
shutdown command invoked
```

Note: on recent macOS systems it might be necessary to allow individual
programs to run.

## Create a new GitHub pre-release

- go to the [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases) page
- click the **Draft a new release** button
- name the tag like **v0.10.0-14** (mind the dash in the middle!)
- select the `xpack` branch
- name the release like **xPack OpenOCD v0.10.0-14** (mind the dash)
- as description
  - add a downloads badge like `![Github Releases (by Release)](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/v0.10.0-14/total.svg)`
  - draft a short paragraph explaining what are the main changes
- **attach binaries** and SHA (drag and drop from the archives folder will do it)
- **enable** the **pre-release** button
- click the **Publish Release** button

Note: at this moment the system should send a notification to all clients watching this project.

## Run the Travis tests

As URL, use something like

```
base_url="https://github.com/xpack-dev-tools/openocd-xpack/releases/download/v0.10.0-14/"
```

The test results are available at
[Travis](https://travis-ci.org/github/xpack-dev-tools/openocd-xpack/builds/).

For more details, see `tests/scripts/README.md`.

## Prepare a new blog post

In the `xpack.github.io` web Git:

- add a new file to `_posts/openocd/releases`
- name the file like `2019-07-17-openocd-v0-10-0-13-released.md`
- name the post like: **xPack OpenOCD v0.10.0-14 released**.
- as `download_url` use the tagged URL like `https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.10.0-14/`
- update the `date:` field with the current date

If any, close
[build issues](https://github.com/xpack-dev-tools/openocd-xpack/issues)
on the way. Refer to them as:

- **[Issue:\[#1\]\(...\)]**.

## Update the SHA sums

Copy/paste the build report at the end of the post as:

```console

## Checksums
The SHA-256 hashes for the files are:

06d2251a893f932b38f41c418cdc14e51893f68553ba5a183f02001bd92d9454  
xpack-openocd-0.10.0-14-darwin-x64.tar.gz

a1c7e77001cb549bd6b6dc00bb0193283179667e56f652182204229b55f58bc8  
xpack-openocd-0.10.0-14-linux-arm64.tar.gz

c812f12b7159b7f149c211fb521c0e405de64bb087f138cda8ea5ac04be87e15  
xpack-openocd-0.10.0-14-linux-arm.tar.gz

ebb4b08e8b94bd04b5493549b0ba2c02f1be5cc5f42c754e09a0c279ae8cc854  
xpack-openocd-0.10.0-14-linux-x32.tar.gz

687ac941c995eab069955fd673b6cd78a6b95048cac4a92728b09be444d0118e  
xpack-openocd-0.10.0-14-linux-x64.tar.gz

a0bde52aa8846a2a5b982031ad0bdebea55b9b3953133b363f54862473d71686  
xpack-openocd-0.10.0-14-win32-x32.zip

b25987e4153e42384ff6273ba228c3eaa7a61a2a6cc8f7a3fbf800099c3f6a49  
xpack-openocd-0.10.0-14-win32-x64.zip
```

If you missed this, `cat` the content of the `.sha` files:

```console
$ cd deploy
$ cat *.sha
```

## Update the Web

- commit the `xpack.github.io` project; use a message
  like **xPack OpenOCD v0.10.0-14 released**
- wait for the GitHub Pages build to complete
- remember the post URL, since it must be updated in the release page

## Publish on the npmjs server

- open [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases)
  and select the latest release
- check the download counter, it should match the number of tests
- update the `baseUrl:` with the file URLs (including the tag/version); 
no terminating `/` is required
- from the web release, copy the SHA & file names
- commit all changes, use a message like
  `package.json: update urls for 0.10.0-14 release` (without `v`)
- check the latest commits `npm run git-log`
- update `CHANGELOG.md`; commit with a message like
  _CHANGELOG: prepare npm v0.10.0-14.1_
- `npm version 0.10.0-14.1`; the first 4 numbers are the same as the
  GitHub release; the fifth number is the npm specific version
- `npm pack` and check the content of the archive, which should list
only the `package.json`, the `README.md`, `LICENSE` and `CHANGELOG.md`
- push all changes to GitHub
- `npm publish --tag next` (use `--access public` when publishing for the first time)

When the release is considered stable, promote it as `latest`:

- `npm dist-tag ls @xpack-dev-tools/openocd`
- `npm dist-tag add @xpack-dev-tools/openocd@0.10.0-14 latest`
- `npm dist-tag ls @xpack-dev-tools/openocd`

## Test npm binaries

Install the binaries on all platforms.

```console
$ xpm install --global @xpack-dev-tools/openocd@next
```

## Create the final GitHub release

- go to the [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases) page
- check the download counter, it should match the number of tests
- add a link to the Web page `[Continue reading »]()`; use an same blog URL
- **disable** the **pre-release** button
- click the **Update Release** button

## Share on Twitter

- in a separate browser windows, open [TweetDeck](https://tweetdeck.twitter.com/)
- using the `@xpack_project` account
- paste the release name like **xPack OpenOCD v0.10.0-14 released**
- paste the link to the blog release URL
- click the **Tweet** button
