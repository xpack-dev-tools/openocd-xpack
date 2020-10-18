# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Common functions used in various tests.
#
# Requires 
# - app_folder_path
# - test_folder_path
# - archive_platform (win32|linux|darwin)

# -----------------------------------------------------------------------------

function run_tests()
{
  show_libs "${app_folder_path}/bin/openocd"

  run_app "${app_folder_path}/bin/openocd" --version
  run_app "${app_folder_path}/bin/openocd" --help

  # TODO: add more, if possible.
}

# -----------------------------------------------------------------------------
