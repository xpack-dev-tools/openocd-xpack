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
# should be included with 'source' by the build scripts (both native
# and container).

# -----------------------------------------------------------------------------

function docker_images()
{
  # The names of the Docker images used for the build.
  # docker run --interactive --tty ilegeul/centos:6-xbb-v2.1
  docker_linux64_image=${docker_linux64_image:-"ilegeul/centos:6-xbb-v2.2"}
  docker_linux32_image=${docker_linux32_image:-"ilegeul/centos32:6-xbb-v2.2"}
  docker_linux_arm64_image=${docker_linux_arm64_image:-"ilegeul/ubuntu:arm64-16.04-xbb-v1.1"}
  docker_linux_arm32_image=${docker_linux_arm32_image:-"ilegeul/ubuntu:armhf-16.04-xbb-v1.1"}
}


# -----------------------------------------------------------------------------
