#!/bin/bash

OPTS=""
if [[ $(uname) == Darwin ]]; then
  OPTS="--disable-openmp"
fi

./configure --prefix=${PREFIX}  \
            --host=${HOST}      \
            $OPTS

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install
