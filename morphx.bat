@echo off
setlocal enabledelayedexpansion

:: Set code page to UTF-8 to support emojis
chcp 65001 >nul

:: Define directories
set "dir1=.\ogg\FIRE"
set "dir2=.\ogg\RAIN"
set "dir3=.\ogg\SUNIK"
set "dir4=.\ogg\XENO"
set "dir5=.\ogg\CAVE"
set "dir6=.\ogg\CRYSTAL"
set "dir7=.\ogg\WOOD"
set "dir8=.\ogg\WATERFALL"
set "dir9=.\ogg\SEA"
set "dir10=.\ogg\AQUA"

:menu
cls
echo Please make a choice:
echo 1: FIRE
echo 2: RAIN
echo 3: WATER
echo 4: XENO
echo 5: CAVE
echo 6: CRYSTAL
echo 7: BAMBOO
echo 8: WATERFALL
echo 9: SEASHORE
echo 10: AQUATIC
echo q: Quit
echo.

set /p USER_INPUT="Enter your choice: "

if /i "%USER_INPUT%"=="q" goto :quit

:: Process selection
if "%USER_INPUT%"=="1" (set "target_dir=%dir1%" & goto :start_playback)
if "%USER_INPUT%"=="2" (set "target_dir=%dir2%" & goto :start_playback)
if "%USER_INPUT%"=="3" (set "target_dir=%dir3%" & goto :start_playback)
if "%USER_INPUT%"=="4" (set "target_dir=%dir4%" & goto :start_playback)
if "%USER_INPUT%"=="5" (set "target_dir=%dir5%" & goto :start_playback)
if "%USER_INPUT%"=="6" (set "target_dir=%dir6%" & goto :start_playback)
if "%USER_INPUT%"=="7" (set "target_dir=%dir7%" & goto :start_playback)
if "%USER_INPUT%"=="8" (set "target_dir=%dir8%" & goto :start_playback)
if "%USER_INPUT%"=="9" (set "target_dir=%dir9%" & goto :start_playback)
if "%USER_INPUT%"=="10" (set "target_dir=%dir10%" & goto :start_playback)

echo Invalid choice: %USER_INPUT%
echo Please try again.
timeout /t 2 >nul
goto :menu

:start_playback
echo You selected Option %USER_INPUT% (Press Ctrl+C to stop)
if not exist "%target_dir%" (
    echo Directory %target_dir% not found!
    pause
    goto :menu
)

pushd "%target_dir%"
:: Start ffplay for each .ogg file in the background
for %%f in (*.ogg) do (
    if exist "%%f" (
        :: 'start /B' runs the command in the background without a new window
        start /B "" ffplay -loop 0 -af "volume=0.5" -nodisp -autoexit "%%f" >nul 2>&1
    )
)
popd

:: Spinner / Waiting Logic
:spinner_loop
:: Check if ffplay is still running
tasklist /fi "IMAGENAME eq ffplay.exe" 2>NUL | find /I /N "ffplay.exe" >NUL
if "%ERRORLEVEL%"=="1" goto :end_playback

:: Animation frames
for %%a in ("Playing     " "Playing.    " "Playing..   " "Playing...  " "Playing.... " "Playing.....") do (
    cls
    echo %%~a
    echo Press Ctrl+C to stop and return to menu.
    
    :: Check again inside the animation loop for responsiveness
    tasklist /fi "IMAGENAME eq ffplay.exe" 2>NUL | find /I /N "ffplay.exe" >NUL
    if "%ERRORLEVEL%"=="1" goto :end_playback
    
    :: Wait 1 second
    timeout /t 1 /nobreak >nul
)
goto :spinner_loop

:end_playback
echo.
echo Playback finished or stopped.
taskkill /f /im ffplay.exe >nul 2>&1
pause
goto :menu

:quit
echo Quitting script.
:: Ensure all ffplay instances are closed on exit
taskkill /f /im ffplay.exe >nul 2>&1
exit /b
