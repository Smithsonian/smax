![Build Status](https://github.com/Smithsonian/smax/actions/workflows/build.yml/badge.svg)
![Static Analysis](https://github.com/Smithsonian/smax/actions/workflows/check.yml/badge.svg)
<a href="https://smithsonian.github.io/smax-postgres/apidoc/html/files.html">
 ![API documentation](https://github.com/Smithsonian/smax/actions/workflows/dox.yml/badge.svg)
</a>

<picture>
  <source srcset="resources/CfA-logo-dark.png" alt="CfA logo" media="(prefers-color-scheme: dark)"/>
  <source srcset="resources/CfA-logo.png" alt="CfA logo" media="(prefers-color-scheme: light)"/>
  <img src="resources/CfA-logo.png" alt="CfA logo" width="400" height="67" align="right"/>
</picture>
<br clear="all">


# SMA-X

[SMA-X](https://docs.google.com/document/d/1eYbWDClKkV7JnJxv4MxuNBNV47dFXuUWu7C4Ve_YTf0/edit?usp=sharing) is a realtime 
structured database for information sharing on distributed systems.

This is a meta repository, offering a collection of SMA-X related repositories in one place as git submodules. As such
it helps ensure that all components are in a well-defined and compatible state, and it simplifies the build by having
dependencies in one place.

Author: Attila Kovacs

Last Updated: 26 September 2024

----------------------------------------------------------------------------------------------------------------------

<a name="prerequisites"></a>
## Prerequisites

The core components of SMA-X do not have non-standard dependencies. 

However, the `smax-postgres` application (built via the `services` target) has build and runtime dependencies on the 
following software:

 - __PostgreSQL__ installation and development files (`libpq.so` and `lipq.fe.h`).
 - __Popt__ development libraries (`libpopt-dev`in Debian, or `popt-devel` in RPM distros)
 - (_optional_) __TimescaleDB__ extensions.
 - (_optional_) __systemd__ development files (`libsystemd.so` and `sd-daemon.h`).

----------------------------------------------------------------------------------------------------------------------

<a name="building"></a>
## Building

You can configure the build by defining the relevant environment variables prior to invoking `make`. The following 
build variables can be configured:

 - `PGDIR`: Root directory of a specific PostgreSQL installation to build against (not set by default).
   
 - `SYSTEMD`: Sets whether to compile with `systemd` integration (needs `libsystemd.so` and `sd-daemon.h`). Default
   is 1 (enabled).
   
 - `CC`: The C compiler to use (default: `gcc`).

 - `CPPFLAGS`: C preprocessor flags, such as externally defined compiler constants.
 
 - `CFLAGS`: Flags to pass onto the C compiler (default: `-Os -Wall -std=c99`). Note, `-Iinclude` will be added 
   automatically.
   
 - `LDFLAGS`: Extra linker flags (default: _not set_). Note, `-lm -pthread -lsmax -lredisx -lxchange -lpq -lpopt` will 
   be added automatically.

 - `BUILD_MODE`: You can set it to `debug` to enable debugging features: it will initialize the global `xDebug` 
   variable to `TRUE` and add `-g` to `CFLAGS`.

 - `CHECKEXTRA`: Extra options to pass to `cppcheck` for the `make check` target
 
After configuring, you can simply run `make`, which will build `bin/smax-postgres`, and user documentation. You may 
also build other `make` target(s). (You can use `make help` to get a summary of the available `make` targets). 

Now you may build it all by:

```bash
  $ make
```

Or, you may build selected targets, such as share libraries (`shared`), static libraries (`static`), executables
(`tools`) and/or API documentation (`dox`).

-----------------------------------------------------------------------------
Copyright (C) 2024 Attila Kovács


