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

function download_openocd()
{
  if [ ! -d "${XBB_SOURCES_FOLDER_PATH}/${openocd_src_folder_name}" ]
  then
    (
      cd "${XBB_SOURCES_FOLDER_PATH}"
      git_clone "${XBB_OPENOCD_GIT_URL}" "${XBB_OPENOCD_GIT_BRANCH}" \
          "${XBB_OPENOCD_GIT_COMMIT}" "${openocd_src_folder_name}"
      cd "${XBB_SOURCES_FOLDER_PATH}/${openocd_src_folder_name}"
      git submodule update --init --recursive --remote
    )
  fi
}

# -----------------------------------------------------------------------------

function build_openocd()
{
  # https://github.com/archlinux/svntogit-community/blob/packages/openocd/trunk/PKGBUILD

  local openocd_version="$1"


  local openocd_src_folder_name="${XBB_OPENOCD_SRC_FOLDER_NAME:-"openocd.git"}"
  local openocd_folder_name="openocd-${openocd_version}"

  mkdir -pv "${XBB_LOGS_FOLDER_PATH}/${openocd_folder_name}"

  local openocd_stamp_file_path="${XBB_STAMPS_FOLDER_PATH}/stamp-${openocd_folder_name}-installed"
  if [ ! -f "${openocd_stamp_file_path}" ]
  then
    (
      download_openocd

      xbb_activate_installed_dev
      xbb_activate_installed_bin

      cd "${XBB_SOURCES_FOLDER_PATH}/${openocd_src_folder_name}"
      (
        if [ ! -d "autom4te.cache" ]
        then
          ./bootstrap
        fi
      ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${openocd_folder_name}/configure-output-$(ndate).txt"

      mkdir -pv "${XBB_BUILD_FOLDER_PATH}/${openocd_folder_name}"
      cd "${XBB_BUILD_FOLDER_PATH}/${openocd_folder_name}"

      CPPFLAGS="${XBB_CPPFLAGS}"
      CFLAGS="${XBB_CFLAGS_NO_W}"
      CXXFLAGS="${XBB_CXXFLAGS_NO_W}"

      # It makes little sense to use -static-libgcc here, since
      # several shared libraries will refer to it anyway.
      LDFLAGS="${XBB_LDFLAGS_APP}"
      if [ "${XBB_TARGET_PLATFORM}" == "linux" ]
      then
        xbb_activate_cxx_rpath
        LDFLAGS+=" -Wl,-rpath,${LD_LIBRARY_PATH}"
      fi
      LIBS=""

      export CPPFLAGS
      export CFLAGS
      export CXXFLAGS

      export LDFLAGS
      export LIBS

      export JAYLINK_CFLAGS='${XBB_CFLAGS} -fvisibility=hidden'

      if [ ! -f "config.status" ]
      then

        # May be required for repetitive builds, because this is an executable built
        # in place and using one for a different architecture may not be a good idea.
        rm -rfv "${XBB_SOURCES_FOLDER_PATH}/${openocd_src_folder_name}/jimtcl/autosetup/jimsh0"

        (
          if [ "${XBB_IS_DEVELOP}" == "y" ]
          then
            env | sort
          fi

          echo
          echo "Running openocd configure..."

          if [ "${XBB_IS_DEVELOP}" == "y" ]
          then
            bash "${XBB_SOURCES_FOLDER_PATH}/${openocd_src_folder_name}/configure" --help
          fi

          config_options=()

          config_options+=("--prefix=${XBB_BINARIES_INSTALL_FOLDER_PATH}")

          config_options+=("--build=${XBB_BUILD}")
          config_options+=("--host=${XBB_HOST}")
          config_options+=("--target=${XBB_TARGET}")

          config_options+=("--datarootdir=${XBB_BINARIES_INSTALL_FOLDER_PATH}")
          config_options+=("--localedir=${XBB_BINARIES_INSTALL_FOLDER_PATH}/share/locale")
          config_options+=("--mandir=${XBB_BINARIES_INSTALL_FOLDER_PATH}/share/doc/man")
          config_options+=("--pdfdir=${XBB_BINARIES_INSTALL_FOLDER_PATH}/share/doc/pdf")
          config_options+=("--infodir=${XBB_BINARIES_INSTALL_FOLDER_PATH}/share/doc/info")
          config_options+=("--docdir=${XBB_BINARIES_INSTALL_FOLDER_PATH}/share/doc/")

          config_options+=("--disable-wextra")
          config_options+=("--disable-werror")
          config_options+=("--disable-gccwarnings")
          config_options+=("--disable-doxygen-html")
          config_options+=("--disable-doxygen-pdf")

          config_options+=("--disable-debug") # HB
          config_options+=("--disable-dependency-tracking") # HB
          if [ "${XBB_IS_DEVELOP}" == "y" ]
          then
            config_options+=("--disable-silent-rules") # HB
          fi

          config_options+=("--enable-branding=${XBB_BRANDING}")

          # Add explicit functionality.
          config_options+=("--enable-aice")
          config_options+=("--enable-armjtagew")
          config_options+=("--enable-at91rm9200")
          config_options+=("--enable-bcm2835gpio")
          config_options+=("--enable-cmsis-dap")
          config_options+=("--enable-dummy")
          config_options+=("--enable-ep93xx")
          config_options+=("--enable-ft232r")
          config_options+=("--enable-ftdi")
          config_options+=("--enable-imx_gpio")
          config_options+=("--enable-jlink")
          config_options+=("--enable-jtag_vpi")
          config_options+=("--enable-kitprog")
          # Deprecated
          # config_options+=("--enable-oocd_trace")
          config_options+=("--enable-opendous")
          config_options+=("--enable-openjtag")
          config_options+=("--enable-osbdm")
          config_options+=("--enable-presto")
          config_options+=("--enable-remote-bitbang")
          config_options+=("--enable-rlink")
          config_options+=("--enable-stlink")
          config_options+=("--enable-ti-icdi")
          config_options+=("--enable-ulink")
          config_options+=("--enable-usb-blaster")
          config_options+=("--enable-usb_blaster_2")
          config_options+=("--enable-usbprog")
          config_options+=("--enable-vsllink")
          config_options+=("--enable-xds110")

          # Disable drivers that apparently failed to build on all platforms.
          config_options+=("--disable-zy1000-master")
          config_options+=("--disable-zy1000")
          config_options+=("--disable-ioutil")
          config_options+=("--disable-minidriver-dummy")
          config_options+=("--disable-parport-ppdev")

          if [ "${XBB_TARGET_PLATFORM}" == "win32" ]
          then

            export OUTPUT_DIR="${XBB_BUILD_FOLDER_PATH}"

            # Without it, mingw redefines it as 0.
            CPPFLAGS+=" -D__USE_MINGW_ANSI_STDIO=1"

            # --enable-minidriver-dummy -> configure error
            # --enable-zy1000 -> netinet/tcp.h: No such file or directory

            # --enable-openjtag_ftdi -> --enable-openjtag
            # --enable-presto_libftdi -> --enable-presto
            # --enable-usb_blaster_libftdi -> --enable-usb_blaster

            config_options+=("--enable-amtjtagaccel")
            config_options+=("--enable-gw16012")
            config_options+=("--enable-parport")
            config_options+=("--enable-parport-giveio")

            # --enable-sysfsgpio -> available only on Linux
            config_options+=("--disable-sysfsgpio")
            # --enable-buspirate -> not supported on mingw
            config_options+=("--disable-buspirate")

            # oocd_trace.h:22:10: fatal error: termios.h: No such file or directory
            config_options+=("--disable-oocd_trace")

          elif [ "${XBB_TARGET_PLATFORM}" == "linux" ]
          then

            LDFLAGS+=" -Wl,-rpath,${LD_LIBRARY_PATH}"
            LIBS+=" -lpthread -lrt -ludev"

            # --enable-minidriver-dummy -> configure error

            # --enable-openjtag_ftdi -> --enable-openjtag
            # --enable-presto_libftdi -> --enable-presto
            # --enable-usb_blaster_libftdi -> --enable-usb_blaster

            config_options+=("--enable-amtjtagaccel")
            config_options+=("--enable-buspirate")
            config_options+=("--enable-gw16012")
            config_options+=("--enable-parport")
            config_options+=("--enable-parport-giveio")
            config_options+=("--enable-sysfsgpio")

            # Deprecated
            # config_options+=("--enable-oocd_trace")

          elif [ "${XBB_TARGET_PLATFORM}" == "darwin" ]
          then

            # --enable-minidriver-dummy -> configure error

            # --enable-openjtag_ftdi -> --enable-openjtag
            # --enable-presto_libftdi -> --enable-presto
            # --enable-usb_blaster_libftdi -> --enable-usb_blaster

            config_options+=("--enable-buspirate")

            # --enable-amtjtagaccel -> 'sys/io.h' file not found
            config_options+=("--disable-amtjtagaccel")
            # --enable-gw16012 -> 'sys/io.h' file not found
            config_options+=("--disable-gw16012")
            config_options+=("--disable-parport")
            config_options+=("--disable-parport-giveio")
            # --enable-sysfsgpio -> available only on Linux
            config_options+=("--disable-sysfsgpio")

            # /Users/ilg/Work/openocd-0.10.0-14/openocd.git/src/target/oocd_trace.c: In function ‘oocd_trace_init’:
            # /Users/ilg/Work/openocd-0.10.0-14/openocd.git/src/target/oocd_trace.c:121:54: error: ‘B2500000’ undeclared (first use in this function)
            config_options+=("--disable-oocd_trace")

          else

            echo "Unsupported target platorm ${XBB_TARGET_PLATFORM}."
            exit 1

          fi

          run_verbose bash ${DEBUG} "${XBB_SOURCES_FOLDER_PATH}/${openocd_src_folder_name}/configure" \
            "${config_options[@]}"

          cp "config.log" "${XBB_LOGS_FOLDER_PATH}/${openocd_folder_name}/config-log-$(ndate).txt"
        ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${openocd_folder_name}/configure-output-$(ndate).txt"

      fi

      (
        echo
        echo "Running openocd make..."

        # Build.
        # run_verbose make -j ${XBB_JOBS} bindir="bin" pkgdatadir=""
        run_verbose make -j 1 bindir="bin" pkgdatadir=""

        if [ "${XBB_WITH_STRIP}" == "y" ]
        then
          run_verbose make install-strip
        else
          run_verbose make install
        fi

        if [ "${XBB_TARGET_PLATFORM}" == "win32" ]
        then
          rm -f "${XBB_BINARIES_INSTALL_FOLDER_PATH}/bin/openocdw.exe"
        fi

        (
          # xbb_activate_tex

          if [ "${XBB_WITH_PDF}" == "y" ]
          then
            run_verbose make bindir="bin" pkgdatadir="" pdf
            run_verbose make install-pdf
          fi

          if [ "${XBB_WITH_HTML}" == "y" ]
          then
            run_verbose make bindir="bin" pkgdatadir="" html
            run_verbose make install-html
          fi
        )

      ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${openocd_folder_name}/make-output-$(ndate).txt"

      copy_license \
        "${XBB_SOURCES_FOLDER_PATH}/${openocd_src_folder_name}" \
        "${openocd_folder_name}"
    )

    mkdir -pv "${XBB_STAMPS_FOLDER_PATH}"
    touch "${openocd_stamp_file_path}"

  else
    echo "Component openocd already installed."
  fi

  tests_add "test_openocd"
}

function test_openocd()
{
  local test_bin_path="$1"

  echo
  echo "Checking the openocd shared libraries..."
  show_libs "${test_bin_path}/openocd"

  echo
  echo "Checking if openocd starts..."

  run_app "${test_bin_path}/openocd" --version

  run_app "${test_bin_path}/openocd" \
    -c "adapter driver dummy" \
    -c "adapter speed 1000" \
    -c "adapter list" \
    -c "transport list" \
    -c "target types" \
    -c "echo baburiba" \
    -c "shutdown"

}

# -----------------------------------------------------------------------------
