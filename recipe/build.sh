#!/bin/bash

# Get an updated config.sub and config.guess
cp -r ${BUILD_PREFIX}/share/libtool/build-aux/config.* .

OPTS=""
if [[ $(uname) == Darwin ]]; then
  OPTS="--disable-openmp"
fi
if [ "${target_platform}" == linux-ppc64le ]; then
  OPTS="--disable-vmx "
fi

./configure --prefix=${PREFIX}  \
            --host=${HOST}      \
            $OPTS

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make installa

# We can remove this when we start using the new conda-build.
find $PREFIX -name '*.la' -delete

