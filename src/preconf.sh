#!/bin/bash

DEVELOPER=`xcode-select -print-path`

# set default output folder is build
OUTPUT_FOLDER=${PREFIX-build}

mkdir -p $OUTPUT_FOLDER

function build_lame()
{
    ./configure.ios \
    CPP="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cpp" \
    CFLAGS="-isysroot ${DEVELOPER}/Platforms/${SDK}.platform/Developer/SDKs/${SDK}.sdk" \
    CC="${DEVELOPER}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -fembed-bitcode -arch ${PLATFORM} -miphoneos-version-min=10.0 " \
    --host="arm-apple-darwin9" \
    --disable-shared \
    --enable-static

    pushd eb
    make clean
    make
    cp ".libs/libeb.a" "../${OUTPUT_FOLDER}/libeb-${PLATFORM}.a"
    popd

}

function build_mac()
{
    ./configure \
    CPP="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cpp" \
    CFLAGS="-isysroot ${DEVELOPER}/Platforms/${SDK}.platform/Developer/SDKs/${SDK}.sdk" \
    CC="${DEVELOPER}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -fembed-bitcode -arch ${PLATFORM} " \
    --disable-shared \
    --enable-static

    pushd eb
    make clean
    make
    cp ".libs/libeb.a" ../"${OUTPUT_FOLDER}/libeb-MAC-${PLATFORM}.a"
    popd
}

# PLATFORM="x86_64"
# SDK="MacOSX"
# build_mac

PLATFORM="x86_64"
SDK="iPhoneSimulator"
build_lame

PLATFORM="armv7"
SDK="iPhoneOS"
build_lame

PLATFORM="armv7s"
build_lame

PLATFORM="arm64"
build_lame

PLATFORM="arm64e"
build_lame

# remove old libmp3lame.a or lipo will failed
OUTPUT_LIB=${OUTPUT_FOLDER}/libeb.a
if [ -f $OUTPUT_LIB ]; then
    rm $OUTPUT_LIB
fi

lipo -create ${OUTPUT_FOLDER}/* -output ${OUTPUT_LIB}
