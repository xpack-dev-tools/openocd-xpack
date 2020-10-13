#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu.
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

source "${script_folder_path}/app-defs.sh"

helper_folder_path="$(dirname $(dirname "${script_folder_path}"))/scripts/helper"

source "${helper_folder_path}/test-functions-source.sh"
source "${script_folder_path}/common-functions-source.sh"

# -----------------------------------------------------------------------------

# This runs inside a Docker container.

image_name="$1"
echo "${image_name}"
shift

while [ $# -gt 0 ]
do
  case "$1" in

    -*)
      echo "Unsupported option $1."
      exit 1
      ;;

  esac
done

# -----------------------------------------------------------------------------

# Make sure that the minimum prerequisites are met.
if [[ ${image_name} == *ubuntu* ]] || [[ ${image_name} == *debian* ]] || [[ ${image_name} == *raspbian* ]]
then
  run_verbose apt-get -qq update 
  run_verbose apt-get -qq install -y git-core curl tar gzip lsb-release binutils
elif [[ ${image_name} == *centos* ]] || [[ ${image_name} == *fedora* ]]
then
  run_verbose yum install -y -q git curl tar gzip redhat-lsb-core binutils
  run_verbose yum install -y -q python || true
elif [[ ${image_name} == *opensuse* ]]
then
  run_verbose zypper -q in -y git-core curl tar gzip lsb-release binutils
  run_verbose zypper -q in -y python || true
elif [[ ${image_name} == *manjaro* ]]
then
  run_verbose pacman-mirrors -g
  run_verbose pacman -S -y -q --noconfirm 

  # Update even if up to date (-yy) & upgrade (-u).
  # pacman -S -yy -u -q --noconfirm 
  run_verbose pacman -S -q --noconfirm --noprogressbar git curl tar gzip lsb-release binutils file
elif [[ ${image_name} == *archlinux* ]]
then
  pacman -S -y -q --noconfirm 

  # Update even if up to date (-yy) & upgrade (-u).
  # pacman -S -yy -u -q --noconfirm 
  run_verbose pacman -S -q --noconfirm --noprogressbar git curl tar gzip lsb-release binutils file
fi

# -----------------------------------------------------------------------------

detect_architecture

prepare_env

install_xpm

env | sort
pwd

xpm install --global ${npm_package}

good_bye

# Completed successfully.
exit 0

# -----------------------------------------------------------------------------
