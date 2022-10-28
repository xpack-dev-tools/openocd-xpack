# Scripts to test the xPack OpenOCD

The binaries can be available from one of the pre-releases:

- <https://github.com/xpack-dev-tools/pre-releases/releases>

## Download the repo

The test script is part of the xPack OpenOCD:

```sh
rm -rf ${HOME}/Work/openocd-xpack.git; \
mkdir -p ~/Work; \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/openocd-xpack.git  \
  ${HOME}/Work/openocd-xpack.git
```

## Start a local test

TBD

## Start the GitHub Actions tests

The multi-platform tests run on GitHub Actions; they do not fire on
git commits, but only via a manual POST to the GitHub API.

```sh
bash ${HOME}/Work/openocd-xpack.git/scripts/helper/tests/trigger-workflow-test-prime.sh \
  --branch xpack-develop \
  --base-url "https://github.com/xpack-dev-tools/pre-releases/releases/download/test/"

bash ${HOME}/Work/openocd-xpack.git/scripts/helper/tests/trigger-workflow-test-docker-linux-intel.sh \
  --branch xpack-develop \
  --base-url "https://github.com/xpack-dev-tools/pre-releases/releases/download/test/"

bash ${HOME}/Work/openocd-xpack.git/scripts/helper/tests/trigger-workflow-test-docker-linux-arm.sh \
  --branch xpack-develop \
  --base-url "https://github.com/xpack-dev-tools/pre-releases/releases/download/test/"

```

The results are available at the project
[Actions](https://github.com/xpack-dev-tools/openocd-xpack/actions/) page.
