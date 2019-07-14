# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2019 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in the second edition of the xPack build 
# scripts. As the name implies, it should contain only functions and 
# should be included with 'source' by the container build scripts.

# -----------------------------------------------------------------------------

function do_libusb1()
{
  # https://sourceforge.net/projects/libusb/files/libusb-1.0/
  # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mingw-w64-libusb

  # 2015-09-14, 1.0.20
  # 2018-03-25, 1.0.22

  LIBUSB1_SRC_FOLDER_NAME="libusb-${LIBUSB1_VERSION}"
  LIBUSB1_FOLDER_NAME="${LIBUSB1_SRC_FOLDER_NAME}"
  local libusb1_archive="${LIBUSB1_SRC_FOLDER_NAME}.tar.bz2"
  local libusb1_url="http://sourceforge.net/projects/libusb/files/libusb-1.0/${LIBUSB1_FOLDER_NAME}/${libusb1_archive}"

  local libusb1_stamp_file_path="${INSTALL_FOLDER_PATH}/stamp-libusb1-${LIBUSB1_VERSION}-installed"
  if [ ! -f "${libusb1_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${libusb1_url}" "${libusb1_archive}" \
      "${LIBUSB1_SRC_FOLDER_NAME}"

    (
      mkdir -p "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB1_FOLDER_NAME}"
      cd "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB1_FOLDER_NAME}"

      xbb_activate
      xbb_activate_installed_dev

      if [ "${TARGET_PLATFORM}" == "darwin" ]
      then
        # GCC-7 fails to compile Darwin USB.h:
        # error: too many #pragma options align=reset
        export CC=clang
      fi

      export CFLAGS="${XBB_CFLAGS} -Wno-non-literal-null-conversion -Wno-deprecated-declarations  -Wno-format"
      export CPPFLAGS="${XBB_CPPFLAGS}"
      export LDFLAGS="${XBB_LDFLAGS_LIB}"

      if [ ! -f "config.status" ]
      then 

        (
          echo
          echo "Running libusb1 configure..."

          bash "${SOURCES_FOLDER_PATH}/${LIBUSB1_SRC_FOLDER_NAME}/configure" --help

          # --enable-shared required by libftdi.
          # --enable-static required by libftdi. (odd...)
          bash ${DEBUG} "${SOURCES_FOLDER_PATH}/${LIBUSB1_SRC_FOLDER_NAME}/configure" \
            --prefix="${LIBS_INSTALL_FOLDER_PATH}" \
            \
            --build=${BUILD} \
            --host=${HOST} \
            --target=${TARGET} \
            \
            --enable-shared \
            --enable-static
          
          cp "config.log" "${LOGS_FOLDER_PATH}/config-libusb1-log.txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/configure-libusb1-output.txt"

      fi

      (
        echo
        echo "Running libusb1 make..."

        # Build. 
        # WARNING: Parallel build fails!
        make 
        if [ "${WITH_STRIP}" == "y" ]
        then
          make install-strip
        else
          make install
        fi
      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/make-libusb1-output.txt"
    )

    touch "${libusb1_stamp_file_path}"

  else
    echo "Library libusb1 already installed."
  fi
}

# Required by GNU/Linux and macOS.
function do_libusb0()
{
  # https://sourceforge.net/projects/libusb/files/libusb-compat-0.1/

  # 2013-05-21, 0.1.5, latest
  
  LIBUSB0_SRC_FOLDER_NAME="libusb-compat-${LIBUSB0_VERSION}"
  LIBUSB0_FOLDER_NAME="${LIBUSB0_SRC_FOLDER_NAME}"
  local libusb0_archive="${LIBUSB0_SRC_FOLDER_NAME}.tar.bz2"
  local libusb0_url="http://sourceforge.net/projects/libusb/files/libusb-compat-0.1/${LIBUSB0_FOLDER_NAME}/${libusb0_archive}"

  local libusb0_stamp_file_path="${INSTALL_FOLDER_PATH}/stamp-libusb0-${LIBUSB0_VERSION}-installed"
  if [ ! -f "${libusb0_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${libusb0_url}" "${libusb0_archive}" \
      "${LIBUSB0_SRC_FOLDER_NAME}"

    (
      mkdir -p "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB0_FOLDER_NAME}"
      cd "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB0_FOLDER_NAME}"

      xbb_activate
      xbb_activate_installed_dev

      export CFLAGS="${XBB_CFLAGS}"
      export CPPFLAGS="${XBB_CPPFLAGS}"
      export LDFLAGS="${XBB_LDFLAGS_LIB}"

      if [ ! -f "config.status" ]
      then 

        (
          echo
          echo "Running libusb0 configure..."

          bash "${SOURCES_FOLDER_PATH}/${LIBUSB0_SRC_FOLDER_NAME}/configure" --help

          bash ${DEBUG} "${SOURCES_FOLDER_PATH}/${LIBUSB0_SRC_FOLDER_NAME}/configure" \
            --prefix="${LIBS_INSTALL_FOLDER_PATH}" \
            \
            --build=${BUILD} \
            --host=${HOST} \
            --target=${TARGET} \
            \
            --enable-shared \
            --disable-static 
          
          cp "config.log" "${LOGS_FOLDER_PATH}/config-libusb0-log.txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/configure-libusb0-output.txt"

      fi

      (
        echo
        echo "Running libusb0 make..."

        # Build.
        make -j ${JOBS}
        if [ "${WITH_STRIP}" == "y" ]
        then
          make install-strip
        else
          make install
        fi
      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/make-libusb0-output.txt"
    )

    touch "${libusb0_stamp_file_path}"

  else
    echo "Library libusb0 already installed."
  fi
}

# Required by Windows.
function do_libusb_w32()
{
  # https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/
  # 2012-01-17, 1.2.6.0 
  # LIBUSB_W32_VERSION="1.2.6.0" # +PATCH!

  LIBUSB_W32_PREFIX="libusb-win32"
  LIBUSB_W32="${LIBUSB_W32_PREFIX}-${LIBUSB_W32_VERSION}"

  LIBUSB_W32_SRC_FOLDER_NAME="${LIBUSB_W32_PREFIX}-src-${LIBUSB_W32_VERSION}"
  LIBUSB_W32_FOLDER_NAME="${LIBUSB_W32_SRC_FOLDER_NAME}"
  local libusb_w32_archive="${LIBUSB_W32_SRC_FOLDER_NAME}.zip"
  local linusb_w32_url="http://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/${LIBUSB_W32_VERSION}/${libusb_w32_archive}"

  local libusb_w32_stamp_file_path="${INSTALL_FOLDER_PATH}/stamp-libusb-w32-${LIBUSB_W32_VERSION}-installed"
  if [ ! -f "${libusb_w32_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${linusb_w32_url}" "${libusb_w32_archive}" \
      "${LIBUSB_W32_SRC_FOLDER_NAME}"

    # Mandatory build in the source folder, so make a local copy.
    rm -rf "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB_W32_FOLDER_NAME}"
    mkdir -p "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB_W32_FOLDER_NAME}"
    cp -r "${SOURCES_FOLDER_PATH}/${LIBUSB_W32_SRC_FOLDER_NAME}"/* \
      "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB_W32_FOLDER_NAME}"

    (
      echo
      echo "Running libusb-win32 make..."

      cd "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB_W32_FOLDER_NAME}"

      xbb_activate
      xbb_activate_installed_dev

      # Patch from:
      # https://gitorious.org/jtag-tools/openocd-mingw-build-scripts

      # The conversions are needed to avoid errors like:
      # 'Hunk #1 FAILED at 31 (different line endings).'
      dos2unix src/install.c
      dos2unix src/install_filter_win.c
      dos2unix src/registry.c

      if [ -f "${BUILD_GIT_PATH}/patches/${LIBUSB_W32_PATCH}" ]
      then
        patch -p0 < "${BUILD_GIT_PATH}/patches/${LIBUSB_W32_PATCH}"
      fi

      # Build.
      (
          export CFLAGS="${XBB_CFLAGS} -Wno-unknown-pragmas -Wno-unused-variable -Wno-pointer-sign -Wno-unused-but-set-variable"
          make \
            host_prefix=${CROSS_COMPILE_PREFIX} \
            host_prefix_x86=i686-w64-mingw32 \
            dll
          
      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/make-libusb-w32-output.txt"

      # Manually install, could not find a make target.
      mkdir -p "${LIBS_INSTALL_FOLDER_PATH}/bin"

      # Skipping it does not remove the reference from openocd, so for the
      # moment it is preserved.
      cp -v "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB_W32_FOLDER_NAME}/libusb0.dll" \
        "${LIBS_INSTALL_FOLDER_PATH}/bin"

      mkdir -p "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp -v "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB_W32_FOLDER_NAME}/libusb.a" \
        "${LIBS_INSTALL_FOLDER_PATH}/lib"

      mkdir -p "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
      sed -e "s|XXX|${LIBS_INSTALL_FOLDER_PATH}|" \
        "${BUILD_GIT_PATH}/pkgconfig/${LIBUSB_W32}.pc" \
        > "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig/libusb.pc"

      mkdir -p "${LIBS_INSTALL_FOLDER_PATH}/include/libusb"
      cp -v "${LIBS_BUILD_FOLDER_PATH}/${LIBUSB_W32_FOLDER_NAME}/src/lusb0_usb.h" \
        "${LIBS_INSTALL_FOLDER_PATH}/include/libusb/usb.h"
    )

    touch "${libusb_w32_stamp_file_path}"

  else
    echo "Library libusb-w32 already installed."
  fi
}

function do_libftdi()
{
  # http://www.intra2net.com/en/developer/libftdi/download.php
  # https://www.intra2net.com/en/developer/libftdi/download/libftdi1-1.4.tar.bz2

  # 1.2 (no date)
  # LIBFTDI_VERSION="1.2" # +PATCH!

  LIBFTDI_SRC_FOLDER_NAME="libftdi1-${LIBFTDI_VERSION}"
  LIBFTDI_FOLDER_NAME="${LIBFTDI_SRC_FOLDER_NAME}"
  local libftdi_archive="${LIBFTDI_SRC_FOLDER_NAME}.tar.bz2"

  libftdi_url="http://www.intra2net.com/en/developer/libftdi/download/${libftdi_archive}"

  local libftdi_stamp_file_path="${INSTALL_FOLDER_PATH}/stamp-libftdi-${LIBFTDI_VERSION}-installed"
  if [ ! -f "${libftdi_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${libftdi_url}" "${libftdi_archive}" \
      "${LIBFTDI_SRC_FOLDER_NAME}" \
      "${LIBFTDI_PATCH}"

    (
      mkdir -p "${LIBS_BUILD_FOLDER_PATH}/${LIBFTDI_FOLDER_NAME}"
      cd "${LIBS_BUILD_FOLDER_PATH}/${LIBFTDI_FOLDER_NAME}"

      xbb_activate
      xbb_activate_installed_dev

      export CFLAGS="${XBB_CFLAGS}"
      export CPPFLAGS="${XBB_CPPFLAGS}"
      export LDFLAGS="${XBB_LDFLAGS_LIB}"

      (
        echo
        echo "Running libftdi configure..."
        
        if [ "${TARGET_PLATFORM}" == "win32" ]
        then

          # Configure for Windows.
          cmake \
          -DPKG_CONFIG_EXECUTABLE="${PKG_CONFIG}" \
          -DCMAKE_TOOLCHAIN_FILE="${SOURCES_FOLDER_PATH}/${LIBFTDI_SRC_FOLDER_NAME}/cmake/Toolchain-${CROSS_COMPILE_PREFIX}.cmake" \
          -DCMAKE_INSTALL_PREFIX="${LIBS_INSTALL_FOLDER_PATH}" \
          -DLIBUSB_INCLUDE_DIR="${LIBS_INSTALL_FOLDER_PATH}/include/libusb-1.0" \
          -DLIBUSB_LIBRARIES="${LIBS_INSTALL_FOLDER_PATH}/lib/libusb-1.0.a" \
          -DBUILD_TESTS:BOOL=off \
          -DFTDIPP:BOOL=off \
          -DPYTHON_BINDINGS:BOOL=off \
          -DEXAMPLES:BOOL=off \
          -DDOCUMENTATION:BOOL=off \
          -DFTDI_EEPROM:BOOL=off \
          "${SOURCES_FOLDER_PATH}/${LIBFTDI_SRC_FOLDER_NAME}"

        else

          # Configure for GNU/Linux and macOS.
          cmake \
          -DPKG_CONFIG_EXECUTABLE="${PKG_CONFIG}" \
          -DCMAKE_INSTALL_PREFIX="${LIBS_INSTALL_FOLDER_PATH}" \
          -DBUILD_TESTS:BOOL=off \
          -DFTDIPP:BOOL=off \
          -DPYTHON_BINDINGS:BOOL=off \
          -DEXAMPLES:BOOL=off \
          -DDOCUMENTATION:BOOL=off \
          -DFTDI_EEPROM:BOOL=off \
          "${SOURCES_FOLDER_PATH}/${LIBFTDI_SRC_FOLDER_NAME}"

        fi
      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/configure-libftdi-output.txt"

      (
        echo
        echo "Running libftdi make..."

        # Build.
        make -j ${JOBS}
        make install

      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/make-libftdi-output.txt"
    )

    touch "${libftdi_stamp_file_path}"

  else
    echo "Library libftdi already installed."
  fi
}

function do_libiconv()
{
  # https://www.gnu.org/software/libiconv/
  # https://ftp.gnu.org/pub/gnu/libiconv/
  # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=libiconv

  # 2011-08-07, "1.14"
  # 2017-02-02, "1.15", latest

  LIBICONV_SRC_FOLDER_NAME="libiconv-${LIBICONV_VERSION}"
  LIBICONV_FOLDER_NAME="${LIBICONV_SRC_FOLDER_NAME}"
  local libiconv_archive="${LIBICONV_SRC_FOLDER_NAME}.tar.gz"
  local libiconv_url="https://ftp.gnu.org/pub/gnu/libiconv/${libiconv_archive}"

  local libiconv_stamp_file_path="${INSTALL_FOLDER_PATH}/stamp-libiconv-${LIBICONV_VERSION}-installed"
  if [ ! -f "${libiconv_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${libiconv_url}" "${libiconv_archive}" \
      "${LIBICONV_SRC_FOLDER_NAME}"

    (
      mkdir -p "${LIBS_BUILD_FOLDER_PATH}/${LIBICONV_FOLDER_NAME}"
      cd "${LIBS_BUILD_FOLDER_PATH}/${LIBICONV_FOLDER_NAME}"

      xbb_activate
      xbb_activate_installed_dev

      # -fgnu89-inline fixes "undefined reference to `aliases2_lookup'"
      #  https://savannah.gnu.org/bugs/?47953
      export CFLAGS="${XBB_CFLAGS} -fgnu89-inline -Wno-tautological-compare -Wno-parentheses-equality -Wno-static-in-inline -Wno-pointer-to-int-cast"
      export CPPFLAGS="${XBB_CPPFLAGS}"
      export LDFLAGS="${XBB_LDFLAGS_LIB}"

      if [ ! -f "config.status" ]
      then 

        (
          echo
          echo "Running libiconv configure..."

          bash "${SOURCES_FOLDER_PATH}/${LIBICONV_SRC_FOLDER_NAME}/configure" --help

          bash ${DEBUG} "${SOURCES_FOLDER_PATH}/${LIBICONV_SRC_FOLDER_NAME}/configure" \
            --prefix="${LIBS_INSTALL_FOLDER_PATH}" \
            \
            --build=${BUILD} \
            --host=${HOST} \
            --target=${TARGET} \
            \
            --enable-shared \
            --disable-static \
            --disable-nls

          cp "config.log" "${LOGS_FOLDER_PATH}/config-libiconv-log.txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/configure-libiconv-output.txt"

      fi

      (
        echo
        echo "Running libiconv make..."

        # Build.
        make -j ${JOBS}
        if [ "${WITH_STRIP}" == "y" ]
        then
          make install-strip
        else
          make install
        fi
      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/make-libiconv-output.txt"
    )

    touch "${libiconv_stamp_file_path}"

  else
    echo "Library libiconv already installed."
  fi
}

function do_hidapi() 
{
  # https://github.com/signal11/hidapi/downloads

  # Oct 26, 2011, "0.7.0"

  # https://github.com/signal11/hidapi/archive/hidapi-0.8.0-rc1.zip
  # Oct 7, 2013, "0.8.0-rc1", latest

  HIDAPI_SRC_FOLDER_NAME="hidapi-hidapi-${HIDAPI_VERSION}"
  HIDAPI_FOLDER_NAME="${HIDAPI_SRC_FOLDER_NAME}"

  local hidapi_archive="hidapi-${HIDAPI_VERSION}.zip"
  local hidapi_url="https://github.com/signal11/hidapi/archive/${hidapi_archive}"

  local hidapi_stamp_file_path="${INSTALL_FOLDER_PATH}/stamp-hidapi-${HIDAPI_VERSION}-installed"
  if [ ! -f "${hidapi_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${hidapi_url}" "${hidapi_archive}" \
      "${HIDAPI_SRC_FOLDER_NAME}"

    # Mandatory build in the source folder, so make a local copy.
    rm -rf "${LIBS_BUILD_FOLDER_PATH}/${HIDAPI_FOLDER_NAME}"
    mkdir -p "${LIBS_BUILD_FOLDER_PATH}/${HIDAPI_FOLDER_NAME}"
    cp -r "${SOURCES_FOLDER_PATH}/${HIDAPI_SRC_FOLDER_NAME}"/* \
      "${LIBS_BUILD_FOLDER_PATH}/${HIDAPI_FOLDER_NAME}"

    (
      cd "${LIBS_BUILD_FOLDER_PATH}/${HIDAPI_FOLDER_NAME}"

      xbb_activate
      xbb_activate_installed_dev

      if [ "${TARGET_PLATFORM}" == "win32" ]
      then

        HIDAPI_OBJECT="hid.o"
        HIDAPI_A="libhid.a"

        cd "${LIBS_BUILD_FOLDER_PATH}/${HIDAPI_FOLDER_NAME}/windows"

        export CFLAGS="${XBB_CFLAGS}"

        make -f Makefile.mingw \
          CC=${CROSS_COMPILE_PREFIX}-gcc \
          "${HIDAPI_OBJECT}"

        # Make just compiles the file. Create the archive and convert it to library.
        # No dynamic/shared libs involved.
        ar -r  libhid.a "${HIDAPI_OBJECT}"
        ${CROSS_COMPILE_PREFIX}-ranlib libhid.a

        mkdir -p "${LIBS_INSTALL_FOLDER_PATH}/lib"
        cp -v libhid.a \
          "${LIBS_INSTALL_FOLDER_PATH}/lib"

        mkdir -p "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
        sed -e "s|XXX|${LIBS_INSTALL_FOLDER_PATH}|" \
          "${BUILD_GIT_PATH}/pkgconfig/hidapi-${HIDAPI_VERSION}-windows.pc" \
          > "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig/hidapi.pc"

        mkdir -p "${LIBS_INSTALL_FOLDER_PATH}/include/hidapi"
        cp -v "${SOURCES_FOLDER_PATH}/${HIDAPI_FOLDER_NAME}/hidapi/hidapi.h" \
          "${LIBS_INSTALL_FOLDER_PATH}/include/hidapi"

      elif [ "${TARGET_PLATFORM}" == "linux" -o "${TARGET_PLATFORM}" == "darwin" ]
      then

        if [ "${TARGET_PLATFORM}" == "linux" ]
        then
          do_copy_libudev

          export LIBS="-liconv"
        fi

        echo
        echo "Running hidapi bootstrap..."

        bash ./bootstrap

        export CFLAGS="${XBB_CFLAGS}"
        export CPPFLAGS="${XBB_CPPFLAGS}"
        export LDFLAGS="${XBB_LDFLAGS_LIB}"

        (
          echo
          echo "Running hidapi configure..."

          bash "./configure" --help
        
          bash ${DEBUG} "./configure" \
            --prefix="${LIBS_INSTALL_FOLDER_PATH}" \
            \
            --build=${BUILD} \
            --host=${HOST} \
            --target=${TARGET} \
            \
            --enable-shared \
            --disable-static \
            --disable-testgui
        
          cp "config.log" "${LOGS_FOLDER_PATH}/config-hidapi-log.txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/configure-hidapi-output.txt"

        (
          echo
          echo "Running hidapi make..."

          # Build.
          make -j ${JOBS}
          if [ "${WITH_STRIP}" == "y" ]
          then
            make install-strip
          else
            make install
          fi
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/make-hidapi-output.txt"

      fi

      rm -f "${LIBS_INSTALL_FOLDER_PATH}"/lib*/libhidapi-hidraw.la
    )

    touch "${hidapi_stamp_file_path}"

  else
    echo "Library hidapi already installed."
  fi
}

function do_copy_libudev()
{
  cp "/usr/include/libudev.h" "${LIBS_INSTALL_FOLDER_PATH}/include"

  if [ "${TARGET_ARCH}" == "x64" ]
  then
    if [ -f "/usr/lib/x86_64-linux-gnu/libudev.so" ]
    then
      cp "/usr/lib/x86_64-linux-gnu/libudev.so" "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp "/usr/lib/x86_64-linux-gnu/pkgconfig/libudev.pc" "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
    elif [ -f "/lib/x86_64-linux-gnu/libudev.so" ]
    then
      # In Debian 9 the location changed to /lib
      cp "/lib/x86_64-linux-gnu/libudev.so" "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp "/usr/lib/x86_64-linux-gnu/pkgconfig/libudev.pc" "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
    elif [ -f "/usr/lib/libudev.so" ]
    then
      # In ARCH the location is /usr/lib
      cp "/usr/lib/libudev.so" "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp "/usr/lib/pkgconfig/libudev.pc" "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
    elif [ -f "/usr/lib64/libudev.so" ]
    then
      # In CentOS the location is /usr/lib64
      cp "/usr/lib64/libudev.so" "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp "/usr/lib64/pkgconfig/libudev.pc" "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
    else
      echo "No libudev.so; abort."
      exit 1
    fi
  elif [ "${TARGET_ARCH}" == "x32" ] 
  then
    if [ -f "/usr/lib/i386-linux-gnu/libudev.so" ]
    then
      cp "/usr/lib/i386-linux-gnu/libudev.so" "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp "/usr/lib/i386-linux-gnu/pkgconfig/libudev.pc" "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
    elif [ -f "/lib/i386-linux-gnu/libudev.so" ]
    then
      # In Debian 9 the location changed to /lib
      cp "/lib/i386-linux-gnu/libudev.so" "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp "/usr/lib/i386-linux-gnu/pkgconfig/libudev.pc" "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
    elif [ -f "/lib/libudev.so.0" ]
    then
      # In CentOS the location is /lib 
      cp "/lib/libudev.so.0" "${LIBS_INSTALL_FOLDER_PATH}/lib"
      cp "/usr/lib/pkgconfig/libudev.pc" "${LIBS_INSTALL_FOLDER_PATH}/lib/pkgconfig"
    else
      echo "No libudev.so; abort."
      exit 1
    fi
  fi
}
