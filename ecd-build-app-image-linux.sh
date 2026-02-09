#!/bin/bash

QT_DIR=${QT_DIR:-~/Qt/6.10.0/}

if [ ! -d "$QT_DIR" ]; then
    echo "QT_DIR is not set or does not exist: $QT_DIR"
    exit 1
fi

QT_CMAKE="$QT_DIR/gcc_64/bin/qt-cmake"
if [ ! -x "$QT_CMAKE" ]; then
    echo "qt-cmake not found or not executable at: $QT_CMAKE"
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR

$QT_CMAKE \
	-B build -G Ninja \
	-DCMAKE_BUILD_TYPE=Release \
	-DGStreamer_USE_STATIC_LIBS=true -DCMAKE_INSTALL_PREFIX=./build/AppDir/usr/

cmake --build build --config Release
