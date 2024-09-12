# -----------------------------------------------------------------------------
# This file is part of the xPacks distribution.
#   (https://xpack.github.io)
# Copyright (c) 2019 Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

function application_build_versioned_components()
{
  XBB_OPENOCD_VERSION="$(xbb_strip_version_pre_release "${XBB_RELEASE_VERSION}")"

  # Keep them in sync with the combo archive content.
  if [[ "${XBB_RELEASE_VERSION}" =~ 0[.]12[.]0-.* ]]
  then
    XBB_OPENOCD_GIT_URL=${XBB_APPLICATION_OPENOCD_GIT_URL:-"https://github.com/openocd-org/openocd.git"}
    XBB_OPENOCD_GIT_BRANCH=${XBB_APPLICATION_OPENOCD_GIT_BRANCH:-"master"}

    # https://ftp.gnu.org/pub/gnu/libiconv/
    XBB_LIBICONV_VERSION="1.17"

    # https://ftp.gnu.org/gnu/texinfo/
    XBB_TEXINFO_VERSION="7.0.3"

    # https://sourceforge.net/projects/libusb/files/libusb-1.0/
    XBB_LIBUSB1_VERSION="1.0.26"

    # https://github.com/openocd-org/openocd/commits/master/
    if [ "${XBB_RELEASE_VERSION}" == "0.12.0-1" ]
    then
      XBB_OPENOCD_GIT_COMMIT=${XBB_APPLICATION_OPENOCD_GIT_COMMIT:-"v0.12.0"}
    elif [ "${XBB_RELEASE_VERSION}" == "0.12.0-2" ]
    then
      # Sep 2, 2023
      XBB_OPENOCD_GIT_COMMIT=${XBB_APPLICATION_OPENOCD_GIT_COMMIT:-"18281b0c497694d91c5608be54583172838be75c"}
    elif [ "${XBB_RELEASE_VERSION}" == "0.12.0-3" ]
    then
      # Apr 1, 2024
      XBB_OPENOCD_GIT_COMMIT=${XBB_APPLICATION_OPENOCD_GIT_COMMIT:-"dd1758272276e20d5b60c16146a820ec8b5bfaa1"}

      XBB_TEXINFO_VERSION="7.1"
      XBB_LIBUSB1_VERSION="1.0.27"
    elif [ "${XBB_RELEASE_VERSION}" == "0.12.0-4" ]
    then
      # Aug 2, 2024
      XBB_OPENOCD_GIT_COMMIT=${XBB_APPLICATION_OPENOCD_GIT_COMMIT:-"b9224c0c0f2a3d1ec52aab6ca985d1affa9a18b9"}

      XBB_TEXINFO_VERSION="7.1"
      XBB_LIBUSB1_VERSION="1.0.27"
    else
      echo "Unsupported ${XBB_APPLICATION_LOWER_CASE_NAME} version ${XBB_RELEASE_VERSION}"
      exit 1
    fi


    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # Required by autotools.
    libiconv_build "${XBB_LIBICONV_VERSION}"

    autotools_build

    texinfo_build "${XBB_TEXINFO_VERSION}"

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    # Before set target (to possibly update CC & co variables).
    xbb_activate_installed_bin

    xbb_set_target "requested"

    # -------------------------------------------------------------------------

    libiconv_build "${XBB_LIBICONV_VERSION}"

    # -------------------------------------------------------------------------

    libusb1_build "${XBB_LIBUSB1_VERSION}"

    # Starting with v0.12.0, libusb0 is no longer needed.
    # if [ "${XBB_REQUESTED_HOST_PLATFORM}" == "win32" ]
    # then
    #   # https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/
    #   libusb_w32_build "1.2.7.3" # "1.2.6.0" # ! PATCH & pkgconfig
    # else
    #   # https://sourceforge.net/projects/libusb/files/libusb-compat-0.1/
    #   # required by libjaylink
    #   libusb0_build "0.1.8"
    # fi

    # https://www.intra2net.com/en/developer/libftdi/download.php
    libftdi_build "1.5" # ! PATCH

    # https://github.com/libusb/hidapi/releases
    hidapi_build "0.14.0" # "0.12.0"

    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    openocd_build "${XBB_OPENOCD_VERSION}"

    # -------------------------------------------------------------------------
  elif [[ "${XBB_RELEASE_VERSION}" =~ 0[.]11[.]0-[5] ]]
  then

    XBB_OPENOCD_GIT_URL=${XBB_OPENOCD_GIT_URL:-"https://github.com/xpack-dev-tools/openocd.git"}

    XBB_OPENOCD_GIT_BRANCH=${XBB_OPENOCD_GIT_BRANCH:-"xpack"}
    # XBB_OPENOCD_GIT_BRANCH=${XBB_OPENOCD_GIT_BRANCH:-"xpack-develop"}
    XBB_OPENOCD_GIT_COMMIT=${XBB_OPENOCD_GIT_COMMIT:-"v${XBB_RELEASE_VERSION}-xpack"}

    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # Required by autotools.
    # https://ftp.gnu.org/pub/gnu/libiconv/
    libiconv_build "1.17" # "1.16"

    autotools_build

    # https://ftp.gnu.org/gnu/texinfo/
    texinfo_build "6.8"

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    # Before set target (to possibly update CC & co variables).
    xbb_activate_installed_bin

    xbb_set_target "requested"

    # -------------------------------------------------------------------------

    if [ "${XBB_REQUESTED_HOST_PLATFORM}" != "darwin" ]
    then

      # https://ftp.gnu.org/pub/gnu/libiconv/
      libiconv_build "1.17" # "1.16"

    fi

    # -------------------------------------------------------------------------

    # https://sourceforge.net/projects/libusb/files/libusb-1.0/
    libusb1_build "1.0.26"

    if [ "${XBB_REQUESTED_HOST_PLATFORM}" == "win32" ]
    then
      # https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/
      libusb_w32_build "1.2.6.0" # ! PATCH & pkgconfig
    else
      # https://sourceforge.net/projects/libusb/files/libusb-compat-0.1/
      # required by libjaylink
      libusb0_build "0.1.5"
    fi

    # https://www.intra2net.com/en/developer/libftdi/download.php
    libftdi_build "1.5" # ! PATCH

    # https://github.com/libusb/hidapi/releases
    hidapi_build "0.12.0" # "0.10.1" # ! pkgconfig/hidapi-*-windows.pc

    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    openocd_build "${XBB_OPENOCD_VERSION}"

    # -------------------------------------------------------------------------
  else
    echo "Unsupported ${XBB_APPLICATION_LOWER_CASE_NAME} version ${XBB_RELEASE_VERSION}"
    exit 1
  fi
}

# -----------------------------------------------------------------------------
