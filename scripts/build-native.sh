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
common_helper_functions_script_path="${script_folder_path}/helper/common-functions-source.sh"
echo "Common helper functions source script: \"${common_helper_functions_script_path}\"."
source "${common_helper_functions_script_path}"

common_helper_libs_functions_script_path="${script_folder_path}/helper/common-libs-functions-source.sh"
echo "Common helper libs functions source script: \"${common_helper_libs_functions_script_path}\"."
source "${common_helper_libs_functions_script_path}"

common_functions_script_path="${script_folder_path}/common-functions-source.sh"
echo "Common functions source script: \"${common_functions_script_path}\"."
source "${common_functions_script_path}"

common_versions_script_path="${script_folder_path}/common-versions-source.sh"
echo "Common versions source script: \"${common_versions_script_path}\"."
source "${common_versions_script_path}"

defines_script_path="${script_folder_path}/defs-source.sh"
echo "Definitions source script: \"${defines_script_path}\"."
source "${defines_script_path}"

host_detect

# For clarity, explicitly define the docker images here.
docker_linux64_image=${docker_linux64_image:-"ilegeul/ubuntu:amd64-12.04-xbb-v3.2"}
docker_linux32_image=${docker_linux32_image:-"ilegeul/ubuntu:i386-12.04-xbb-v3.2"}
docker_linux_arm64_image=${docker_linux_arm64_image:-"ilegeul/ubuntu:arm64v8-16.04-xbb-v3.2"}
docker_linux_arm32_image=${docker_linux_arm32_image:-"ilegeul/ubuntu:arm32v7-16.04-xbb-v3.2"}

# -----------------------------------------------------------------------------

help_message="    bash $0 [--win] [--debug] [--develop] [--jobs N] [--help] [clean|cleanlibs|cleanall]"
host_native_options "${help_message}" $@

# -----------------------------------------------------------------------------

host_common
export TARGET_BITS="${HOST_BITS}"

prepare_xbb_env
prepare_xbb_extras

tests_initialize

# -----------------------------------------------------------------------------

common_libs_functions_script_path="${script_folder_path}/${COMMON_LIBS_FUNCTIONS_SCRIPT_NAME}"
echo "Common libs functions source script: \"${common_libs_functions_script_path}\"."
source "${common_libs_functions_script_path}"

common_apps_functions_script_path="${script_folder_path}/${COMMON_APPS_FUNCTIONS_SCRIPT_NAME}"
echo "Common app functions source script: \"${common_apps_functions_script_path}\"."
source "${common_apps_functions_script_path}"

# -----------------------------------------------------------------------------

build_versions

# -----------------------------------------------------------------------------

copy_distro_files

check_binaries

create_archive

# Change ownership to non-root Linux user.
fix_ownership

# -----------------------------------------------------------------------------

host_stop_timer

# Completed successfully.
exit 0

# -----------------------------------------------------------------------------
