#!/usr/bin/env bash

set -ueo pipefail

. zenv.sh

# Git submodule update
git submodule update --init

# Install python deps
# python3 -m venv pyarrow-dev
. ./pyarrow-dev/bin/activate
pip install -r python/requirements-build.txt

# This is the folder where we will install the Arrow libraries during
# development
mkdir -p dist

# Build C++ library
mkdir -p cpp/build
pushd cpp/build
cmake -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Debug \
\
      -DARROW_VERBOSE_LINT=ON \
      -DARROW_GGDB_DEBUG=ON \
      -DARROW_BUILD_TESTS=OFF \
      -DARROW_USE_ASAN=OFF \
      -DARROW_TESTING=OFF \
      -DARROW_USE_UBSAN=OFF \
      -DARROW_EXTRA_ERROR_CONTEXT=ON \
\
      -DARROW_AZURE=OFF \
      -DARROW_BUILD_TESTS=OFF \
      -DARROW_COMPUTE=OFF \
      -DARROW_CSV=ON \
      -DARROW_DATASET=ON \
      -DARROW_FILESYSTEM=OFF \
      -DARROW_FLIGHT=OFF \
      -DARROW_GANDIVA=OFF \
      -DARROW_GCS=OFF \
      -DARROW_HDFS=OFF \
      -DARROW_JEMALLOC=OFF \
      -DARROW_JSON=ON \
      -DARROW_ORC=OFF \
      -DARROW_PARQUET=ON \
      -DARROW_S3=OFF \
      -DARROW_SUBSTRAIT=OFF \
      -DARROW_WITH_BROTLI=OFF \
      -DARROW_WITH_BZ2=OFF \
      -DARROW_WITH_LZ4=OFF \
      -DARROW_WITH_SNAPPY=ON \
      -DARROW_WITH_ZLIB=OFF \
      -DARROW_WITH_ZSTD=OFF \
      -DPARQUET_REQUIRE_ENCRYPTION=OFF \
      ..
make -j1
make install
popd

pushd python
python setup.py build_ext --inplace --build-type=debug

pip install wheel
pip install -e . --no-build-isolation

popd
