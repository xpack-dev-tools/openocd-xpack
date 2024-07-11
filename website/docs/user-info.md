---
title: User Info

date: 2024-07-11 18:56:00 +0300

---

This page is intended for those who plan
to use the OpenOCD binaries.

## Versioning

The version strings used by the OpenOCD project are three number strings
like `0.12.0`; to this string the xPack distribution adds a four number,
but since semver allows only three numbers, all additional ones can
be added only as pre-release strings, separated by a dash,
like `0.12.0-3`. When published as a npm package, the version gets
a fifth number, like `0.12.0-3.1`.

Since adherence of third party packages to semver is not guaranteed,
it is recommended to avoid using semver expressions like `^0.12.0` or
`~0.12.0`, and prefer exact matches, like `0.12.0-3.1`.

## Drivers

### Windows drivers

Most JTAG probes require separate drivers on Windows.
For more details please read the
[Install](/docs/install/) page.

### GNU/Linux UDEV subsystem

For the JTAG probes implemented as USB devices (actually most of them),
the last installation step on GNU/Linux is to configure the UDEV subsystem.

For more details please read the
[Install](https://xpack.github.io/openocd/install/) page.
