@echo on
set "UseEnv=true"

pushd src

rem Generate an MSVC solution for ARM64 from winpty's upstream winpty.gyp.
rem win-arm64.gypi supplies the ARM64 configuration that upstream
rem src/configurations.gypi only defines for Win32/x64.
"%BUILD_PREFIX%\python.exe" "%SRC_DIR%\gyp-next\gyp_main.py" ^
    -f msvs ^
    -G msvs_version=2022 ^
    -D target_arch=arm64 ^
    -D WINPTY_COMMIT_HASH=none ^
    -I "%RECIPE_DIR%\win-arm64.gypi" ^
    --depth=. winpty.gyp
if errorlevel 1 exit /b 1

msbuild winpty.sln /m ^
    /p:Configuration=Release ^
    /p:Platform=ARM64 ^
    /p:PlatformToolset=v143 ^
    /p:WindowsTargetPlatformVersion=%WindowsSDKVersion:\=%
if errorlevel 1 exit /b 1

copy Release\ARM64\winpty-agent.exe "%LIBRARY_BIN%\winpty-agent.exe"
if errorlevel 1 exit /b 1
copy Release\ARM64\winpty.dll "%LIBRARY_BIN%\winpty.dll"
if errorlevel 1 exit /b 1
copy Release\ARM64\winpty.lib "%LIBRARY_LIB%\winpty.lib"
if errorlevel 1 exit /b 1
copy include\*.h "%LIBRARY_INC%\"
if errorlevel 1 exit /b 1

popd
