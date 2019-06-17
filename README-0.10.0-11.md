# GNU MCU Eclipse OpenOCD

This is the **GNU MCU Eclipse** (formerly GNU ARM Eclipse) version of **OpenOCD**.

## Compliance

GNU MCU Eclipse OpenOCD generally follows the official 
[OpenOCD](http://openocd.org) releases.

The current version is based on 

- OpenOCD version 0.10.0-development, commit 
[d140fb27c](https://github.com/gnu-mcu-eclipse/openocd/commit/d140fb27c6afbfa1fe609b5f0db274d4a5273483) 
from Jan 16th, 2019

### RISC-V support

Since the RISC-V support was upstreamed, **GNU MCU Eclipse OpenOCD** no longer
needs to manually track the SiFive fork.

## Changes

Compared to the master branch, the following changes were applied:

- the greeting message was extended to refer to GNU MCU Eclipse
- the `contrib/60-openocd.rules` was simplified to make access easier.

## Documentation

The original documentation is available in the `share/doc` folder.

## More info

For more info and support, please see the GNU MCU Eclipse project pages from:

  http://gnu-mcu-eclipse.github.io

Thank you for using **GNU MCU Eclipse**,

Liviu Ionescu
