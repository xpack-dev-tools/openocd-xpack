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

function build_versions()
{
  # Don't use a comma since the regular expression
  # that processes this string in the Makefile, silently fails and the
  # bfdver.h file remains empty.
  BRANDING="${DISTRO_NAME} ${APP_NAME} ${TARGET_MACHINE}"

  OPENOCD_VERSION="${RELEASE_VERSION}"

  OPENOCD_PROJECT_NAME="openocd"
  OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-""}

  OPENOCD_SRC_FOLDER_NAME=${OPENOCD_SRC_FOLDER_NAME:-"${OPENOCD_PROJECT_NAME}.git"}
  OPENOCD_GIT_URL=${OPENOCD_GIT_URL:-"https://github.com/xpack-dev-tools/openocd.git"}

  # Used in the licenses folder.
  OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

  OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
  # OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
  OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"v${OPENOCD_VERSION}-xpack"}

  LIBFTDI_PATCH=""
  LIBUSB_W32_PATCH=""

  if [ "${TARGET_PLATFORM}" == "win32" ]
  then
    prepare_gcc_env "${CROSS_COMPILE_PREFIX}-"
  fi

  # Keep them in sync with combo archive content.
  if [[ "${RELEASE_VERSION}" =~ 0\.11\.0-[5] ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      # https://sourceforge.net/projects/libusb/files/libusb-1.0/
      build_libusb1 "1.0.26" # "1.0.24"

      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        # https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/
        build_libusb_w32 "1.2.6.0" # ! PATCH & pkgconfig
      else
        # https://sourceforge.net/projects/libusb/files/libusb-compat-0.1/
        build_libusb0 "0.1.5"
      fi

      # http://www.intra2net.com/en/developer/libftdi/download.php
      build_libftdi "1.5" # ! PATCH

      # https://ftp.gnu.org/pub/gnu/libiconv/
      build_libiconv "1.17" # "1.16"

      # https://github.com/libusb/hidapi/releases
      build_hidapi "0.12.0" # "0.10.1" # ! pkgconfig/hidapi-*-windows.pc

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.11\.0-[4] ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      # https://github.com/libusb/libusb/releases
      build_libusb1 "1.0.24"

      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        # https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/
        build_libusb_w32 "1.2.6.0"
      else
        # https://sourceforge.net/projects/libusb/files/libusb-compat-0.1/
        build_libusb0 "0.1.5"
      fi

      # http://www.intra2net.com/en/developer/libftdi/download.php
      build_libftdi "1.5"

      # https://ftp.gnu.org/pub/gnu/libiconv/
      build_libiconv "1.16"

      # https://github.com/libusb/hidapi/releases
      build_hidapi "0.10.1" # PATCH!

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.11\.0-[3] ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      # Used in the licenses folder.
      OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

      OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
      # OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
      OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"7ed7eba33140d8745f3343be7752bf2b0aafb6d8"}

      # -------------------------------------------------------------------------

      build_libusb1 "1.0.24"
      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        build_libusb_w32 "1.2.6.0"
      else
        build_libusb0 "0.1.5"
      fi

      build_libftdi "1.5"

      build_libiconv "1.16"

      build_hidapi "0.10.1" # PATCH!

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.11\.0-[2] ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      # Used in the licenses folder.
      OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

      OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
      # OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
      OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"f0fdb88cf61e4b3b8bc036677b3469df40a3e86f"}

      # -------------------------------------------------------------------------

      build_libusb1 "1.0.24"
      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        build_libusb_w32 "1.2.6.0"
      else
        build_libusb0 "0.1.5"
      fi

      build_libftdi "1.5"

      build_libiconv "1.16"

      build_hidapi "0.10.1" # PATCH!

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.11\.0-1 ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      # Used in the licenses folder.
      OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

      # OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
      OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
      OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"e392e485e40036543e6a3cce04570e7525c48ca2"}

      # -------------------------------------------------------------------------

      build_libusb1 "1.0.22"
      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        build_libusb_w32 "1.2.6.0"
      else
        build_libusb0 "0.1.5"
      fi

      build_libftdi "1.4"

      build_libiconv "1.15"

      build_hidapi "0.9.0"

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.10\.0-1[56] ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      # Used in the licenses folder.
      OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

      OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
      # OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
      OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"819d1a93b400582e008a7d02ccad93ffedf1161f"}

      # -------------------------------------------------------------------------

      build_libusb1 "1.0.22"
      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        build_libusb_w32 "1.2.6.0"
      else
        build_libusb0 "0.1.5"
      fi

      build_libftdi "1.4"

      build_libiconv "1.15"

      build_hidapi "0.9.0"

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.10\.0-14 ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      OPENOCD_VERSION="0.10.0-14"

      # Used in the licenses folder.
      OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

      OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
      # OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
      OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"e5be992df1a893e2e865419a02a564d5f9ccd9dd"}

      README_OUT_FILE_NAME="README-${RELEASE_VERSION}.md"

      # -------------------------------------------------------------------------

      build_libusb1 "1.0.22"
      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        build_libusb_w32 "1.2.6.0"
      else
        build_libusb0 "0.1.5"
      fi

      build_libftdi "1.4"

      build_libiconv "1.15"

      build_hidapi "0.9.0"

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.10\.0-13 ]]
  then
    (
      xbb_activate

      # -------------------------------------------------------------------------

      OPENOCD_VERSION="0.10.0-13"

      # Used in the licenses folder.
      OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

      OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
      OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"191d1b176cf32280fc649d3c5afcff44d6205daf"}

      README_OUT_FILE_NAME="README-${RELEASE_VERSION}.md"

      # -------------------------------------------------------------------------

      USE_TAR_GZ=""

      build_libusb1 "1.0.22"
      if [ "${TARGET_PLATFORM}" == "win32" ]
      then
        build_libusb_w32 "1.2.6.0"
      else
        build_libusb0 "0.1.5"
      fi

      build_libftdi "1.4"

      build_libiconv "1.15"

      build_hidapi "0.9.0"

      # -------------------------------------------------------------------------

      build_openocd
    )
    # -------------------------------------------------------------------------
  else
    echo "Unsupported version ${RELEASE_VERSION}."
    exit 1
  fi
}

# -----------------------------------------------------------------------------
