@ECHO ON

:: get the prefix in "mixed" form
set "LIBRARY_PREFIX_M=%LIBRARY_PREFIX:\=/%"

%BUILD_PREFIX%\Scripts\meson setup builddir ^
  --buildtype=release ^
  --prefix=%LIBRARY_PREFIX_M% ^
  --libdir=lib ^
  --default-library=shared ^
  --wrap-mode=nofallback ^
  -Dtests=enabled ^
  --backend=ninja
if errorlevel 1 exit 1

ninja -v -C builddir -j %CPU_COUNT%
if errorlevel 1 exit 1

ninja test -C builddir
if errorlevel 1 exit 1

ninja -C builddir install -j %CPU_COUNT%
if errorlevel 1 exit 1
