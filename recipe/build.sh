#!/bin/bash
set -u

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BUILD_PREFIX/lib/pkgconfig

export ADDITIONAL_MESON_ARGS=(
  --buildtype=release
  --prefix="${PREFIX}"
  --default-library=shared
  --wrap-mode=nofallback
  --libdir=lib
)

mkdir -p build
meson setup build ${ADDITIONAL_MESON_ARGS[@]}
meson compile -vC build -j ${CPU_COUNT}
cd build && meson test
cd ..
meson install -C build
