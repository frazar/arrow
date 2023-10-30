#!/usr/bin/env bash

set -ueo pipefail

FOLDER=/home/frazar/gitprojects/arrow/python/pyarrow/tests/parquet

rm -f correct.parquet.hex
rm -f corrupted.parquet.hex

xxd "$FOLDER/correct.parquet" > correct.parquet.hex
xxd "$FOLDER/corrupted.parquet" > corrupted.parquet.hex

diff correct.parquet.hex corrupted.parquet.hex -uw | delta --light
# diff correct.parquet.hex corrupted.parquet.hex -yW 150
