# The xPack OpenOCD

This is the **xPack** version of **OpenOCD** (formerly part of the 
GNU MCU Eclipse project)

## Compliance

The xPack OpenOCD generally follows the official 
[OpenOCD](http://openocd.org) releases.

The current version is based on:

- OpenOCD version 0.10.0, the development commit 
[c19de41a0](https://github.com/xpack-dev-tools/openocd/commit/c19de41a0f49ee11eb474c51dc243383047bd663) 
from Apr 7th, 2019

## Changes

Compared to the master branch, the following changes were applied:

- a configure option was added to configure branding (`--enable-branding`)
- the src/openocd.c file was edited to display the branding string
- the contrib/60-openocd.rules file was simplified to avoid protection related issues.
  
## Documentation

The original documentation is available in the `share/doc` folder.

## More info

For more info and support, please see the xPack project pages from:

  http://xpack.github.io/dev-tools/openocd

Thank you for using open source software,

Liviu Ionescu
