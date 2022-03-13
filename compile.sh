#!/bin/bash
export PATH=/mnt/mxe/usr/bin:$PATH
MXE_PATH=$HOME/MXE
MXE_INCLUDE_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/include
MXE_LIB_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/lib
SECP256K1_LIB_PATH=/usr/lib:/usr/local/bin

cd /mnt/Mic2.0/src/leveldb
TARGET_OS=NATIVE_WINDOWS make CC=/mnt/mxe/usr/bin/i686-w64-mingw32.static-gcc CXX=/mnt/mxe/usr/bin/i686-w64-mingw32.static-g++

cd ../..

/mnt/mxe/usr/bin/i686-w64-mingw32.static-qmake-qt5 \
	BOOST_LIB_SUFFIX=-mt \
	BOOST_THREAD_LIB_SUFFIX=_win32-mt \
	BOOST_INCLUDE_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/include/boost \
	BOOST_LIB_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/lib \
	OPENSSL_INCLUDE_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/include/openssl \
	OPENSSL_LIB_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/lib \
	BDB_INCLUDE_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/include \
	BDB_LIB_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/lib \
	MINIUPNPC_INCLUDE_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/include \
	MINIUPNPC_LIB_PATH=/mnt/mxe/usr/i686-w64-mingw32.static/lib \
	QMAKE_LRELEASE=/mnt/mxe/usr/i686-w64-mingw32.static/qt5/bin/lrelease Mic3.pro

make -j 16 -f Makefile.Release
