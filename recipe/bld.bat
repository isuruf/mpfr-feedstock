set mpfr_root=%cd%
cd ..
mkdir mpir
xcopy %PREFIX%\mpir mpir\ /E

cd %mpfr_root%\build.vc14

if "%ARCH%"=="32" (
    set PLATFORM=Win32
) else (
    set PLATFORM=x64
)

msbuild.exe /p:Platform=%PLATFORM% /p:Configuration=Release lib_mpfr\lib_mpfr.vcxproj

REM msbuild.exe /p:Platform=%PLATFORM% /p:Configuration=Release lib_mpfr_tests\lib_tests\lib_tests.vcxproj
REM python %mpfr_root%\build.vc14\run_lib_tests.py

mkdir %PREFIX%\mpfr\lib\%PLATFORM%\Release
xcopy lib %PREFIX%\mpfr\lib\ /E

cd ..
xcopy lib %PREFIX%\mpfr\lib\ /E

