@echo off

echo ===============================
echo == NMKD'S FLOWFRAMES BUILDER ==
echo ===============================
echo.
echo This script makes a build ready for distribution by creating three 7z archives, without python, with pytorch for Turing, and with pytorch for Ampere.
echo.

set "ver=16"
set /p ver="Enter the version number: "

cd ..

dotnet publish -c Release -o "Release/Build" "Code"

cd Release

rmdir /s/q FlowframesApp%ver%
mkdir "FlowframesApp%ver%"
mkdir "FlowframesApp%ver%/FlowframesData"
mkdir "FlowframesApp%ver%/FlowframesData/pkgs"

rem xcopy "../pkgs" "FlowframesApp%ver%/FlowframesData\pkgs\" /E
xcopy "../pkgs/av" "FlowframesApp%ver%/FlowframesData\pkgs\av" /E /I
xcopy "../pkgs/dain-ncnn" "FlowframesApp%ver%/FlowframesData\pkgs\dain-ncnn" /E /I
xcopy "../pkgs/licenses" "FlowframesApp%ver%/FlowframesData\pkgs\licenses" /E /I
xcopy "../pkgs/rife-cuda" "FlowframesApp%ver%/FlowframesData\pkgs\rife-cuda" /E /I
xcopy "../pkgs/rife-ncnn" "FlowframesApp%ver%/FlowframesData\pkgs\rife-ncnn" /E /I

echo %ver% >> "FlowframesApp%ver%/FlowframesData/ver.ini"

xcopy "Build\Flowframes.exe" "FlowframesApp%ver%"

cd ..\Build

rmdir /s/q ..\Release\FlowframesApp%ver%\FlowframesData\logs
del ..\Release\FlowframesApp%ver%\FlowframesData\config.ini


del FF-%ver%-Slim.7z
7za.exe a FF-%ver%-Slim.7z -m0=flzma2 -mx5 "..\Release\FlowframesApp%ver%"


rmdir /s/q ..\Release\FlowframesApp%ver%


rem pause