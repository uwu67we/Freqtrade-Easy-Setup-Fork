@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (powershell -Command "Start-Process '%~f0' -Verb RunAs" & exit /b)

call "%~dp0service.bat"
powershell -ExecutionPolicy Bypass -File "%~dp0setup.ps1"