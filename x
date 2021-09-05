

# -----------------------------------------------------------------------------
# DO NOT EDIT! Generated from scripts/helper/templates/test-native-liquid.yml.
#
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2021 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# https://help.github.com/en/actions
# https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners

# https://docs.github.com/en/actions/reference/events-that-trigger-workflows#workflow_dispatch
# https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads#workflow_dispatch
# https://docs.github.com/en/rest/reference/actions#create-a-workflow-dispatch-event

# -----------------------------------------------------------------------------

name: 'Test xPack {{ APP_NAME }} via xpm'

on:
  workflow_dispatch:
    inputs:
      version:
        description: 'The semver of the npm release'
        required: false
        default: 'latest'

jobs:
  linux-x64:
    name: 'Intel Linux 64-bit {{ APP_NAME }}@{% raw %}${{ github.event.inputs.version }}{% endraw %} test'
    runs-on: ubuntu-latest
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2
        with:
          fetch-depth: 3
          submodules: true
      - name: 'Install xpm'
        run: npm install --global xpm
      - name: 'Run xpm {% raw %}${{ github.event.inputs.version }}{% endraw %} test'
        run: bash scripts/helper/tests/xpm-test.sh --version {% raw %}${{ github.event.inputs.version }}{% endraw %}

  linux-ia32:
    name: 'Intel Linux 32-bit {{ APP_NAME }}@{% raw %}${{ github.event.inputs.version }}{% endraw %} test'
    runs-on: ubuntu-latest
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2
        with:
          fetch-depth: 3
          submodules: true
      - name: 'Debian 10 ia32'
        uses: docker://ilegeul/debian:10-npm-v1
        with:
          entrypoint: /usr/bin/linux32
          args: npm install --global xpm && /bin/bash /github/workspace/scripts/tests/native-test.sh --image i386/debian:buster --version {% raw %}${{ github.event.inputs.version }}{% endraw %} --base-url {% raw %}${{ github.event.inputs.base_url }}{% endraw %}

  linux-arm64:
    name: 'Arm Linux 64-bit {{ APP_NAME }}@{% raw %}${{ github.event.inputs.version }}{% endraw %} test'
    runs-on: [self-hosted, Linux, Arm64]
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2
        with:
          fetch-depth: 3
          submodules: true
      - name: 'Install xpm'
        run: npm install --global xpm
      - name: 'Run xpm {% raw %}${{ github.event.inputs.version }}{% endraw %} test'
        run: bash scripts/helper/tests/xpm-test.sh --version {% raw %}${{ github.event.inputs.version }}{% endraw %}

  macos-x64:
    name: 'Intel macOS 64-bit {{ APP_NAME }}@{% raw %}${{ github.event.inputs.version }}{% endraw %} test'
    runs-on: macos-latest
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2
        with:
          fetch-depth: 3
          submodules: true
      - name: 'Install xpm'
        run: npm install --global xpm
      - name: 'Run xpm {% raw %}${{ github.event.inputs.version }}{% endraw %} test'
        run: bash scripts/helper/tests/xpm-test.sh --version {% raw %}${{ github.event.inputs.version }}{% endraw %}

  windows-x64:
    name: 'Windows 64-bit {{ APP_NAME }}@{% raw %}${{ github.event.inputs.version }}{% endraw %} test'
    runs-on: windows-latest
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2
        with:
          fetch-depth: 3
          submodules: true
      - name: 'Install xpm'
        run: npm install --global xpm
      - name: 'Run xpm {% raw %}${{ github.event.inputs.version }}{% endraw %} test'
        run: bash scripts/helper/tests/xpm-test.sh --version {% raw %}${{ github.event.inputs.version }}{% endraw %}

  windows-ia32:
    name: 'Windows 32-bit {{ APP_NAME }}@{% raw %}${{ github.event.inputs.version }}{% endraw %} test'
    runs-on: windows-latest
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2
        with:
          fetch-depth: 3
          submodules: true
      - name: 'Install xpm'
        run: npm install --global xpm
      - name: 'Run xpm {% raw %}${{ github.event.inputs.version }}{% endraw %} test'
        run: bash scripts/helper/tests/xpm-test.sh --version {% raw %}${{ github.event.inputs.version }}{% endraw %} --32

# -----------------------------------------------------------------------------
