Copyright (c) 2009-2012 Bitcoin Developers
Distributed under the MIT/X11 software license, see the accompanying
file license.txt or http://www.opensource.org/licenses/mit-license.php.
This product includes software developed by the OpenSSL Project for use in
the OpenSSL Toolkit (http://www.openssl.org/).  This product includes
cryptographic software written by Eric Young (eay@cryptsoft.com) and UPnP
software written by Thomas Bernard.


See readme-qt.rst for instructions on building Mousecoin QT, the
graphical user interface.

# ===================
# WINDOWS BUILD NOTES
# ===================

## Compilers Supported
-------------------
TODO: What works?
Note: releases are cross-compiled using mingw running on Linux.


## Dependencies
------------
Libraries you need to download separately and build:

| default | path | download |
|---------|------|----------|
| OpenSSL | \openssl-1.0.2r | https://sperocoin.org/build_windows/download/openssl-1.0.2r.tar.gz |
|Berkeley DB | \db-4.8.30.NC | https://download.oracle.com/berkeley-db/db-4.8.30.tar.gz |
|Boost | \boost-1.57.0 | https://sperocoin.org/build_windows/download/boost_1_57_0.7z |
|miniupnpc | \miniupnpc-1.6 | http://miniupnp.free.fr/files/miniupnpc-1.6.20120509.tar.gz |
|protobuf | \protobuf-3.7.1 | https://sperocoin.org/build_windows/download/protobuf-all-3.7.1.zip |
|libpng | \libpng-1.6.36 | https://sperocoin.org/build_windows/download/libpng-1.6.36.tar.gz |
|QREncode | \qrencode-4.0.2 | https://sperocoin.org/build_windows/download/qrencode-4.0.2.tar.gz |
|QTBase | \qtbase-opensource-src-5.3.2 | https://sperocoin.org/build_windows/download/qtbase-opensource-src-5.3.2.7z |
|QTtools | \qttools-opensource-src-5.3.2 | https://sperocoin.org/build_windows/download/qttools-opensource-src-5.3.2.7z |

Their licenses:
- OpenSSL        Old BSD license with the problematic advertising requirement
- Berkeley DB    New BSD license with additional requirement that linked software must be free open source
- Boost          MIT-like license
- miniupnpc      New (3-clause) BSD license

Versions used in this release:
> OpenSSL      1.0.2r
> Berkeley DB  4.8.30.NC
> Boost        1.57.0
> miniupnpc    1.6
> protobuf     3.7.1
> libpng       1.6.36
> QREncode     4.0.2
> QTBase       5.3.2
> QTtools      5.3.2


### MSYS Shell:
------------
Download: https://sperocoin.org/build_windows/download/mingw-get-setup.exe
After downloading and installing the program, access the application configuration at: MinGW installation manager → All packages → MSYS and select the following options:

```
msys-base-bin
msys-autoconf-bin
msys-automake-bin
msys-libtool-bin
```
After that click on ```Installation → Apply Changes```
Before performing the installation, remember to verify that you have not already installed the msys-gcc and msys-w32api packages.

Download and extract MinGW-builds in the folder C:/:
https://sperocoin.org/build_windows/download/i686-4.9.2-release-posix-dwarf-rt_v3-rev1.7z
Add the path of mingw32 in the system variables, being added in the PATH option of the operating system. On Windows 7 the path should look like the example below:

> C:\mingw32\bin;%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\

### OpenSSL
-------
un-tar sources with MSYS 'tar xfz' to avoid issue with symlinks (OpenSSL ticket 2377)
change 'MAKE' env. variable from 'C:\MinGW32\bin\mingw32-make.exe' to '/c/MinGW32/bin/mingw32-make.exe'

| MSYS Shell: |
|-------------|
```sh
$ cd /c/deps/
$ tar xvfz openssl-1.0.2r.tar.gz
$ cd openssl-1.0.2r
$ ./Configure no-zlib no-shared no-dso no-krb5 no-camellia no-capieng no-cast no-cms no-dtls1 no-gost no-gmp no-heartbeats no-idea no-jpake no-md2 no-mdc2 no-rc5 no-rdrand no-rfc3779 no-rsax no-sctp no-seed no-sha0 no-static_engine no-whirlpool no-rc2 no-rc4 no-ssl2 no-ssl3 mingw
$ make depend
$ make
```

### Berkeley DB
-----------
| MSYS Shell: |
|-------------|
```sh
$ cd /c/deps/
$ tar xvfz db-4.8.30.tar.gz
$ cd db-4.8.30/build_unix
$ ../dist/configure --enable-mingw --enable-cxx --disable-shared --disable-replication
make
```

### Boost
-----
| DOS Prompt: |
|-------------|
``` 
cd C:\deps\boost_1_57_0\
bootstrap.bat mingw
b2 --build-type=complete --with-chrono --with-filesystem --with-program_options --with-system --with-thread toolset=gcc variant=release link=static threading=multi runtime-link=static stage
```

### MiniUPnPc
---------
UPnP support is optional, make with USE_UPNP= to disable it.

| DOS Prompt: |
|-------------|
```
cd C:\deps\miniupnpc
mingw32-make -f Makefile.mingw init upnpc-static
```

### Protobuf
---------
| DOS Prompt: |
|-------------|
```
$ cd /c/deps/
$ cd protobuf-3.7.1
$ configure --disable-shared
$ make
```

## Deploy Only Daemon
---------

### daemon
| MSYS Shell: |
|-------------|
```sh
$ cd /c/Mousecoin-2.0/src/leveldb
$ chmod +x build_detect_platform
$ make clean
$ TARGET_OS=NATIVE_WINDOWS make libleveldb.a libmemenv.a
$ 
$ cd /c/Mousecoin-2.0/src
$ make -f makefile.mingw
$ strip Mousecoind.exe
```

## Deploy QT
---------

### Libpng
---------
| MSYS Shell: |
|-------------|
```sh
$ cd /c/deps/
$ tar xvfz libpng-1.6.36.tar.gz
$ cd libpng-1.6.36
$ configure --disable-shared
$ make
$ cp .libs/libpng16.a .libs/libpng.a
```

### QREncode
---------
| MSYS Shell: |
|-------------|
```sh
$ cd /c/deps/
$ tar xvfz qrencode-4.0.2.tar.gz
$ cd qrencode-4.0.2
$ LIBS="../libpng-1.6.36/.libs/libpng.a ../../mingw32/i686-w64-mingw32/lib/libz.a" \
$ png_CFLAGS="-I../libpng-1.6.36" \
$ png_LIBS="-L../libpng-1.6.36/.libs" \
$ configure --enable-static --disable-shared --without-tools
$ make
```

### QT
---------
Extract the files using 7-zip. Rename the qtbase-opensource-src-5.3.2 folder to 5.3.2.
Create a folder called QT on the C: disk, copy the 5.3.2 and qttools-opensource-src-5.3.2 folders to the C:/QT folder.
Then open the Windows command prompt and enter the codes below.

| DOS Prompt: |
|-------------|
```
set INCLUDE=C:\deps\libpng-1.6.36;C:\deps\openssl-1.0.2r\include
set LIB=C:\deps\libpng-1.6.36\.libs;C:\deps\openssl-1.0.2r

cd C:\Qt\5.3.2
configure.bat -release -opensource -confirm-license -static -make libs -no-sql-sqlite -no-opengl -system-zlib -qt-pcre -no-icu -no-gif -system-libpng -no-libjpeg -no-freetype -no-angle -no-vcproj -openssl -no-dbus -no-audio-backend -no-wmf-backend -no-qml-debug

mingw32-make

set PATH=%PATH%;C:\Qt\5.3.2\bin

cd C:\Qt\qttools-opensource-src-5.3.2
qmake qttools.pro
mingw32-make
```

### Build QT binaries
---------
| MSYS Shell: |
|-------------|
```sh
$ cd /c/Mousecoin-2.0/src/leveldb
$ chmod +x build_detect_platform
$ make clean
$ TARGET_OS=NATIVE_WINDOWS make libleveldb.a libmemenv.a
```

| DOS Prompt: |
|-------------|
```
cd c:\Mousecoin-2.0
qmake "USE_QRCODE=1" "USE_UPNP=-" "USE_IPV6=1" Mic3-qt.pro
mingw32-make -f Makefile.Release
```

Note: Consider using -j with mingw32-make to speed up compilation. On QuadCore processors -j4 or -j5 gave good results.