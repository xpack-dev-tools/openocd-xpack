# -----------------------------------------------------------------------------
# This file is part of the xPacks distribution.
#   (https://xpack.github.io)
# Copyright (c) 2019 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in the xPack build scripts. As the name implies,
# it should contain only functions and should be included with 'source'
# by the build scripts (both native and container).

# -----------------------------------------------------------------------------

function build_versioned_components()
{
  # Don't use a comma since the regular expression
  # that processes this string in the Makefile, silently fails and the
  # bfdver.h file remains empty.
  XBB_BRANDING="${XBB_APPLICATION_DISTRO_NAME} ${XBB_APPLICATION_NAME} ${XBB_TARGET_MACHINE}"

  XBB_OPENOCD_VERSION="$(echo "${XBB_RELEASE_VERSION}" | sed -e 's|-.*||')"

  XBB_OPENOCD_GIT_COMMIT=${XBB_OPENOCD_GIT_COMMIT:-""}

  XBB_OPENOCD_GIT_URL=${XBB_OPENOCD_GIT_URL:-"https://github.com/xpack-dev-tools/openocd.git"}

  XBB_OPENOCD_GIT_BRANCH=${XBB_OPENOCD_GIT_BRANCH:-"xpack"}
  # XBB_OPENOCD_GIT_BRANCH=${XBB_OPENOCD_GIT_BRANCH:-"xpack-develop"}
  XBB_OPENOCD_GIT_COMMIT=${XBB_OPENOCD_GIT_COMMIT:-"v${XBB_RELEASE_VERSION}-xpack"}

  # Keep them in sync with combo archive content.
  if [[ "${XBB_RELEASE_VERSION}" =~ 0\.11\.0-[5] ]]
  then
    # -------------------------------------------------------------------------

    xbb_set_binaries_install "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    # -------------------------------------------------------------------------

    # https://ftp.gnu.org/pub/gnu/libiconv/
    build_libiconv "1.17" # "1.16"

    if [ "${XBB_TARGET_PLATFORM}" == "darwin" ]
    then

      # https://ftp.gnu.org/gnu/autoconf/
      build_autoconf "2.71"

      # https://ftp.gnu.org/gnu/automake/
      # depends on autoconf.
      build_automake "1.16.5"

      # http://ftpmirror.gnu.org/libtool/
      build_libtool "2.4.7"

      # https://pkgconfig.freedesktop.org/releases/
      # depends on libiconv
      build_pkg_config "0.29.2"

      # https://ftp.gnu.org/gnu/texinfo/
      build_texinfo "6.8"

    fi

    # -------------------------------------------------------------------------

    # https://sourceforge.net/projects/libusb/files/libusb-1.0/
    build_libusb1 "1.0.26" # "1.0.24"

    if [ "${XBB_TARGET_PLATFORM}" == "win32" ]
    then
      # https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/
      build_libusb_w32 "1.2.6.0" # ! PATCH & pkgconfig
    else
      # https://sourceforge.net/projects/libusb/files/libusb-compat-0.1/
      # required by libjaylink
      build_libusb0 "0.1.5"
    fi

    # http://www.intra2net.com/en/developer/libftdi/download.php
    build_libftdi "1.5" # ! PATCH

    # https://github.com/libusb/hidapi/releases
    build_hidapi "0.12.0" # "0.10.1" # ! pkgconfig/hidapi-*-windows.pc

    # -------------------------------------------------------------------------

    xbb_set_binaries_install "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"

    build_openocd "${XBB_OPENOCD_VERSION}"
    # -------------------------------------------------------------------------
  else
    echo "Unsupported version ${XBB_RELEASE_VERSION}."
    exit 1
  fi
}

# -----------------------------------------------------------------------------
