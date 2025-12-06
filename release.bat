@echo off
setlocal

if "%1"=="" (
    echo Usage: release.bat ^<version^>
    echo Example: release.bat 0.2.0
    exit /b 1
)

set VERSION=%1

echo Creating release v%VERSION%...

cd /d "%~dp0"

:: Check if binaries exist
if not exist "vali-gui-windows.exe" (
    echo Error: vali-gui-windows.exe not found. Run build.bat first.
    exit /b 1
)
if not exist "vali-gui-macos" (
    echo Error: vali-gui-macos not found. Run build.bat first.
    exit /b 1
)
if not exist "vali-gui-linux" (
    echo Error: vali-gui-linux not found. Run build.bat first.
    exit /b 1
)

:: Commit and push binaries
git add -A
git commit -m "v%VERSION%"
git push

:: Create GitHub release with binaries
gh release create "v%VERSION%" ^
    vali-gui-windows.exe ^
    vali-gui-macos ^
    vali-gui-linux ^
    --title "v%VERSION%" ^
    --notes "Vali GUI v%VERSION%"

echo.
echo Done! Release v%VERSION% created.
echo https://github.com/ccmdi/vali-gui-releases/releases/tag/v%VERSION%
