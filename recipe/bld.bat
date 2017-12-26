REM copy mpir headers
copy %LIBRARY_INC%\gmp-config.h src\config.h
copy %LIBRARY_INC%\gmp-longlong.h src\longlong.h
copy %RECIPE_DIR%\CMakeLists.txt CMakeLists.txt

mkdir build
cd build

cmake                                       ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%    ^
    ..

cmake --build . --config Release
cmake --build . --config Release --target install
copy %LIBRARY_LIB%\mpfr.lib %LIBRARY_LIB%\mpfr_static.lib

cmake                                       ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%    ^
    -DBUILD_SHARED_LIBS=yes                 ^
    ..

cmake --build . --config Release
cmake --build . --config Release --target install

