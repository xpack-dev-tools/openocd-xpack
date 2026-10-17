#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# DO NOT EDIT!
# Automatically generated from npm-packages-helper/templates/*.
#
# This file is part of the xPack project (http://xpack.github.io).
# Copyright (c) 2022-2026 Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can be
# obtained from https://opensource.org/licenses/mit.
#
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

function run_verbose()
{
  # Does not include the .exe extension.
  local _app_path="$1"
  shift

  echo
  echo "[${_app_path} $@]"
  "${_app_path}" "$@" 2>&1
}

run_verbose clang-format --style=file:config/.clang-format -i --verbose \
  $(find src \( -name '*.cpp' -o -name '*.c' \)) \
  $(find include -name '*.h')
