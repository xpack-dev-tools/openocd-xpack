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
  if [ ! -d "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}" ]
  then
    (
      xbb_activate

      cd "${WORK_FOLDER_PATH}"
      git_clone "${OPENOCD_GIT_URL}" "${OPENOCD_GIT_BRANCH}" \
          "${OPENOCD_GIT_COMMIT}" "${OPENOCD_SRC_FOLDER_NAME}"
      cd "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}"
      git submodule update --init --recursive --remote
    )
  fi
}

# -----------------------------------------------------------------------------

function do_openocd()
{
    download_openocd

    (
      xbb_activate
      xbb_activate_installed_dev

      cd "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}"
      if [ ! -d "autom4te.cache" ]
      then
        ./bootstrap
      fi

      mkdir -p "${APP_BUILD_FOLDER_PATH}"
      cd "${APP_BUILD_FOLDER_PATH}"

      export JAYLINK_CFLAGS='${XBB_CFLAGS} -fvisibility=hidden'

      if [ "${TARGET_PLATFORM}" == "win32" ]
      then

        # --enable-minidriver-dummy -> configure error
        # --enable-zy1000 -> netinet/tcp.h: No such file or directory

        # --enable-openjtag_ftdi -> --enable-openjtag
        # --enable-presto_libftdi -> --enable-presto
        # --enable-usb_blaster_libftdi -> --enable-usb_blaster

        export OUTPUT_DIR="${BUILD_FOLDER_PATH}"
        
        # Without it, mingw redefines it as 0.
        CPPFLAGS="${XBB_CPPFLAGS} -D__USE_MINGW_ANSI_STDIO=1"
        CFLAGS="${XBB_CFLAGS_NO_W}" 
        CXXFLAGS="${XBB_CXXFLAGS_NO_W}" 
        LDFLAGS="${XBB_LDFLAGS_APP}"
        LIBS=""

        AMTJTAGACCEL="--enable-amtjtagaccel"
        # --enable-buspirate -> not supported on mingw
        BUSPIRATE="--disable-buspirate"
        GW18012="--enable-gw16012"
        PARPORT="--enable-parport"
        PARPORT_GIVEIO="--enable-parport-giveio"
        # --enable-sysfsgpio -> available only on Linux
        SYSFSGPIO="--disable-sysfsgpio"

      elif [ "${TARGET_PLATFORM}" == "linux" ]
      then

        # --enable-minidriver-dummy -> configure error

        # --enable-openjtag_ftdi -> --enable-openjtag
        # --enable-presto_libftdi -> --enable-presto
        # --enable-usb_blaster_libftdi -> --enable-usb_blaster

        CPPFLAGS="${XBB_CPPFLAGS}"
        CFLAGS="${XBB_CFLAGS_NO_W}"
        CXXFLAGS="${XBB_CXXFLAGS_NO_W}"
        LDFLAGS="${XBB_LDFLAGS_APP}" 
        LIBS="-lpthread -lrt -ludev"

        AMTJTAGACCEL="--enable-amtjtagaccel"
        BUSPIRATE="--enable-buspirate"
        GW18012="--enable-gw16012"
        PARPORT="--enable-parport"
        PARPORT_GIVEIO="--enable-parport-giveio"
        SYSFSGPIO="--enable-sysfsgpio"

      elif [ "${TARGET_PLATFORM}" == "darwin" ]
      then

        # --enable-minidriver-dummy -> configure error

        # --enable-openjtag_ftdi -> --enable-openjtag
        # --enable-presto_libftdi -> --enable-presto
        # --enable-usb_blaster_libftdi -> --enable-usb_blaster

        CPPFLAGS="${XBB_CPPFLAGS}"
        CFLAGS="${XBB_CFLAGS_NO_W}"
        CXXFLAGS="${XBB_CXXFLAGS_NO_W}"
        LDFLAGS="${XBB_LDFLAGS_APP}"
        LIBS="" # "-lobjc"

        # --enable-amtjtagaccel -> 'sys/io.h' file not found
        AMTJTAGACCEL="--disable-amtjtagaccel"
        BUSPIRATE="--enable-buspirate"
        # --enable-gw16012 -> 'sys/io.h' file not found
        GW18012="--disable-gw16012"
        PARPORT="--disable-parport"
        PARPORT_GIVEIO="--disable-parport-giveio"
        # --enable-sysfsgpio -> available only on Linux
        SYSFSGPIO="--disable-sysfsgpio"

      else

        echo "Unsupported target platorm ${TARGET_PLATFORM}."
        exit 1

      fi

      export CPPFLAGS 
      export CFLAGS 
      export CXXFLAGS 
      export LDFLAGS
      export LIBS

      if [ ! -f "config.status" ]
      then

        # May be required for repetitive builds, because this is an executable built 
        # in place and using one for a different architecture may not be a good idea.
        rm -rfv "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}/jimtcl/autosetup/jimsh0"

        (
          echo
          echo "Running openocd configure..."
      
          bash "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}/configure" --help

          run_verbose bash ${DEBUG} "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}/configure" \
            --prefix="${APP_PREFIX}"  \
            \
            --build=${BUILD} \
            --host=${HOST} \
            --target=${TARGET} \
            \
            --datarootdir="${INSTALL_FOLDER_PATH}" \
            --localedir="${APP_PREFIX}/share/locale"  \
            --mandir="${APP_PREFIX_DOC}/man"  \
            --pdfdir="${APP_PREFIX_DOC}/pdf"  \
            --infodir="${APP_PREFIX_DOC}/info" \
            --docdir="${APP_PREFIX_DOC}"  \
            \
            --disable-wextra \
            --disable-werror \
            --enable-dependency-tracking \
            \
            --enable-branding="${BRANDING}" \
            \
            --enable-aice \
            ${AMTJTAGACCEL} \
            --enable-armjtagew \
            --enable-at91rm9200 \
            --enable-bcm2835gpio \
            ${BUSPIRATE} \
            --enable-cmsis-dap \
            --enable-dummy \
            --enable-ep93xx \
            --enable-ftdi \
            ${GW18012} \
            --disable-ioutil \
            --enable-jlink \
            --enable-jtag_vpi \
            --disable-minidriver-dummy \
            --disable-oocd_trace \
            --enable-opendous \
            --enable-openjtag \
            --enable-osbdm \
            ${PARPORT} \
            --disable-parport-ppdev \
            ${PARPORT_GIVEIO} \
            --enable-presto \
            --enable-remote-bitbang \
            --enable-rlink \
            --enable-stlink \
            ${SYSFSGPIO} \
            --enable-ti-icdi \
            --enable-ulink \
            --enable-usb-blaster \
            --enable-usb_blaster_2 \
            --enable-usbprog \
            --enable-vsllink \
            --disable-zy1000-master \
            --disable-zy1000 \

          cp "config.log" "${LOGS_FOLDER_PATH}/config-openocd-log.txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/configure-openocd-output.txt"

      fi

      (
        echo
        echo "Running openocd make..."
      
        # Build.
        run_verbose make -j ${JOBS} bindir="bin" pkgdatadir=""

        if [ "${WITH_STRIP}" == "y" ]
        then
          run_verbose make install-strip
        else
          run_verbose make install  
        fi

        prepare_app_libraries "${APP_PREFIX}/bin/openocd"

        if [ "${TARGET_PLATFORM}" == "win32" ]
        then
          rm -f "${APP_PREFIX}/bin/openocdw.exe"
        fi

        (
          xbb_activate_tex

          if [ "${WITH_PDF}" == "y" ]
          then
            run_verbose make bindir="bin" pkgdatadir="" pdf 
            run_verbose make install-pdf
          fi

          if [ "${WITH_HTML}" == "y" ]
          then
            run_verbose make bindir="bin" pkgdatadir="" html
            run_verbose make install-html
          fi
        )

      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/make-openocd-output.txt"

      copy_license \
        "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}" \
        "${OPENOCD_FOLDER_NAME}"
    )
}

function run_openocd()
{
  run_app "${APP_PREFIX}/bin/openocd" --version
}

# -----------------------------------------------------------------------------

function copy_distro_files()
{
  (
    xbb_activate

    rm -rf "${APP_PREFIX}/${DISTRO_INFO_NAME}"
    mkdir -p "${APP_PREFIX}/${DISTRO_INFO_NAME}"

    copy_build_files

    echo
    echo "Copying xPack files..."

    cd "${WORK_FOLDER_PATH}/build.git"
    install -v -c -m 644 "scripts/${README_OUT_FILE_NAME}" \
      "${APP_PREFIX}/README.md"
  )
}
