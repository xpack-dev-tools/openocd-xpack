# How to make a new release (maintainer info)

## Release schedule

In the past, the OpenCOD had no release schedule, and very rare releases.
The xPack OpenOCD releases also had no schedules, and were done on an
as-needed basis. As a general rule, it is planned to follow the upstream
releases and add releases from the repo HEAD from time to time.

## Prepare the build

Before starting the build, perform some checks and tweaks.

### Check Git

In the `xpack-dev-tools/openocd-xpack` Git repo:

- switch to the `xpack-develop` branch
- if needed, merge the `xpack` branch

No need to add a tag here, it'll be added when the release is created.

### Increase the version

Determine the version (like `0.11.0`) and update the `scripts/VERSION`
file; the format is `0.11.0-2`. The fourth number is the xPack release number
of this version. A fifth number will be added when publishing
the package on the `npm` server.

### Fix possible open issues

Check GitHub issues and pull requests:

- <https://github.com/xpack-dev-tools/openocd-xpack/issues>

and fix them; assign them to a milestone (like `0.11.0-2`).

### Check `README.md`

Normally `README.md` should not need changes, but better check.
Information related to the new version should not be included here,
but in the version specific file (below).

### Update versions in `README` files

- update version in `README-RELEASE.md`
- update version in `README-BUILD.md`
- update version in `README.md`

## Update `CHANGELOG.md`

- open the `CHANGELOG.md` file
- check if all previous fixed issues are in
- add a new entry like _v0.11.0-2 prepared_
- commit with a message like _prepare v0.11.0-2_

Note: if you missed to update the `CHANGELOG.md` before starting the build,
edit the file and rerun the build, it should take only a few minutes to
recreate the archives with the correct file.

### Update the version specific code

- open the `common-versions-source.sh` file
- add a new `if` with the new version before the existing code

### Update helper

With Sourcetree, go to the helper repo and update to the latest master commit.

### Merge upstream repo

To keep the development repository in sync with the upstream OpenOCD
repository, in the `xpack-dev-tools/openocd` Git repo:

- checkout `master`
- merge from `upstream/master`
- checkout `xpack-develop`
- merge `master`
- fix conflicts (in `60-openocd.rules` and possibly other)
- checkout `xpack`
- merge `xpack-develop`

Possibly add a tag here.

## Build

### Development run the build scripts

Before the real build, run a test build on the development machine (`wks`):

```sh
sudo rm -rf ~/Work/openocd-*

caffeinate bash ~/Downloads/openocd-xpack.git/scripts/build.sh --develop --without-pdf --without-html --disable-tests --osx
```

Similarly on the Intel Linux:

```sh
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --develop --without-pdf --without-html --disable-tests --linux64
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --develop --without-pdf --without-html --disable-tests --linux32

bash ~/Downloads/openocd-xpack.git/scripts/build.sh --develop --without-pdf --without-html --disable-tests --win64
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --develop --without-pdf --without-html --disable-tests --win32
```

And on the Arm Linux:

```sh
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --develop --without-pdf --without-html --disable-tests --arm64
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --develop --without-pdf --without-html --disable-tests --arm32
```

Work on the scripts until all platforms pass the build.

## Push the build scripts

In this Git repo:

- push the `xpack-develop` branch to GitHub
- possibly push the helper project too

From here it'll be cloned on the production machines.

### Run the build scripts automatically

The automation is provided by GitHub Actions and self-hosted runners.

- on the macOS machine (`xbbm`) open ssh sessions to both Linux machines (`xbbi` and `xbba`)

```sh
caffeinate ssh xbbi

caffeinate ssh xbba
```

- start the runner (`~/actions-runner/run.sh`) on all three machines
- check that both the project Git and the submodule are pushed
- trigger the build via GitHub Actions

```sh
bash ~/Downloads/openocd-xpack.git/scripts/helper/trigger-workflow-build.sh
```

This is also available as an xPack action (`trigger-workflow-build`)

This command uses the `xpack-develop` branch of this repo.

The workflow result and logs are available from the
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions) page.

When the actions complete, the results are available for testing from
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test).

### Run the build scripts manually

The same result can be obtained with a lot of manual steps.

#### Open sessions to the build machines

On the macOS machine (`xbbm`) open ssh sessions to both Linux machines
(`xbbi` and `xbba`):

```sh
caffeinate ssh xbbi

caffeinate ssh xbba
```

#### Checkout the build scripts

On all machines, clone the `xpack-develop` branch:

```sh
rm -rf ~/Downloads/openocd-xpack.git; \
git clone \
  --recurse-submodules \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/openocd-xpack.git \
  ~/Downloads/openocd-xpack.git

sudo rm -rf ~/Work/openocd-*
```

#### Run the build scripts

Empty trash.

On the macOS machine (`xbbm`):

```sh
caffeinate bash ~/Downloads/openocd-xpack.git/scripts/build.sh --osx
```

A typical run takes about 10 minutes.

On `xbbi`:

```sh
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --all

bash ~/Downloads/openocd-xpack.git/scripts/build.sh --linux64 --win64
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --linux32 --win32
```

A typical run on the Intel machine takes about 25 minutes.

On `xbba`:

```sh
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --all

bash ~/Downloads/openocd-xpack.git/scripts/build.sh --arm64
bash ~/Downloads/openocd-xpack.git/scripts/build.sh --arm32
```

A typical run on the Arm machine it takes about 60 minutes.

#### Clean the destination folder

On the development machine (`wks`) clean the folder where binaries from all
build machines will be collected.

```sh
rm -f ~/Downloads/xpack-binaries/openocd/*
```

#### Copy the binaries to the development machine

On all three machines:

```sh
(cd ~/Work/openocd-*/deploy; scp * ilg@wks:Downloads/xpack-binaries/openocd)
```

#### Upload the binaries to the pre-release site

Edit the
[test pre-release](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test)
and upload the binaries.

## Testing

### Automated tests

The automation is provided by GitHub Actions.

To trigger the actions, use:

```sh
bash ~/Downloads/openocd-xpack.git/scripts/helper/tests/trigger-workflow-test-native.sh
bash ~/Downloads/openocd-xpack.git/scripts/helper/tests/trigger-workflow-test-docker-linux-intel.sh
bash ~/Downloads/openocd-xpack.git/scripts/helper/tests/trigger-workflow-test-docker-linux-arm.sh
```

This is also available as an xPack action (`trigger-workflow-test-native`,
`trigger-workflow-test-docker-linux-intel`, `trigger-workflow-test-docker-linux-arm`).

These command uses the `xpack-develop` branch of this repo and the
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test)
binaries.

The workflow result and logs are available from the
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions) page.

Since GitHub Actions provides a single version of macOS, the
multi-version tests run on Travis. 

The script requires 

```sh
bash ~/Downloads/openocd-xpack.git/scripts/helper/tests/trigger-travis-macos.sh
```

This is also available as an xPack action (`trigger-travis-macos`).

The results are available from
[Travis](https://app.travis-ci.com/github/xpack-dev-tools/openocd-xpack/builds).

### Manual tests

Install the binaries on all supported platforms and check if they are
functional, using the Eclipse STM32F4DISCOVERY blinky test
available in the xpack-arm-none-eabi-gcc package, which uses
the `-f "board/stm32f4discovery.cfg"` configuration file
(import the `arm-f4b-fs` project and start the `arm-f4b-fs-debug-oocd`
launcher).

For platforms where Eclipse is not yet available (like 32-bit Arm),
simply start the program and check if the CPU is identified.

If this is the first time openocd is executed, on GNU/Linux it is necessary
to configure the rights, otherwise LIBUSB will issue the _libusb_open
failed: LIBUSB_ERROR_ACCESS_ error.

```sh
sudo cp ~Downloads/xpack-openocd-0.10.0-15/contrib/60-openocd.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
```

Then it is possible to start openocd:

```console
$ .../xpack-openocd-0.10.0-15/bin/openocd -f "board/stm32f4discovery.cfg"
xPack OpenOCD 64-bit Open On-Chip Debugger 0.11.0+dev-00359-g18bcdc43f (2021-08-29-16:57)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : The selected transport took over low-level target control. The results might differ compared to plain JTAG/SWD
srst_only separate srst_nogate srst_open_drain connect_deassert_srst

Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Info : clock speed 2000 kHz
Info : STLINK V2J14S0 (API v2) VID:PID 0483:3748
Info : Target voltage: 2.893326
Info : stm32f4x.cpu: hardware has 6 breakpoints, 4 watchpoints
Info : starting gdb server for stm32f4x.cpu on 3333
Info : Listening on port 3333 for gdb connections
target halted due to breakpoint, current mode: Thread 
xPSR: 0x21000000 pc: 0x0800113c msp: 0x2001ff78
^C
shutdown command invoked
```

Note: on recent macOS systems it might be necessary to allow individual
programs to run.

## Create a new GitHub pre-release

- in `CHANGELOG.md`, add release date
- commit and push the `xpack-develop` branch
- go to the GitHub [releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/) page
- click **Draft a new release**, in the `xpack-develop` branch
- name the tag like **v0.11.0-2** (mind the dash in the middle!)
- name the release like **xPack OpenOCD v0.11.0-2**
(mind the dash)
- as description, use:

```markdown
![Github Releases (by Release)](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/v0.11.0-2/total.svg)

Version v0.11.0-2 is a new release of the **xPack OpenOCD** package, following the OpenOCD release.

_At this moment these binaries are provided for tests only!_
```

- **attach binaries** and SHA (drag and drop from the
  `~/Downloads/xpack-binaries/*` folder will do it)
- **enable** the **pre-release** button
- click the **Publish Release** button

Note: at this moment the system should send a notification to all clients
watching this project.

## Run the native tests

Run the native tests on all platforms:

```sh
rm -rf ~/Downloads/openocd-xpack.git; \
git clone --recurse-submodules -b xpack-develop \
  https://github.com/xpack-dev-tools/openocd-xpack.git  \
  ~/Downloads/openocd-xpack.git

rm -rf ~/Work/cache/xpack-openocd-*

bash ~/Downloads/openocd-xpack.git/scripts/tests/native-test.sh \
  "https://github.com/xpack-dev-tools/openocd-xpack/releases/download/v0.11.0-2/"
```

## Run the release CI tests

Using the scripts in `scripts/tests/`, start:

TODO:

The test results are available from:

- TODO

For more details, see `scripts/tests/README.md`.

Using the scripts in `scripts/tests/`, start:

- `trigger-travis-quick.mac.command` (optional)
- `trigger-travis-stable.mac.command`
- `trigger-travis-latest.mac.command`

The test results are available from:

- <https://travis-ci.com/github/xpack-dev-tools/openocd-xpack>

For more details, see `scripts/tests/README.md`.

## Prepare a new blog post

In the `xpack/web-jekyll` GitHub repo:

- select the `develop` branch
- add a new file to `_posts/openocd/releases`
- name the file like `2020-07-03-openocd-v0-11-0-1-released.md`
- name the post like: **xPack OpenOCD v0.11.0-2 released**
- as `download_url` use the tagged URL like `https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.11.0-2/`
- update the `date:` field with the current date
- update the Travis URLs using the actual test pages
- update the SHA sums via copy/paste from the original build machines
(it is very important to use the originals!)

If any, refer to closed
[issues](https://github.com/xpack-dev-tools/openocd-xpack/issues/)
as:

- **[Issue:\[#1\]\(...\)]**.

### Update the SHA sums

On the development machine (`wks`):

```sh
cat ~/Downloads/xpack-binaries/openocd/*.sha
```

Copy/paste the build report at the end of the post as:

```console
## Checksums
The SHA-256 hashes for the files are:

0a2a2550ec99b908c92811f8dbfde200956a22ab3d9af1c92ce9926bf8feddf9
xpack-openocd-0.11.0-2-darwin-x64.tar.gz

254588cbcd685748598dd7bbfaf89280ab719bfcd4dabeb0269fdb97a52b9d7a
xpack-openocd-0.11.0-2-linux-arm.tar.gz

10e30128d626f9640c0d585e6b65ac943de59fbdce5550386add015bcce408fa
xpack-openocd-0.11.0-2-linux-arm64.tar.gz

50f2e399382c29f8cdc9c77948e1382dfd5db20c2cb25c5980cb29774962483f
xpack-openocd-0.11.0-2-linux-ia32.tar.gz

9b147443780b7f825eec333857ac7ff9e9e9151fd17c8b7ce2a1ecb6e3767fd6
xpack-openocd-0.11.0-2-linux-x64.tar.gz

501366492cd73b06fca98b8283f65b53833622995c6e44760eda8f4483648525
xpack-openocd-0.11.0-2-win32-ia32.zip

dffc858d64be5539410aa6d3f3515c6de751cd295c99217091f5ccec79cabf39
xpack-openocd-0.11.0-2-win32-x64.zip
```

## Update the preview Web

- commit the `develop` branch of `xpack/web-jekyll` GitHub repo;
  use a message like **xPack OpenOCD v0.11.0-2 released**
- push
- wait for the GitHub Pages build to complete
- the preview web is <https://xpack.github.io/web-preview/news/>

## Update package.json binaries

- select the `xpack-develop` branch
- run `xpm-dev binaries-update`

```sh
xpm-dev binaries-update \
  -C "${HOME}/Downloads/openocd-xpack.git" \
  '0.11.0-2' \
  "${HOME}/Downloads/xpack-binaries/openocd"
```

- open the GitHub [releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
  page and select the latest release
- check the download counter, it should match the number of tests
- open the `package.json` file
- check the `baseUrl:` it should match the file URLs (including the tag/version);
  no terminating `/` is required
- from the release, check the SHA & file names
- compare the SHA sums with those shown by `cat *.sha`
- check the executable names
- commit all changes, use a message like
  `package.json: update urls for 0.11.0-2.1 release` (without `v`)

## Publish on the npmjs.com server

- select the `xpack-develop` branch
- check the latest commits `npm run git-log`
- update `CHANGELOG.md`; commit with a message like
  _CHANGELOG: publish npm v0.11.0-2.1_
- `npm pack` and check the content of the archive, which should list
  only the `package.json`, the `README.md`, `LICENSE` and `CHANGELOG.md`;
  possibly adjust `.npmignore`
- `npm version 0.11.0-2.1`; the first 5 numbers are the same as the
  GitHub release; the sixth number is the npm specific version
- push the `xpack-develop` branch to GitHub
- push tags with `git push origin --tags`
- `npm publish --tag next` (use `--access public` when publishing for
  the first time)

After a few moments the version will be visible at:

- <https://www.npmjs.com/package/@xpack-dev-tools/openocd?activeTab=versions>

## Test if the npm binaries can be installed with xpm

Run the `scripts/tests/trigger-travis-xpm-install.sh` script, this
will install the package on Intel Linux 64-bit, macOS and Windows 64-bit.

The test results are available from:

- <https://travis-ci.org/github/xpack-dev-tools/openocd-xpack>

For 32-bit Windows, 32-bit Intel GNU/Linux and 32-bit Arm, install manually.

```sh
xpm install --global @xpack-dev-tools/openocd@next
```

## Test the npm binaries

Install the binaries on all platforms.

```sh
xpm install --global @xpack-dev-tools/openocd@next
```

On GNU/Linux systems, including Raspberry Pi, use the following commands:

```sh
~/.local/xPacks/@xpack-dev-tools/openocd/0.11.0-2.1/.content/bin/openocd --version

openocd version 0.11.0

OpenOCD suite maintained and supported by Kitware (kitware.com/openocd).
```

On macOS, use:

```sh
~/Library/xPacks/@xpack-dev-tools/openocd/0.11.0-2.1/.content/bin/openocd --version

openocd version 0.11.0

OpenOCD suite maintained and supported by Kitware (kitware.com/openocd).
```

On Windows use:

```doscon
%USERPROFILE%\AppData\Roaming\xPacks\@xpack-dev-tools\openocd\0.11.0-2.1\.content\bin\openocd --version

openocd version 0.11.0

OpenOCD suite maintained and supported by Kitware (kitware.com/openocd).
```

## Update the repo

- merge `xpack-develop` into `xpack`
- push

## Tag the npm package as `latest`

When the release is considered stable, promote it as `latest`:

- `npm dist-tag ls @xpack-dev-tools/openocd`
- `npm dist-tag add @xpack-dev-tools/openocd@0.11.0-2.1 latest`
- `npm dist-tag ls @xpack-dev-tools/openocd`

## Update the Web

- in the `master` branch, merge the `develop` branch
- wait for the GitHub Pages build to complete
- the result is in <https://xpack.github.io/news/>
- remember the post URL, since it must be updated in the release page

## Create the final GitHub release

- go to the GitHub [releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/) page
- check the download counter, it should match the number of tests
- add a link to the Web page `[Continue reading »]()`; use an same blog URL
- **disable** the **pre-release** button
- click the **Update Release** button

## Share on Twitter

- in a separate browser windows, open [TweetDeck](https://tweetdeck.twitter.com/)
- using the `@xpack_project` account
- paste the release name like **xPack OpenOCD v0.11.0-2 released**
- paste the link to the Web page
  [release](https://xpack.github.io/openocd/releases/)
- click the **Tweet** button

## Remove pre-release binaries

- got to <https://github.com/xpack-dev-tools/pre-releases/releases/tag/test>
- remove the test binaries
