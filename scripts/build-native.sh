#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2019 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

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

build_script_path="$0"
if [[ "${build_script_path}" != /* ]]
then
  # Make relative path absolute.
  build_script_path="$(pwd)/$0"
fi

script_folder_path="$(dirname "${build_script_path}")"
script_folder_name="$(basename "${script_folder_path}")"

# =============================================================================

# Script to build a native xPack OpenOCD, which uses the
# tools and libraries available on the host machine. It is generally
# intended for development and creating customised versions (as opposed
# to the build intended for creating distribution packages).
#
# Developed on Ubuntu 18 LTS x64 and macOS 10.13. 

# -----------------------------------------------------------------------------

echo
echo "xPack OpenOCD native build script."

echo
host_functions_script_path="${script_folder_path}/helper/host-functions-source.sh"
echo "Host helper functions source script: \"${host_functions_script_path}\"."
source "${host_functions_script_path}"

host_detect

# -----------------------------------------------------------------------------

help_message="    bash $0 [--win] [--debug] [--develop] [--jobs N] [--help] [clean|cleanlibs|cleanall]"
host_native_options "${help_message}" $@

# -----------------------------------------------------------------------------

host_common

prepare_xbb_env
prepare_xbb_extras

# -----------------------------------------------------------------------------

common_libs_functions_script_path="${script_folder_path}/${COMMON_LIBS_FUNCTIONS_SCRIPT_NAME}"
echo "Common libs functions source script: \"${common_libs_functions_script_path}\"."
source "${common_libs_functions_script_path}"

common_apps_functions_script_path="${script_folder_path}/${COMMON_APPS_FUNCTIONS_SCRIPT_NAME}"
echo "Common app functions source script: \"${common_apps_functions_script_path}\"."
source "${common_apps_functions_script_path}"

# -----------------------------------------------------------------------------

OPENOCD_PROJECT_NAME="openocd"
OPENOCD_VERSION="0.10.0-13"

OPENOCD_SRC_FOLDER_NAME=${OPENOCD_SRC_FOLDER_NAME:-"${OPENOCD_PROJECT_NAME}.git"}
OPENOCD_GIT_URL=${OPENOCD_GIT_URL:-"https://github.com/xpack-dev-tools/openocd.git"}

if [ "${IS_DEVELOP}" == "y" ]
then
  OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
else
  OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
fi

OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-""}

# Used in the licenses folder.
OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

# -----------------------------------------------------------------------------

LIBUSB1_VERSION="1.0.22"
LIBUSB0_VERSION="0.1.5"
LIBUSB_W32_VERSION="1.2.6.0"
LIBFTDI_VERSION="1.4"
LIBICONV_VERSION="1.15"
HIDAPI_VERSION="0.8.0-rc1"

LIBFTDI_PATCH="libftdi1-${LIBFTDI_VERSION}-cmake-FindUSB1.patch"
LIBUSB_W32_PATCH="libusb-win32-${LIBUSB_W32_VERSION}-mingw-w64.patch"

# -----------------------------------------------------------------------------
# Build dependent libraries.

if true
then

  do_libusb1
  if [ "${TARGET_PLATFORM}" == "win32" ]
  then
    do_libusb_w32
  else
    do_libusb0
  fi

  do_libftdi

  do_libiconv

  do_hidapi

fi

# -----------------------------------------------------------------------------

do_openocd

run_openocd

# -----------------------------------------------------------------------------

host_stop_timer

# Completed successfully.
exit 0

# -----------------------------------------------------------------------------
