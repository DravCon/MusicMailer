@echo off
:: Wrapper called by Windows Task Scheduler.
:: Activates a venv if present, then runs the mailer.

cd /d "C:\DEV\MusicMailer"

:: Use venv Python if it exists, otherwise fall back to system Python
if exist ".venv\Scripts\python.exe" (
    ".venv\Scripts\python.exe" music_mailer.py
) else (
    python music_mailer.py
)
