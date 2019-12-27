# -----------------------------------------------------------------------------
# This file is part of the xPacks distribution.
#   (https://xpack.github.io)
# Copyright (c) 2019 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in the second edition of the GNU MCU Eclipse build 
# scripts. As the name implies, it should contain only functions and 
# should be included with 'source' by the container build scripts.

# -----------------------------------------------------------------------------

function prepare_versions()
{
  # The \x2C is a comma in hex; without this trick the regular expression
  # that processes this string in the Makefile, silently fails and the 
  # bfdver.h file remains empty.
  BRANDING="${BRANDING}\x2C ${TARGET_BITS}-bit"

  OPENOCD_PROJECT_NAME="openocd"
  OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-""}
  README_OUT_FILE_NAME="README-${RELEASE_VERSION}.md"

  LIBFTDI_PATCH=""
  LIBUSB_W32_PATCH=""

  USE_SINGLE_FOLDER="y"
  USE_TAR_GZ="y"

  # Keep them in sync with combo archive content.
  if [[ "${RELEASE_VERSION}" =~ 0\.10\.0-14 ]]
  then

    # ---------------------------------------------------------------------------
    
    OPENOCD_VERSION="0.10.0-14"

    OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
    OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"e1e63ef30cea39aceda40daf194377c89c570101"}
    
    # ---------------------------------------------------------------------------

    LIBUSB1_VERSION="1.0.22"
    LIBUSB0_VERSION="0.1.5"
    LIBUSB_W32_VERSION="1.2.6.0"
    LIBFTDI_VERSION="1.4"
    LIBICONV_VERSION="1.15"
    HIDAPI_VERSION="0.8.0-rc1"

    LIBFTDI_PATCH="libftdi1-${LIBFTDI_VERSION}-cmake-FindUSB1.patch"
    LIBUSB_W32_PATCH="libusb-win32-${LIBUSB_W32_VERSION}-mingw-w64.patch"

    # ---------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.10\.0-13 ]]
  then

    # ---------------------------------------------------------------------------
    
    OPENOCD_VERSION="0.10.0-13"

    OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
    OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"191d1b176cf32280fc649d3c5afcff44d6205daf"}
    
    # ---------------------------------------------------------------------------

    LIBUSB1_VERSION="1.0.22"
    LIBUSB0_VERSION="0.1.5"
    LIBUSB_W32_VERSION="1.2.6.0"
    LIBFTDI_VERSION="1.4"
    LIBICONV_VERSION="1.15"
    HIDAPI_VERSION="0.8.0-rc1"

    LIBFTDI_PATCH="libftdi1-${LIBFTDI_VERSION}-cmake-FindUSB1.patch"
    LIBUSB_W32_PATCH="libusb-win32-${LIBUSB_W32_VERSION}-mingw-w64.patch"

    USE_SINGLE_FOLDER=""
    USE_TAR_GZ=""

    # ---------------------------------------------------------------------------
  else
    echo "Unsupported version ${RELEASE_VERSION}."
    exit 1
  fi
}

# -----------------------------------------------------------------------------
