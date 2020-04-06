#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Identify the script location, to reach, for example, the helper scripts.

script_path="$0"
if [[ "${script_path}" != /* ]]
then
  # Make relative path absolute.
  script_path="$(pwd)/$0"
fi

script_name="$(basename "${script_path}")"

script_folder_path="$(dirname "${script_path}")"
script_folder_name="$(basename "${script_folder_path}")"

# =============================================================================

# base_url="https://github.com/xpack-dev-tools/pre-releases/releases/download/experimental/"
base_url="https://github.com/xpack-dev-tools/pre-releases/releases/download/test/"

data_file_path="$(mktemp)"

# "i386/ubuntu:20.04" # Fails to install prerequisites
# "i386/ubuntu:12.04" --skip-gdb-py # Not available
# "i386/centos:8" # not available

# 8 jessie, 9 stretch, 10 buster.

# Note: __EOF__ is NOT quoted to allow substitutions.
cat <<__EOF__ > "${data_file_path}"
{
  "request": {
    "message": "Test the OpenOCD binary xPack",
    "branch": "xpack-develop",
    "config": {
      "merge_mode": "replace",
      "jobs": [
        {
          "name": "Ubuntu Intel 64-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/ubuntu:20.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/ubuntu:18.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/ubuntu:16.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/ubuntu:14.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh ubuntu:12.04 ${base_url} "
          ]
        },
        {
          "name": "Debian Intel 64-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/debian:buster ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/debian:stretch ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/debian:jessie ${base_url} "
          ]
        },
        {
          "name": "CentOS Intel 64-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/centos:8 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh amd64/centos:7 ${base_url} "
          ]
        },
        {
          "name": "OpenSUSE Intel 64-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh opensuse/tumbleweed ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh opensuse/leap:15 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh opensuse/amd64:13.2 ${base_url} "
          ]
        },
        {
          "name": "Manjaro Intel 64-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh manjarolinux/base ${base_url} "
          ]
        },
        {
          "name": "Ubuntu Intel 32-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 i386/ubuntu:18.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 i386/ubuntu:16.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 i386/ubuntu:14.04 ${base_url} "
          ]
        },
        {
          "name": "Debian Intel 32-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 i386/debian:buster ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 i386/debian:stretch ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 i386/debian:jessie ${base_url} "
          ]
        },
        {
          "name": "CentOS Intel 32-bit",
          "os": "linux",
          "arch": "amd64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 i386/centos:7 ${base_url} "
          ]
        },
        {
          "name": "Ubuntu Arm 64-bit",
          "os": "linux",
          "arch": "arm64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh arm64v8/ubuntu:20.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh arm64v8/ubuntu:18.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh arm64v8/ubuntu:16.04 ${base_url} "
          ]
        },
        {
          "name": "Debian Arm 64-bit",
          "os": "linux",
          "arch": "arm64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh arm64v8/debian:buster ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh arm64v8/debian:stretch ${base_url} "
          ]
        },
        {
          "name": "Manjaro Arm 64-bit",
          "os": "linux",
          "arch": "arm64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh manjaroarm/manjaro-aarch64-base ${base_url} "
          ]
        },
        {
          "name": "Ubuntu Arm 32-bit",
          "os": "linux",
          "arch": "arm64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 arm32v7/ubuntu:18.04 ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 arm32v7/ubuntu:16.04 ${base_url} "
          ]
        },
        {
          "name": "Debian Arm 32-bit",
          "os": "linux",
          "arch": "arm64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 arm32v7/debian:buster ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 arm32v7/debian:stretch ${base_url} "
          ]
        },
        {
          "name": "Raspbian Arm 32-bit",
          "os": "linux",
          "arch": "arm64",
          "dist": "bionic",
          "services": [ "docker" ],
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 raspbian/stretch ${base_url} ",
            "DEBUG=${DEBUG} bash tests/scripts/docker-test.sh --32 raspbian/jessie ${base_url} "
          ]
        },
        {
          "name": "macOS 10.14 Intel",
          "os": "osx",
          "arch": "amd64",
          "osx_image": "xcode11.3",
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/native-test.sh ${base_url}" 
          ]
        },
        {
          "name": "macOS 10.13 Intel",
          "os": "osx",
          "arch": "amd64",
          "osx_image": "xcode10.1",
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/native-test.sh ${base_url}" 
          ]
        },
        {
          "name": "macOS 10.12 Intel",
          "os": "osx",
          "arch": "amd64",
          "osx_image": "xcode9.2",
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/native-test.sh ${base_url}" 
          ]
        },
        {
          "name": "macOS 10.11 Intel",
          "os": "osx",
          "arch": "amd64",
          "osx_image": "xcode8",
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/native-test.sh ${base_url}" 
          ]
        },
        {
          "name": "macOS 10.10 Intel",
          "os": "osx",
          "arch": "amd64",
          "osx_image": "xcode6.4",
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/native-test.sh ${base_url}" 
          ]
        },
        {
          "name": "Windows 10 Intel 64-bit",
          "os": "windows",
          "arch": "amd64",
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/native-test.sh ${base_url} " 
          ]
        },
        {
          "name": "Windows 10 Intel 32-bit",
          "os": "windows",
          "arch": "amd64",
          "language": "minimal",
          "script": [
            "env | sort",
            "pwd",
            "DEBUG=${DEBUG} bash tests/scripts/native-test.sh --32 ${base_url} " 
          ]
        }
      ],
      "notifications": {
        "email": {
          "on_success": "always",
          "on_failure": "always"
        }
      }
    }
  }
}
__EOF__

# https://docs.travis-ci.com/user/triggering-builds/

github_org="xpack-dev-tools"
github_repo="openocd-xpack"

# TRAVIS_ORG_TOKEN must be present in the environment.

curl -v -X POST \
   -H "Content-Type: application/json" \
   -H "Accept: application/json" \
   -H "Travis-API-Version: 3" \
   -H "Authorization: token ${TRAVIS_ORG_TOKEN}" \
   --data-binary @"${data_file_path}" \
   https://api.travis-ci.org/repo/${github_org}%2F${github_repo}/requests

cat "${data_file_path}"
rm -v "${data_file_path}"

echo "Done."
