#!/usr/bin/env bash

export REPO_PATH="$HOME/gitprojects/arrow"

export PARQUET_TEST_DATA="$REPO_PATH/cpp/submodules/parquet-testing/data"
export ARROW_TEST_DATA="$REPO_PATH/testing/data"
export ARROW_HOME="$REPO_PATH/dist"
export LD_LIBRARY_PATH="$REPO_PATH/dist/lib"
export CMAKE_PREFIX_PATH="$ARROW_HOME"

export PYARROW_CXXFLAGS='-g3 -ggdb3 -O0'
export PYARROW_WITH_PARQUET=1
export PYARROW_WITH_DATASET=1
export PYARROW_PARALLEL=1
export PYARROW_WITH_PARQUET_ENCRYPTION=0
