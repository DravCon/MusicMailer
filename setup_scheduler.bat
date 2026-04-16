@echo off
:: Creates a Windows Task Scheduler job that sends the newsletter every day at 08:00.
:: Run this once as Administrator (right-click → "Run as administrator").

setlocal

set TASK_NAME=MusicMailer
set SCRIPT_PATH=C:\DEV\MusicMailer\run_mailer.bat
set RUN_TIME=08:00

echo.
echo ╔══════════════════════════════════════════╗
echo ║        Music Mailer — Scheduler Setup    ║
echo ╚══════════════════════════════════════════╝
echo.

:: Remove old task if it exists (ignore errors)
schtasks /delete /tn "%TASK_NAME%" /f >nul 2>&1

:: Create the daily task
schtasks /create ^
  /tn  "%TASK_NAME%" ^
  /tr  "\"%SCRIPT_PATH%\"" ^
  /sc  daily ^
  /st  %RUN_TIME% ^
  /rl  highest ^
  /f

if %errorlevel% equ 0 (
    echo.
    echo  SUCCESS: Task "%TASK_NAME%" created.
    echo  The newsletter will be sent every day at %RUN_TIME%.
    echo.
) else (
    echo.
    echo  ERROR: Could not create task. Make sure you ran this as Administrator.
    echo.
    pause
    exit /b 1
)

echo  Useful commands:
echo    Check task    : schtasks /query  /tn "%TASK_NAME%" /fo LIST
echo    Run right now : schtasks /run    /tn "%TASK_NAME%"
echo    Delete task   : schtasks /delete /tn "%TASK_NAME%" /f
echo.
pause
