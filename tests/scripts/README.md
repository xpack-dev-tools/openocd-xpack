# Scripts to test the OpenOCD xPack

The binaries can be available from one of the pre-releases:

<https://github.com/xpack-dev-tools/pre-releases/releases>

## Download the repo

The test script is part of the OpenOCD xPack:

```sh
rm -rf ~/Downloads/opencod-xpack.git; \
git clone \
  --recurse-submodules \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/openocd-xpack.git  \
  ~/Downloads/openocd-xpack.git
```

## Start a local test

To check if OpenCOD starts on the current platform, run a native test:

```sh
bash ~/Downloads/openocd-xpack.git/tests/scripts/native-test.sh
```

The script stores the downloaded archive in a local cache, and
does not download it again if available locally.

To force a new download, remove the local archive:

```sh
rm -rf ~/Work/cache/xpack-openocd-*
```

## Start the Travis tests

The multi-platform test runs on Travis CI; it is configured to not fire on
git actions, but only via a manual POST to the Travis API.

```sh
bash ~/Downloads/openocd-xpack.git/tests/scripts/travis-trigger-stable.sh
bash ~/Downloads/openocd-xpack.git/tests/scripts/travis-trigger-latest.sh
```

For convenience, on macOS these can be invoked from Finder, using
the `travis-trigger-stable.mac.command` or
`travis-trigger-latest.mac.command` shortcuts.

The test results are available at
[Travis](https://travis-ci.com/github/xpack-dev-tools/openocd-xpack/builds/).
