# GNU MCU Eclipse OpenOCD

This is the **GNU MCU Eclipse** (formerly GNU ARM Eclipse) version of **OpenOCD**.

## Compliance

GNU MCU Eclipse OpenOCD generally follows the official [OpenOCD](http://openocd.org) releases and the [RISC-V distribution](https://github.com/riscv/riscv-openocd) 
maintained by [SiFive](https://www.sifive.com).

The current version is based on 

- OpenOCD version 0.10.0-development, commit [7b94ae9](https://github.com/gnu-mcu-eclipse/openocd/commit/7b94ae9e520877e7f2341b48b3bd0c0d1ca8a14b) from Apr 27th, 2018
- RISC-V commit [dabaf17](https://github.com/gnu-mcu-eclipse/openocd/commit/dabaf170bac10975ac1773adb6367bc1ffc0cd6a) from May 9th, 2018

## Changes

Compared to the master OpenOCD, the changes are:

- ARM semihosting uses the new separate implementation; there should be no functional differences.

Compared to the RISC-V version, the changes are:

- none functionally relevant

## Documentation

The original documentation is available in the `share/doc` folder.

## More info

For more info and support, please see the GNU MCU Eclipse project pages from:

  http://gnu-mcu-eclipse.github.io

Thank you for using **GNU MCU Eclipse**,

Liviu Ionescu
