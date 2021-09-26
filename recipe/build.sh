#!/bin/bash

set -ex

mkdir -p build
pushd build
cmake ${CMAKE_ARGS} -GNinja \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  ..
ninja install
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
  ctest --output-on-failure -E tls_download_medium_file_h2
fi
popd
