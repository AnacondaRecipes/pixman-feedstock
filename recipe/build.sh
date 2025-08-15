#!/bin/bash

set -ex

meson_config_args=()

if [[ $(uname) == Darwin ]]; then
  meson_config_args+=(-Dopenmp=disabled)
fi

if [ "${target_platform}" == osx-arm64 ]; then
  meson_config_args+=(-Da64-neon=disabled)
fi

meson_config_args+=(-Dtests=enabled)

meson setup builddir \
    ${MESON_ARGS} \
    "${meson_config_args[@]}" \
    --prefix=$PREFIX \
    -Dlibdir=lib \
    --default-library=shared \
    --wrap-mode=nofallback \

ninja -v -C builddir -j ${CPU_COUNT}
ninja test -C builddir
ninja -C builddir install -j ${CPU_COUNT}
