# GNU MCU Eclipse OpenOCD

This is the **GNU MCU Eclipse** (formerly GNU ARM Eclipse) version of **OpenOCD**.

## Compliance

GNU MCU Eclipse OpenOCD generally follows the official 
[OpenOCD](http://openocd.org) releases and the 
[RISC-V distribution](https://github.com/riscv/riscv-openocd) 
maintained by [SiFive](https://www.sifive.com).

However some of the RISC-V patches to the common files were considered harmful 
and were reversed, so the common files generaly track the original OpenCOD 
distribution, not the RISC-V fork.

The current version is based on 

- OpenOCD version 0.10.0-development, commit 
[05e0d633b](https://github.com/gnu-mcu-eclipse/openocd/commit/05e0d633bad9e8b0bdfaf16fc76ab1f9d9419d8b) 
from Oct 16th, 2018
- RISC-V commit 
[35eed36ff](https://github.com/gnu-mcu-eclipse/openocd/commit/35eed36ffdd082f5abfc16d4cc93511f6e225284) 
from Sep 18th, 2018

## Changes

Compared to the master OpenOCD, the changes are:

- ARM semihosting uses the new separate implementation; there should be no 
functional differences.

Compared to the RISC-V version, the changes are:

- none functionally relevant

## Documentation

The original documentation is available in the `share/doc` folder.

## More info

For more info and support, please see the GNU MCU Eclipse project pages from:

  http://gnu-mcu-eclipse.github.io

Thank you for using **GNU MCU Eclipse**,

Liviu Ionescu
