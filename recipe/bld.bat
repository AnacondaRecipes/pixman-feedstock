@echo off

set "PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig"

:: MMX is returning errors when linking cairo in 64 bit systems.
if %ARCH%==64 (
    set MMX_FLAG=disabled
) else (
    set MMX_FLAG=enabled
)

mkdir build
meson setup build ^
  --buildtype=release ^
  --default-library=shared ^
  --prefix=%LIBRARY_PREFIX% ^
  --wrap-mode=nofallback ^
  --backend=ninja ^
  --libdir=lib ^
  -Dmmx=%MMX_FLAG%

if errorlevel 1 exit 1

meson compile -v -C build -j %CPU_COUNT%
if errorlevel 1 exit 1

cd build && meson test
if errorlevel 1 exit 1

cd ..
meson install -C build
if errorlevel 1 exit 1