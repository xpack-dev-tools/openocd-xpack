### Uninstall

The binaries are distributed as portable archives; thus they do not need
to run a setup and do not require an uninstall; simply removing the
links and possibly the central store folder is enough.

To remove the links created by xpm in the current project,
go to the project folder:

```sh
cd my-project
```

and ask **xpm** to uninstall the package:

```sh
xpm uninstall @xpack-dev-tools/openocd
```

To completely remove the package from the central store:

```sh
xpm uninstall --global @xpack-dev-tools/openocd --verbose
```
