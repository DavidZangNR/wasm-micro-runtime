#!/bin/sh

# Copyright (C) 2019 Intel Corporation.  All rights reserved.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

rm -fr build && mkdir build
rm -rf ./CMakeLists.txt
OS=$(uname -a | awk '{print $1}')

echo "OS is $OS"
if [ "z$OS" = "zLinux" ]; then
  echo "build for Linux"
  cp ./CMakeLists_linux.txt ./CMakeLists.txt
elif [ "z$OS" = "zDarwin" ]; then
  echo "build for Darwin"
  cp ./CMakeLists_darwin.txt ./CmakeLists.txt
else
  echo "Unsupported Platform $OS"
  exit -1
fi

cd build
# By default LazyJIT is enabled, to disable it:
# cmake .. -DWAMR_BUILD_JIT=1 -DWAMR_BUILD_LAZY_JIT=0
cmake .. -DWAMR_BUILD_JIT=0 -DWAMR_BUILD_LIBC_BUILTIN=1 -DWAMR_BUILD_LAZY_JIT=0
make -j ${nproc}
cd ..
