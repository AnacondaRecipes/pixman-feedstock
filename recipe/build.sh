#!/bin/bash

OPTS=""
if [[ $(uname) == Darwin ]]; then
  OPTS="--disable-openmp"
fi

./configure --prefix=$PREFIX $OPTS

<<<<<<< HEAD
make -j$CPU_COUNT
make check -j$CPU_COUNT
make install -j$CPU_COUNT
=======
make -j${CPU_COUNT}
make check
make install
>>>>>>> make in parallel and bump build number
