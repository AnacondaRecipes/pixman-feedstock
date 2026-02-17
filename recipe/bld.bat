@ECHO ON

:: get the prefix in "mixed" form
set "LIBRARY_PREFIX_M=%LIBRARY_PREFIX:\=/%"

set "EXTRA_MESON_ARGS="
if "%ARCH%"=="arm64" (
  set "EXTRA_MESON_ARGS=-Da64-neon=disabled -Dmmx=disabled -Dsse2=disabled -Dssse3=disabled"
)

%BUILD_PREFIX%\Scripts\meson setup builddir ^
  --buildtype=release ^
  --prefix=%LIBRARY_PREFIX_M% ^
  --libdir=lib ^
  --default-library=shared ^
  --wrap-mode=nofallback ^
  -Dtests=enabled ^
  --backend=ninja ^
  %EXTRA_MESON_ARGS%
if errorlevel 1 exit 1

ninja -v -C builddir -j %CPU_COUNT%
if errorlevel 1 exit 1

ninja test -C builddir
if errorlevel 1 exit 1

ninja -C builddir install -j %CPU_COUNT%
if errorlevel 1 exit 1
